set -ex
apk add alpine-sdk

adduser -D sourcegraph
echo 'root ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'sourcegraph ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
addgroup sourcegraph abuild
apk add --no-cache sudo

sudo -u sourcegraph -s -- <<EOF
cd /home/sourcegraph
git config --global user.name "Sourcegraph"
git config --global user.email "support@sourcegraph.com"
git clone git://git.alpinelinux.org/aports

sudo mkdir -p /var/cache/distfiles
sudo chmod a+w /var/cache/distfiles
sudo echo -ne '\n' | abuild-keygen -a -i

sudo mkdir /target
sudo chmod 0777 /target

cd aports/main/git
abuild -c -r -P /target
ls /target/main/x86_64/
EOF
