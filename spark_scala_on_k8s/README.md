## Scale

First install Scala and sbt:

```
sudo apt-get install scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt
```

Make directory structure for an app:

```
cd ~
mkdir scala_app
cd scala_app
mkdir src
mkdir src/main
mkdir src/main/scala
```

Create the following files:

* ~/scala_app/build.sbt
* ~/scala_app/src/main/scala/TestApp.scala

files with [code from here](http://spark.apache.org/docs/3.0.0/quick-start.html#self-contained-applications).

The same link has directions to finish the process. Pausing because *sbt package* command taking a long time (t2.nano instance).
