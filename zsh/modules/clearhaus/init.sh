export PATH_TO_TOOLCHAIN="$HOME/clearhaus/toolchain"
export PATH="$PATH:$HOME/clearhaus/toolchain/bin"

function unlock-aws-pci-stag() {
	eval $(op signin)
	aws_pci_stag_credentials=$(op item get aws-pci-stag --format json 2>/dev/null)
	export AWS_REGION=$(echo $aws_pci_stag_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_REGION").value')
	export AWS_ACCESS_KEY_ID=$(echo $aws_pci_stag_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_ACCESS_KEY_ID").value')
	export AWS_SECRET_ACCESS_KEY=$(echo $aws_pci_stag_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_SECRET_ACCESS_KEY").value')
}

function unlock-aws-pci-prod() {
	eval $(op signin)
	aws_pci_prod_credentials=$(op item get aws-pci-prod --format json 2>/dev/null)
	export AWS_REGION=$(echo $aws_pci_prod_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_REGION").value')
	export AWS_ACCESS_KEY_ID=$(echo $aws_pci_prod_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_ACCESS_KEY_ID").value')
	export AWS_SECRET_ACCESS_KEY=$(echo $aws_pci_prod_credentials | jq --raw-output '.fields[] | select(."label" == "AWS_SECRET_ACCESS_KEY").value')
}

function vdc-unlock() {
	cd ~/clearhaus/pci-procesr-cluster > /dev/null
	git-crypt unlock
	VALUE=$(grep vd_http_basic_auth_username vars-test-secrets.tfvars | sed -r 's/[^"]+"([^"]+)"$/\1/')
	export VD_HTTP_BASIC_AUTH_USERNAME="$VALUE"
	VALUE=$(grep vd_http_basic_auth_password vars-test-secrets.tfvars | sed -r 's/[^"]+"([^"]+)"$/\1/')
	export VD_HTTP_BASIC_AUTH_PASSWORD="$VALUE"
	VALUE=$(grep vd_mle_key_id vars-test-secrets.tfvars | sed -r 's/[^"]+"([^"]+)"$/\1/')
	export VD_MLE_KEY_ID="$VALUE"
	cd - > /dev/null
}
