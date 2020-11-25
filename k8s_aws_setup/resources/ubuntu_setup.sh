# Update apt
sudo apt-get update

# Install jdk-8
sudo apt install openjdk-8-jre-headless

# Install other packages for Docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
# Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Install Docker
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io
   
# Install kOps
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x ./kops
sudo mv ./kops /usr/local/bin/

# Install kubectl
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Get Spark
wget https://mirror.olnevhost.net/pub/apache/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
tar -xvf spark-3.0.1-bin-hadoop3.2.tgz
sudo mv spark-3.0.1-bin-hadoop3.2 /opt/spark

# Delete spark tarball
rm spark-3.0.1-bin-hadoop3.2.tgz

# Get unzip
sudo apt install unzip

# Get awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Delete aws files
rm awscliv2.zip
rm -r aws


# Make an SSH key (no password) (not sure if needed)
ssh-keygen -t rsa -C "example@gmail.com" -f ~/.ssh/id_rsa -P ""