#!/bin/bash

# Append setting
cat >> ~/.bashrc << EOF

export PROMPT_COMMAND='PS1X=\$(p="\${PWD#\${HOME}}"; [ "\${PWD}" != "\${p}" ] && printf "~";IFS=/; for q in \${p:1}; do printf /\${q:0:1}; done; printf "\${q:1}")'

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/(\\1)/'
}

check_git_dirty() {
	[[ \\$(git status --porcelain 2> /dev/null | wc -l) > 0 ]] && echo '*'
}

if [ "\$color_prompt" = yes ]; then
    PS1='\${debian_chroot:+(\$debian_chroot)}\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\${PS1X}\[\\033[00m\\]-\$(parse_git_branch)\$(check_git_dirty)-\\$ '
else
    PS1='\${debian_chroot:+(\$debian_chroot)}\\u@\\h:\${PS1X}-\$(parse_git_branch)\$(check_git_dirty)-\\$ '
fi
unset color_prompt force_color_prompt
alias rdesktop='rdesktop -a 16 -z -r clipboard:CLIPBOARD'
export EDITOR=vim
EOF

#echo "alias rdesktop='rdesktop -a 16 -z -r clibboard:CLIPBOARD'" >> ~/.bashrc
#echo "export EDITOR=vim" >> ~/.bashrc

if [ -x /usr/bin/git ]; then
	# Set up git config
	git config --global core.quotepath false
	git config --global user.name "Shawn C.H. Chiu"
	git config --global user.email ""
	git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit"
	git config --global alias.tree "log --graph --all --format=format:'%C(auto)%h %C(reset)%C(white)%s%C(reset) %C(cyan)[%an]%C(green),%ar%C(reset) %C(cyan)(%cn)%C(green),%cr%C(reset) %C(auto)%d%C(reset)'"
	git config --global commit.template ~/.gitmessage.txt
	git clone https://github.com/sandeepcr529/Buffet.vim ~/Buffet.vim

	# Create vim plugin
	mkdir -p ~/.vim
	cp -r ~/Buffet.vim/plugin ~/.vim
	rm -rf ~/Buffet.vim
fi

# Create .gitmessage.txt
if [ -f ~/.gitmessage.txt ]; then
	rm ~/.gitmessage.txt
fi

cat > ~/.gitmessage.txt << EOF
#[#ISSUE][TYPE](Component) What ?
[#issue][feat]() add/remove users to sign in using their username or email address
[#issue][fix]() fix/remove error message in an example
[#issue][docs]() add/update/remove task name in readme
[#issue][test]() add user test for sign in
[#issue][refactor]() update/rename funcion-A to fuction-B
[#issue][style]() use four spaces instead of tabs
[#issue][perf]() faster function-A implementation
[#issue][chore]() add/update building task
# How ?
# Why ?
# [ref]
# * http://
# * [#issue_id]
EOF

# Create .vimrc
if [ -f ~/.vimrc ]; then
	rm ~/.vimrc
fi

if [ -f ~/.vim/plugin/buffet.vim ]; then
	cat > ~/.vimrc << EOF
map <F2> :Bufferlist<CR>
EOF
fi

# Append other setting
cat > ~/.vimrc << EOF
set ai
set background=dark
"set cindent
set cursorline
"set enc=utf8
"set fileencodings=utf-8,big5,utf-bom,iso8859-1
"set hls
set laststatus=2
set nu
set showmatch
"set expandtab shiftwidth=4 tabstop=4

syntax on

autocmd BufRead *.jsx,*.js,*.php,*.css,*.scss set ai et sw=4 ts=4 softtabstop=4
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Remove any trailing whitespace that is in the file
EOF

# Set up SSH shared connection
if [ -f ~/.ssh/config ]; then
	rm ~/.ssh/config
fi

mkdir -p ~/.ssh
touch ~/.ssh/config

cat > ~/.ssh/config << EOF
Host *
ControlPath /tmp/%r@%h:%p
ControlMaster auto
EOF

