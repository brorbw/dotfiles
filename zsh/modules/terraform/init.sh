#  _____ ___ ___ ___    _   ___ ___  ___ __  __
# |_   _| __| _ \ _ \  /_\ | __/ _ \| _ \  \/  |
#   | | | _||   /   / / _ \| _| (_) |   / |\/| |
#   |_| |___|_|_\_|_\/_/ \_\_| \___/|_|_\_|  |_|
alias tf='terraform'
alias tfa='tf apply'
alias tfaa='tf apply -auto-approve'
alias tfi='tf init'
alias tfp='tf plan'
alias tfr='tf refresh'
alias tfv='tf validate'
alias tfw='tf workspace'
alias tfwl='tfw list'
alias tfws='tfw select'

function tfvars() {
	readonly WORKSPACE=$(terraform workspace show)
	readonly ENVIRONMENT=$(echo $WORKSPACE | sed 's/[0-9]*$//g')

	if [[ -e "vars-$WORKSPACE.tfvars" ]]; then
		readonly VAR_FILE="-var-file vars-$WORKSPACE.tfvars"
	elif [[ -e "../vars-$WORKSPACE.tfvars" ]]; then
		readonly VAR_FILE="-var-file ../vars-$WORKSPACE.tfvars"
	elif [[ -e "../vars-$ENVIRONMENT.tfvars" ]]; then
		readonly VAR_FILE="-var-file ../vars-$ENVIRONMENT.tfvars"
	fi

	if [[ -e "vars-$WORKSPACE-secrets.tfvars" ]]; then
		readonly SECRET_FILE="-var-file vars-$WORKSPACE-secrets.tfvars"
	elif [[ -e "../vars-$WORKSPACE-secrets.tfvars" ]]; then
		readonly SECRET_FILE="-var-file ../vars-$WORKSPACE-secrets.tfvars"
	elif [[ -e "../vars-$ENVIRONMENT-secrets.tfvars" ]]; then
		readonly SECRET_FILE="-var-file ../vars-$ENVIRONMENT-secrets.tfvars"
	fi

	echo "$ terraform $1 $VAR_FILE $SECRET_FILE ${@:2} # workspace=$WORKSPACE"
	eval $(echo terraform $1 $VAR_FILE $SECRET_FILE ${@:2})
}

alias tfva='tfvars apply'
# alias tfvaaa='tfvars apply -auto-approve'
alias tfvr='tfvars refresh'
