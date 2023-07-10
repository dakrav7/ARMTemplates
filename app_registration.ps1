Install-Module -Name AzureAD -Force
Import-Module -Name AzureAD
application=$(az ad app create --display-name $AzureADApplicationName)
applicationObjectId=$(jq -r '.id' <<< \"$application\")
applicationClientId=$(jq -r '.appId' <<< \"$application\")
servicePrincipal=$(az ad sp create --id $applicationObjectId)
servicePrincipalObjectId=$(jq -r '.id' <<< \"$servicePrincipal\")
outputJson=$(jq -n \\\n                --arg applicationObjectId \"$applicationObjectId\" \\\n                --arg applicationClientId \"$applicationClientId\" \\\n                --arg servicePrincipalObjectId \"$servicePrincipalObjectId\" \\\n                '{applicationObjectId: $applicationObjectId, applicationClientId: $applicationClientId, servicePrincipalObjectId: $servicePrincipalObjectId}' )
echo $outputJson > $AZ_SCRIPTS_OUTPUT_PATH