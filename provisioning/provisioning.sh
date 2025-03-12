# Provisioning Industrial module
export PROVISIONING_SERVER_URL=https://elysium-jahiasales.internal.cloud.jahia.com

# Industrial
curl -v -u root:Elysium2024! --request POST \
--url $PROVISIONING_SERVER_URL/modules/api/provisioning \
--header 'Content-Type: application/yaml' \
--data '- include: https://raw.githubusercontent.com/hduchesne/industrial/refs/heads/main/provisioning/industrial.yaml'