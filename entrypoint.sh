#!/bin/sh

# Global variables
DIR_CONFIG="/etc/xray"
DIR_RUNTIME="/usr/bin"
DIR_TMP="$(mktemp -d)"

uuid1=ad806411-2d26-4636-98b6-ab85cc8221f1
mypath1=/myfdsave-fsfdsaa1
myport1=10010
uuid2=218a184b-96d6-4427-84a7-9af8519f4106
mypath2=/myfdsave-fsfdsaa2
myport2=10011
uuid3=097759e8-22dd-40a6-aee7-eb92269d5eec
mypath3=/myfdsave-fsfdsaa3
myport3=10012
uuid4=e87b0228-1ff4-4582-8386-40da853029ac
mypath4=/myfdsave-fsfdsaa4
myport4=10013
uuid5=f6f265b9-2086-4012-b0b5-7a4f69378c7b
mypath5=/myfdsave-fsfdsaa5
myport5=10014


# Write V2Ray configuration
cat << EOF > ${DIR_TMP}/myconfig.pb
{
	"inbounds": [
		{
			"table": "table1",
			"port": $myport1,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$uuid1"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "$mypath1"
				}
			}
		},{
			"table": "table2",
			"port": $myport2,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$uuid2"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "$mypath2"
				}
			}
		},{
			"table": "table3",
			"port": $myport3,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$uuid3"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "$mypath3"
				}
			}
		},{
			"table": "table4",
			"port": $myport4,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$uuid4"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "$mypath4"
				}
			}
		},{
			"table": "table5",
			"port": $myport5,
			"protocol": "vless",
			"settings": {
				"clients": [
					{
						"id": "$uuid5"
					}
				],
			"decryption": "none"
		},
		"streamSettings": {
			"network": "ws",
			"wsSettings": {
					"path": "$mypath5"
				}
			}
		}
	],
	"outbounds": [
		{
			"protocol": "freedom"
		}
	]
}
EOF

# Get V2Ray executable release
curl --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o ${DIR_TMP}/xray_dist.zip
unzip ${DIR_TMP}/xray_dist.zip -d ${DIR_TMP}

# Convert to protobuf format configuration
mkdir -p ${DIR_CONFIG}
mv -f ${DIR_TMP}/myconfig.pb ${DIR_CONFIG}/myconfig.json

# Install V2Ray
install -m 755 ${DIR_TMP}/xray ${DIR_RUNTIME}
rm -rf ${DIR_TMP}

# Run V2Ray
#${DIR_RUNTIME}/xray -config=${DIR_CONFIG}/myconfig.json
