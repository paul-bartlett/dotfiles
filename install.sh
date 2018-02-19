
#!/bin/bash

# SCRIPT TO INSTALL MY IMPORTANT DOTFILES AND PLUGINS TO USER DIR

which sudo &>/dev/null
[ $? -eq 0 ] && echo "sudo found. Starting install.sh..." || (echo "sudo is not installed! Please install sudo." && read && exit 1)

#### XBPS ####

read -p "Do you want to install required packages via xbps? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Update sources
    sudo xbps-install -Syu

    # Install Reqired packages
    sudo xbps-install -S xorg xterm xclip curl git cmake python3 python3-pip neovim rxvt-unicode zsh i3 i3lock i3status dunst dmenu firefox font-awesome
fi

#### ZSH ####

read -p "Do you want to install Zsh themes, scripts and plugins? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Installing Oh-my-zsh, please exit Zsh after install. Press Enter to continue..."
    read
    echo "Preparing.."

    # Install Oh-My-Zsh
    TEST_CURRENT_SHELL="zsh"   # Prevent zsh launch
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Zsh-Autosuggestions
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    # Zsh-Syntax Highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    # Zsh-Bullet Train theme
    mkdir ~/.oh-my-zsh/custom/themes
    curl https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -o ~/.oh-my-zsh/custom/themes/bullet-train.zsh-theme

    # Backup old .zshrc
    mv ~/.zshrc ~/.zshrc_backup
    # Copy over .zshrc
    cp .zshrc ~/.zshrc
    # Update for now (only required if using zsh)
    source ~/.zshrc

    # Backup old .vimrc
    mv ~/.vimrc ~/.vimrc_backup
    # Copy over .vimrc
    cp .vimrc ~/.vimrc
    # Neovim softlink
    mkdir ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim
    
    # Install Powerline fonts for theme
    git clone https://github.com/powerline/fonts.git --depth=1
    ./fonts/install.sh
    rm -rf fonts 

    # Change current shell to zsh
    sudo chsh -s /bin/zsh

    echo "Zsh install done."
fi
