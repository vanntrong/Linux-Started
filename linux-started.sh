#! /bin/bash
#title           :linux-started.sh
#description     :This script will setup eviroment for developer.
#author		 :Van Trong
#date            :07/07/2022
#update          :10/07/2022
#version         :1.1
#usage		 :bash linux-started.sh
#==============================================================================

RED_COLOR="\033[1;31m"
GREEN_COLOR="\033[1;32m"
YELLOW_COLOR="\033[1;33m"
BLUE_COLOR="\033[1;34m"
PURPLE_COLOR="\033[1;35m"
CYAN_COLOR="\033[1;36m"
GREY_COLOR="\033[0;37m"
RESET_COLOR="\033[m"


printf "${CYAN_COLOR}title           :linux-started.sh\n"
printf "${CYAN_COLOR}description     :This script will setup eviroment for developer.\n"
printf "${GREEN_COLOR}author		     :Van Trong\n"
printf "${GREEN_COLOR}date           :07/07/2022"\n
printf "${GREEN_COLOR}update         :10/07/2022"\n
printf "${GREEN_COLOR}version        :1.1\n"
printf "${CYAN_COLOR}=======This script created by Van Trong========\n"
printf "${CYAN_COLOR}=======This script will setup eviroment for developer========\n"
printf "${CYAN_COLOR}=======Get me one start on github========\n"

function update_system() {
  sudo apt-get update
  sudo apt-get upgrade
}

function install_git() {
  sudo apt-get install git -y
  printf "${PURPLE_COLOR}Git installed\n"
  echo "${RED_COLOR}Enter your git username:"
  read git_username
  echo "${RED_COLOR}Enter your git email:"
  read git_email
  git config --global user.name $git_username
  git config --global user.email $git_email
}

function install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
  sudo apt-get install google-chrome-stable -y
  printf "${PURPLE_COLOR}Chrome installed"
}

function install_postman() {
  sudo snap install postman -y
  printf "${PURPLE_COLOR}Postman installed"
}

function install_vscode() {
  sudo apt update
  sudo apt install software-properties-common apt-transport-https wget -y
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
  sudo apt install code -y
  sudo apt update
  sudo apt upgrade
}

function install_zsh() {
  sudo apt-get install zsh -y
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

function install_c++() {
  sudo apt install g++ -y
  g++ --version
  printf "${PURPLE_COLOR}C++ installed"
}

function install_taskfile() {
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
  sudo apt install golang-go -y
}

function install_node() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  source ~/.zshrc
  nvm install 16.15.0
  npm install -g yarn
  yarn -v
  yarn set version stable
  printf "${PURPLE_COLOR}Node installed"
}

function install_ibus() {
  sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
  sudo apt-get update
  sudo apt-get install ibus ibus-bamboo --install-recommends
  ibus restart
  # Đặt ibus-bamboo làm bộ gõ mặc định
  env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
}

function install_curl_wget() {
  sudo apt install curl
  sudo apt install wget
}

function install_discord() {
  sudo apt update && sudo apt upgrade
  sudo snap install discord
}

function install_docker() {
  sudo apt update
  sudo apt install apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  apt-cache policy docker-ce
  sudo apt install docker-cesudo
  systemctl status docker
  sudo usermod -aG docker ${USER}
  su - ${USER}
  groups
  echo "${PURPLE_COLOR} Enter your username for docker:"
  read docker_username
  sudo usermod -aG docker ${docker_username}
}

function main() {
  update_system
  install_curl_wget
  install_zsh
  install_git
  install_chrome
  install_postman
  install_vscode
  install_c++
  install_taskfile
  install_node
  install_discord
  install_docker
}

main