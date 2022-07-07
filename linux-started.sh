#! /bin/bash
#title           :linux-started.sh
#description     :This script will setup eviroment for developer.
#author		 :Van Trong
#date            :07/07/2022
#version         :1.0
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
printf "${GREEN_COLOR}author		 :Van Trong\n"
printf "${GREEN_COLOR}date            :07/07/2022"\n
printf "${GREEN_COLOR}version         :1.0\n"
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
  sudo apt install nodejs -y
  sudo apt install npm -y
  printf "${PURPLE_COLOR}Node installed"
}

function main() {
  update_system
  install_git
  install_chrome
  install_postman
  install_vscode
  install_c++
  install_taskfile
  install_node
  install_zsh
}

main