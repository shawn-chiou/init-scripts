#!/bin/bash

if which wget >/dev/null 2>&1; then
    GET="wget --quiet --output-document=/dev/stdout"
elif which curl > /dev/null 2>&1; then
    GET="curl --insecure --location --silent --show-error"
else
    echo "No download tool found"
    exit 1
fi

echo "install nvim..."
nvim=`$GET https://github.com/neovim/neovim/releases | sed -n 's/.*href="\(.*nvim-linux64.tar.gz\)".*/\1/p' | head -n1`
mkdir -p $HOME/opt
cd $HOME/opt && $GET https://github.com/$nvim | tar zxf - 
if ! grep 'alias nvim' ~/.bashrc; then
    echo "alias nvim='$HOME/opt/nvim-linux64/bin/nvim'" >> ~/.bashrc
fi

echo "install lazyvim..."
if [ -d $HOME/.config/nvim ]; then
    echo "$HOME/.config/nvim existed, mv to $HOME/.config/nvim.bak"
    rm -rf $HOME/.config/nvim.bak
    mv -f $HOME/.config/nvim $HOME/.config/nvim.bak
fi
mkdir -p $HOME/.config/nvim
git clone https://github.com/LazyVim/starter $HOME/.config/nvim

echo "install nerd font..."
jetbrain=`$GET https://github.com/ryanoasis/nerd-fonts/releases | sed -n 's/.*href="\(.*JetBrain.*.tar.xz\)".*/\1/p' | head -n1`
mkdir -p $HOME/.fonts/JetBrains
cd $HOME/.fonts/JetBrains && $GET $jetbrain | tar Jxf -
cd $HOME/.fonts && mkfontscale

echo "run 'nvim' for neovim! Have Fun !!"

read -p "Install optional kitty terminal? (y/n) " installkitty
[ "`echo $installkitty | sed -n '/[Yy]\([Ee][Ss]\?\)\?/p'`" ] || exit 0

echo "install kitty terminal..."
kitty_version=`$GET https://github.com/kovidgoyal/kitty/releases | sed -n 's|.*releases/download/\(.*\)/.*|\1|p' | head -n1`
mkdir -p $HOME/opt
echo https://github.com/kovidgoyal/kitty/releases/download/$kitty_version/kitty-${kitty_version:1}-x86_64.txz
cd $HOME/opt && $GET https://github.com/kovidgoyal/kitty/releases/download/$kitty_version/kitty-${kitty_version:1}-x86_64.txz | tar Jxf -
if ! grep 'alias kitty' ~/.bashrc; then
    echo "alias kitty='sh -c \"export GLFW_IM_MODULE=ibus\" && $HOME/opt/kitty/bin/kitty'" >> ~/.bashrc
fi
echo "run kitty to start the kitty terminal and invoke nvim inside kitty terminal"
