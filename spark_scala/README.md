## Spark with Scala

How to build a Spark application written in Scala.

This work is done in the environment created in [this post](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup).  

Note that this sample project is built using the instructions from the official [Spark 3.0.1 Quick Start Guide](http://spark.apache.org/docs/3.0.1/quick-start.html#self-contained-applications). Minor adjustments may have to be made if different versions of spark/scala are used (particularily in **build.sbt** and **run_scala.sh**).

### Install Scala and sbt

```
sudo apt-get install scala
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt
```

### Download Files

```
wget -P ~/setup_scripts https://raw.githubusercontent.com/npa02012/blog_posts/master/spark_scala/resources/setup_scala_app.sh
chmod +x ~/setup_scripts/setup_scala_app.sh
~/setup_scripts/setup_scala_app.sh
```

The [setup script](https://github.com/npa02012/blog_posts/blob/master/spark_scala/resources/setup_scala_app.sh) will create the directory structure and download the necessary files for the spark-scala application. Note the directory structure at this point:

```
cd ~/scala_app
find .

Out:
-------------------------
.
./build.sbt
./resources
./resources/run_app.sh
./resources/sample_text.txt
./src
./src/main
./src/main/scala
./src/main/scala/SampleApp.scala
```

### Build the package

This may take a while if it is your your first time running *sbt* on the machine (about 1 minute on a *t2.medium* instance).

```
cd ~/scala_app
sbt package
```

### Run the Application
```
chmod +x ~/scala_app/resources/run_app.sh
~/scala_app/resources/run_app.sh
```

This should execute successfully! If so, there will be some output text in the log saying: 

```
Output from SampleApp:
Lines with a: 3, Lines with b: 0
```
