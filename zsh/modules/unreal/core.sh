function UnrealPath {
	if [[ "$OSTYPE"	== "darwin"* ]]; then
		echo "$HOME/Projects/UnrealEngine/Engine/Build/BatchFiles/Mac"
	else
		echo "$HOME/Projects/UnrealEngine/Engine/Build/BatchFiles/Linux"
	fi
}

function isProject {
	if [[ -z $PWD/$(basename $PWD).uproject ]]; then
		echo "No project file found"
		exit 1
	fi
}

function isUnrealEngine {
	if [[ -z $PWD/$(basename $PWD).uprojectdirs ]]; then
		echo "Not in engine directory"
		exit 1
	fi
}

function cleanUnrealEngineBuild {
	isUnrealEngine
	echo "---------------------------------\nCleaning Unreal Engine repository\n---------------------------------\n"
	rm -r ./FeaturePacks
	rm -r ./*.xcworkspace
	rm UE5.sln
	rm cpp.hint
}

function initUnrealEngine {
	isUnrealEngine
	echo "--------------------------\nInitializing Unreal Engine\n--------------------------\n"
	$HOME/Projects/UnrealEngine/Setup.sh
	echo "\nGenerating Project files\n------------------------"
	$HOME/Projects/UnrealEngine/GenerateProjectFiles.sh
}

function buildUnrealEngine {
	isUnrealEngine

	ps aux | grep Unreal | awk '{print $2}' | xargs pkill # kill zombie builder if it exists because unreal sux

	echo "----------------------\nBuilding Unreal Engine\n----------------------\n"
	XCODE_WORKSPACE_FILE=$(find . -name *\(Mac\)* -maxdepth 1 || find . -name *.xcworkspace -maxdepth 1) > /dev/null
	if (find . -name *\(Mac\)* -maxdepth 1); then
		BUILD_TARGET="UnrealEditor"
	else
		BUILD_TARGET="UE5"
	fi
	echo "\nBuilding ShaderCompileWorker\n----------------------------"
	xcodebuild -workspace $XCODE_WORKSPACE_FILE -scheme ShaderCompileWorker build
	echo "\nBuilding Engine\n---------------"
	xcodebuild -workspace $XCODE_WORKSPACE_FILE -scheme $BUILD_TARGET build
}

function initUnrealProject {
	isProject
	echo "---------------------------\nInitializing Unreal Project\n---------------------------\n"

	# First we create the "good" compile_commands.json
	$(UnrealPath)/GenerateProjectFiles.sh \
		-project="$PWD/$(basename $PWD).uproject" -game -CMakefile

	cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
	# Remove the bloated Makefile
	rm Makefile

	# Create a simple makefile
	$(UnrealPath)/GenerateProjectFiles.sh \
		-project="$PWD/$(basename $PWD).uproject" -game -Makefile

	# Correct the the makefile becase we are _not_ on Linux

	if [[ "$OSTYPE"	== "darwin"* ]]; then
		sed -i -E "s/^PROJECT.*//g" Makefile
		sed -i -E "s/Linux/Mac/g" Makefile
		sed -i -E "s/PROJECTBUILD/BUILD/g" Makefile

		# Lastly we generate xcode project files for use with xcodebuild
		$(UnrealPath)/GenerateProjectFiles.sh \
			-project="$PWD/$(basename $PWD).uproject" -game -XCodeProjectFiles
	fi

	# We are all set now
	echo "Use the command:"
	echo "make $(basename $PWD)Editor"
	echo "to get hotloading"
}

function buildUnrealGame {
	isProject
	echo "Building Unreal Project"
	$HOME/Projects/UnrealEngine/Engine/Build/BatchFiles/Mac/Build.sh -ForceHotReload \
		$1 Mac Development -Project="$PWD/$(basename $PWD).uproject" -IgnoreJunk
}

function xcodeListTargets {
	XCODE_WORKSPACE_FILE=$(find . -name *\(Mac\)* -maxdepth 1 || find . -name *.xcworkspace -maxdepth 1) > /dev/null
	xcodebuild -list -workspace $XCODE_WORKSPACE_FILE
}

function determineWhatToBuild {
	if [[ -f "$PWD/$(basename $PWD).uproject" ]]; then
		buildUnrealGame "$@"
	elif [[ -f "$PWD/Default.uprojectdirs" ]]; then
		buildUnrealEngine
	fi
}

function determineWhatToInit {
	if [[ -f "$PWD/$(basename $PWD).uproject" ]]; then
		initUnrealProject "$@"
	elif [[ -f "$PWD/Default.uprojectdirs" ]]; then
		initUnrealEngine
	fi
}

# Cook command from unreal
# "/Users/nah/Projects/UnrealEngine/Engine/Build/BatchFiles/RunUAT.command"  -ScriptsForProject="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" Turnkey -command=VerifySdk -platform=Mac -UpdateIfNeeded -project="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook  -project="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" -target=ThirdPersonMP  -unrealexe="/Users/nah/Projects/UnrealEngine/Engine/Binaries/Mac/UnrealEditor.app/Contents/MacOS/UnrealEditor" -platform=Mac -skipstage -nocompile -nocompileuat
# Package
# "/Users/nah/Projects/UnrealEngine/Engine/Build/BatchFiles/RunUAT.command"  -ScriptsForProject="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" Turnkey -command=VerifySdk -platform=Mac -UpdateIfNeeded -project="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" BuildCookRun -nop4 -utf8output -nocompileeditor -skipbuildeditor -cook  -project="/Users/nah/Documents/Unreal Projects/ThirdPersonMP/ThirdPersonMP.uproject" -target=ThirdPersonMP  -unrealexe="/Users/nah/Projects/UnrealEngine/Engine/Binaries/Mac/UnrealEditor.app/Contents/MacOS/UnrealEditor" -platform=Mac -stage -archive -package -build -pak -compressed -prereqs -archivedirectory="/Users/nah/Desktop/TestExport" -clientconfig=Debug -nocompile -nocompileuat
function cookProject {
	PROJECT_PATH="$PWD/$(basename $PWD)"
	/Users/nah/Projects/UnrealEngine/Engine/Build/BatchFiles/RunUAT.sh BuildCookRun -platform=Mac -project="${PROJECT_PATH}.uproject" -archivedirectory="/Users/nah/Desktop/TestExport" -build -cook -stage -pak
}

function _unreal {
	command=$1
	case $command in
		"list" | "l")
			xcodeListTargets
			;;
		"build" | "b")
			shift 1
			determineWhatToBuild "$@"
			;;
		"init" | 'i')
			shift 1
			determineWhatToInit "$@"
			;;
		"cook")
			shift 1
			cookProject
			;;
		"clean")
			cleanUnrealEngineBuild
			;;
		"open")
			open -a /Volumes/Unreal/UnrealEngine/Engine/Binaries/Mac/UnrealEditorServices.app .
			;;
		*)
			echo "Unknown command"
			;;
	esac
}

_unreal "$@"
