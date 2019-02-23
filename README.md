Welcome to the vpp-build-dev-test-env wiki!

Build Environment for Honeycom Vpp and hc2vpp

Setup the maven to use opendaylight repository
----------------------------------------------
cp -n ~/.m2/settings.xml{,.orig} ; wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > ~/.m2/settings.xml sudo apt-get update

Go To /home/ubuntu/ws would be where ws can be placed
--------------------------------------------------------

cd /home/ubuntu/ws
git clone https://gerrit.fd.io/r/vpp
git checkout tags/v18.10-rc2 -b v18.10-rc2
make install-deps #<some transient issues may be there>
make install-ext-deps build pkg-deb


Install the Jvpp Jars to maven repo
-----------------------------------
echo "jvpp-ioamexport jvpp-core jvpp-gtpu jvpp-ioamexport jvpp-ioampot jvpp-ioamtrace jvpp-nat jvpp-pppoe jvpp-registry jvpp-core jvpp-ioamtrace jvpp-nsh jvpp-registry jvpp-benchmark jvpp-ioamexport jvpp-ioampot jvpp-benchmark jvpp-acl" | xargs -I {} mvn install:install-file -Dfile=pwd/build-root/build-vpp-native/japi/java/{}-18.10.jar -DgroupId=io.fd.vpp -DartifactId={} -Dversion=18.10-SNAPSHOT -Dpackaging=jar | grep -B3 "FAILURE"

Do installation on the host itself
----------------------------------
cd build-root sudo dpkg -i *.deb

Disable DPDK
------------
/etc/vpp/startup.conf disable dpdk pci device



Step 5> git clone https://gerrit.fd.io/r/honeycomb git checkout tags/v1.18.10-RC1 -b v1.18.10-RC1 mvn install

step 6> https://gerrit.fd.io/r/hc2vpp git checkout tags/v1.18.10-RC1 -b v1.18.10-RC1 mvn install

Step7> /etc/vpp/startup##
