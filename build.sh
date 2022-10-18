#!/bin/bash
STARTTIME=$(date +%s)
NODE_VERSION=10.24.1
branch_name=$1
commit_hash=$2
echo "Starting editor build from build.sh"
set -euo pipefail	
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install $NODE_VERSION
nvm use $NODE_VERSION
export framework_version_number=$branch_name
export editorType="CollectionEditor"
export editor_version_number=$branch_name
export version_number=${branch_name}
export build_number=$commit_hash
export CHROME_BIN=google-chrome
rm -rf ansible/collection-editor.zip
rm -rf collection-editor
sudo apt-get install build-essential libpng-dev
npm cache clean --force
node -v
npm install
cd app
bower cache clean
bower install --force
cd ..
gulp packageCorePlugins
npm run collection-plugins
npm run build
npm run test
