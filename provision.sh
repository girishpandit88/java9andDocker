sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get install -qqy oracle-java9-installer
sudo apt-get install -qqy oracle-java9-set-default
export JAVA_HOME=/usr/lib/jvm/java-9-oracle
export MODS=$JAVA_HOME/jmods/
