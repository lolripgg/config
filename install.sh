PACKER_PATH="/Users/james/.local/share/nvim/site/pack/packer/start/packer.nvim"
NVIM_CONFIG_PATH="/Users/james/.config/nvim"
NVIM_CONFIG_GIT_PATH="/Users/james/workspace/config/neovim"

if ! [[ -d $PACKER_PATH ]]
then
	# Bootstrap Packer, our Neovim package manager.
	git clone -q --depth 1 git@github.com:wbthomason/packer.nvim $PACKER_PATH < /dev/null
fi

mkdir -p $NVIM_CONFIG_PATH/lua
ln -sF $NVIM_CONFIG_GIT_PATH/init.lua $NVIM_CONFIG_PATH/init.lua
ln -sF $NVIM_CONFIG_GIT_PATH/lua/keymaps.lua $NVIM_CONFIG_PATH/lua/keymaps.lua
ln -sF $NVIM_CONFIG_GIT_PATH/lua/options.lua $NVIM_CONFIG_PATH/lua/options.lua
ln -sF $NVIM_CONFIG_GIT_PATH/lua/plugins.lua $NVIM_CONFIG_PATH/lua/plugins.lua

echo "\033[1;32mSuccess!\033[0m"
