# Create 'build' folder if not exists
if ! [ -a /root/build/ ]; then
  mkdir /root/build
  cd /root/build
  # Cmake
  cmake /vagrant -DPREFIX=/root/release
else
  cd /root/build
fi

# Make
make -j8 && make install

mv /root/release/etc/authserver.conf.dist /root/release/etc/authserver.conf
mv /root/release/etc/worldserver.conf.dist /root/release/etc/worldserver.conf
sed -i 's/DataDir = "."/DataDir = "\/root\/release\/data\/"/g' /root/release/etc/worldserver.conf
