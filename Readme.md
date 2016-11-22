Java9 and Docker - minimalist future is here
==============================================

Quick look at how to dish out those size zero docker images that packages your runtime app binaries

### Steps to install java9 on ubuntu (included a provision script, invoked when vagrant launches)

```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get install oracle-java9-installer
sudo apt-get install oracle-java9-set-default
export JAVA_HOME=/usr/lib/jvm/java-9-oracle
export MODS=$JAVA_HOME/jmods/
```


### confirm java version
```
> java -version
java version "9-ea"
Java(TM) SE Runtime Environment (build 9-ea+140)
Java HotSpot(TM) 64-Bit Server VM (build 9-ea+140, mixed mode)
```

### now cd to your working directory
```bash
> cd /vagrant/
> tree
├── Dockerfile
├── Readme.md
├── src
│   └── com.greetings
│       ├── com
│       │   └── greetings
│       │       └── HelloWorld.java
│       └── module-info.java
└── Vagrantfile
```

### compile HelloWorld java9 style
```
> javac -d mods/com.greetings src/com.greetings/module-info.java src/com.greetings/com/greetings/HelloWorld.java`
```

### run HelloWorld::main
```
> java --module-path mods -m com.greetings/com.greetings.HelloWorld
export MODS=/usr/lib/jvm/java-9-oracle/jmods/
Hello World
```

### build your runtime image using the jlink command
```
> jlink --module-path mlib:$MODS --add-modules com.greetings --output image

> tree image -L 2
image
├── bin
│   ├── com.greetings
│   ├── java
│   └── keytool
├── conf
│   ├── net.properties
│   └── security
├── lib
│   ├── amd64
│   ├── jexec
│   ├── modules
│   ├── security
│   └── tzdb.dat
└── release

>./image/bin/com.greetings 
Hello World
```

### build the Dockerfile
```bash
> docker build . -t greetings
```

### run the built docker image
```bash
> docker run greetings
Hello World
```

### size of docker images
```bash
> docker images 
greetings   latest    31f997624827  34 minutes ago      169.7 MB
<none>      <none>    fa96f037e908  36 minutes ago      169.7 MB
ubuntu      latest    e4415b714b62  5 days ago          128.1 MB
