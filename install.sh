
#!/bin/bash

# SCRIPT TO INSTALL MY IMPORTANT DOTFILES AND PLUGINS TO USER DIR

which sudo &>/dev/null
[ $? -eq 0 ] && echo "sudo found. Starting install.sh..." || (echo "sudo is not installed! Please install sudo." && read && exit 1)

#### XBPS ####

read -p "Do you want to install all packages via xbps? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Update sources
    sudo xbps-install -Syu

    # Install reqired packages
    sudo xbps-install -S xorg xterm xclip curl zip git cmake base-devel python-devel python3 python3-pip python3-devel neovim rxvt-unicode zsh i3 i3lock i3status dunst dmenu ranger udiskie NetworkManager network-manager-applet inetutils-ifconfig gnome-keyring socklog-void firefox gst-libav alsa-utils pulseaudio redshift font-awesome
    
    # Copy ranger config files
    ranger --copy-config=all

    # Set up Network Manager
    sudo rm -fr /var/service/dhcpcd
    sudo rm -fr /var/service/wpa_supplicant
    sudo ln -s /etc/sv/NetworkManager /var/service
    sudo ln -s /etc/sv/dbus /var/service

    # Set up logger
    sudo ln -s /etc/sv/socklog-unix /var/service/ 
    sudo ln -s /etc/sv/nanoklogd /var/service/

    # Set up audio
    sudo ln -s /etc/sv/alsa /var/service/ 
    sudo ln -s /etc/sv/cgmanager /var/service/
    sudo ln -s /etc/sv/consolekit /var/service/
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

#### VIM PLUGINS ####

read -p "Do you want to install Vim configuration, plugins and themes? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Pathogen Vim
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    # NERDTree
    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

    # YouCompleteMe
    read -p "Do you want to install YouCompleteMe for Vim? (Requires Vim 8.0 with Python support, check with vim --version) [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cd ~/.vim/bundle
        git clone https://github.com/Valloric/YouCompleteMe.git
        cd YouCompleteMe
        git submodule update --init --recursive
        ./install.py --clang-completer
    fi
fi
