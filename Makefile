PACKER_PATH = "/Users/james/.local/share/nvim/site/pack/packer/start/packer.nvim"

ifeq ("$(wildcard $(PACKER_PATH))", "")
	PACKER_EXISTS = false
else
	PACKER_EXISTS = true
endif

install:
	@echo $(PACKER_EXISTS)
	@# Bootstrap Packer, our Neovim package manager.
	@git clone --depth 1 git@github.com:wbthomason/packer.nvim $(PACKER_PATH) < /dev/null

	@mkdir -p ~/.config/nvim/lua
	@ln -sF neovim/init.lua ~/.config/nvim/init.lua
	@ln -sF neovim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua
