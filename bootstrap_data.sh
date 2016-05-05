echo "Extracting data";
rm -fr /root/release/data/
rm -fr /root/release/__MACOSX/
unzip /vagrant/data.zip -d /root/release/ > /dev/null
