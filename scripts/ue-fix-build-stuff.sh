#!/usr/bin/zsh

# First we create the "good" compile_commands.json
/Users/Shared/Epic\ Games/UE_5.1/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.sh \
	-project="$PWD/$(basename $PWD).uproject" -game -CMakefile

cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .

# Remove the bloated Makefile
rm Makefile

# Create a simple makefile
/Users/Shared/Epic\ Games/UE_5.1/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.sh \
	-project="$PWD/$(basename $PWD).uproject" -game -Makefile

# Correct the the makefile becase we are _not_ on Linux

sed -i -E "s/^PROJECT.*//g" Makefile
sed -i -E "s/Linux/Mac/g" Makefile
sed -i -E "s/PROJECTBUILD/BUILD/g" Makefile

# We are all set now

echo "Use the command:"
echo "make $(basename $PWD)Editor"
echo "to get hotloading"
