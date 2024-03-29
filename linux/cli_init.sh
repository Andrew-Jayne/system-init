echo "Welcome $USER"
sudo apt update
sudo apt upgrade

#remove tools extra tools
sudo apt remove nano

## Install additional native packages
sudo apt install zsh vim apt-transport-https curl ansible zsh python3 python-is-python3 python3-pip ca-certificates software-properties-common curl gnupg lsb-release yamllint screen wget

## Install pip
python3 -m ensurepip --upgrade

#  Install packages from external sources

	#install Keys and GPG for Docker, KubeCtl, Terraform, OBS, Helm
		#docker
		sudo apt-get remove docker docker-engine docker.io containerd runc
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		
		#kubectl
		curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
		echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
		
		#helm
		curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

		#Terraform
		wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	
	#install Docker, KubeCtl, Terraform, AWS CLI
	sudo apt update
	sudo apt install terraform docker-ce docker-ce-cli containerd.io docker-compose-plugin kubectl awscli helm

## Install Azure CLI
sudo apt remove azure-cli
curl -sL "https://aka.ms/InstallAzureCLIDeb" | sudo bash

## Install Ansible lint
pip3 install git+https://github.com/ansible-community/ansible-lint.git

## Install OhMyZsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s /bin/zsh

# Add kubectl Alias
echo 'alias kc=kubectl' > ~/.zshrc

# Addo code runner aliases
echo 'alias py=python3' >> ~/.zshrc
echo 'alias python=python3' >> ~/.zshrc
echo 'alias tf=terraform' >> ~/.zshrc

# Add Encroyt & Decrypt Aliases
alias encrypt="openssl aes-256-cbc -a -salt"
alias decrypt="openssl aes-256-cbc -d -a"

# Clean Up .deb files
rm *.deb
# Clean Up excess packages
sudo apt autoremove

# Check Versions and confirm succesfull installs
sudo docker run hello-world || echo 'Docker install failed'
python --version || echo 'Python install failed'
aws --version || echo 'AWS CLI install failed'
az version || echo 'Azure CLI install failed'
terraform --version || echo 'Terraform install failed'
pip --version || echo 'Pip install failed'
kubectl version --short || echo 'Kubectl install failed'