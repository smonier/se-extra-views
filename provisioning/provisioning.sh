# Provisioning Industrial module
export PROVISIONING_SERVER_URL=http://localhost:8080

# Industrial
curl -v -u root:root --request POST \
--url $PROVISIONING_SERVER_URL/modules/api/provisioning \
--header 'Content-Type: application/yaml' \
--data '- include: https://raw.githubusercontent.com/hduchesne/industrial/main/provisioning/industrial.yaml'