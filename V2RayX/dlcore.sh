VERSION="4.27.5"
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NORMAL='\033[0m'

cd "$SRCROOT"
output="v0"
if [[ -f ./v2ray-core-bin/v2ray ]]; then
    output=$(./v2ray-core-bin/v2ray --version)
fi
existingVersion=${output:6:${#VERSION}}
if [ "$VERSION" != "$existingVersion" ]; then
    getCore=0
    mkdir -p v2ray-core-bin
    cd v2ray-core-bin
    curl -s -L -o v2ray-macos-64.zip https://github.com/v2ray/v2ray-core/releases/download/v${VERSION}/v2ray-macos-64.zip
    if [[ $? == 0 ]]; then
        unzip -o v2ray-macos-64.zip
        getCore=1
    else
        unzip -o ~/Downloads/v2ray-macos-64.zip
        if [[ $? != 0 ]]; then
            getCore=0
        else
            chmod +x v2ray-${VERSION}-macos-64/v2ray
            output=$(v2ray-${VERSION}-macos-64/v2ray --version)
            existingVersion=${output:6:${#VERSION}}
            if [ "$VERSION" != "$existingVersion" ]; then
                echo "${RED}v2ray-macos-64.zip in the Downloads folder does not contain version ${VERSION}."
                echo "下载文件夹里的v2ray-macos-64.zip不是${VERSION}版本。${NORMAL}"
                getCore=0
            else
                getCore=1
            fi
        fi
    fi
    if [[ $getCore == 0 ]]; then
        echo "${RED}download failed!"
        echo "Use whatever method you can think of, get v2ray-macos-64.zip of version ${VERSION} from https://github.com/v2ray/v2ray-core/releases, and put it in the folder 'Downloads' and try this script again."
        echo "用你能想到任何办法，从 https://github.com/v2ray/v2ray-core/releases 下载好${VERSION}版本的 v2ray-macos-64.zip，放在“下载”文件夹里面，然后再次运行这个脚本。${NORMAL}"
        exit 1
    fi
    chmod +x ./v2ray
    chmod +x ./v2ctl
    rm -r v2ray-*
else
    exit 0
fi

