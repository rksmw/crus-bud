# Update headers
apt-get update
apt-get upgrade
# Set password for mysql: 'root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
# Install dependencies
apt-get install -y build-essential autoconf libtool gcc g++ make cmake git-core wget p7zip-full libncurses5-dev zlib1g-dev libbz2-dev
apt-get install -y openssl libssl-dev mysql-server mysql-client libmysqlclient-dev libmysql++-dev libreadline6-dev
apt-get install -y libace-dev
