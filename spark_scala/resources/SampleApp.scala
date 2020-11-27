import org.apache.spark.sql.SparkSession

object SampleApp {
  def main(args: Array[String]) {
    val logFile = "/home/ubuntu/scala_app/resources/sample_text.txt" // Should be some file on your system
    val spark = SparkSession.builder.appName("Simple Application").getOrCreate()
    val logData = spark.read.textFile(logFile).cache()
    val numAs = logData.filter(line => line.contains("a")).count()
    val numBs = logData.filter(line => line.contains("b")).count()
    println("Output from SampleApp:")
    println(s"Lines with a: $numAs, Lines with b: $numBs")
    spark.stop()
  }
}