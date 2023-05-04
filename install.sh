PACKER_PATH="~/.local/share/nvim/site/pack/packer/start/packer.nvim"
PACKER_INSTALLED=false

if test -f "$PACKER_PATH"; then
	PACKER_INSTALLED=true
fi

echo $PACKER_INSTALLED
@# Bootstrap Packer, our Neovim package manager.
@git clone --depth 1 git@github.com:wbthomason/packer.nvim $(PACKER_PATH) < /dev/null

@mkdir -p ~/.config/nvim/lua
@ln -sF neovim/init.lua ~/.config/nvim/init.lua
@ln -sF neovim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua
