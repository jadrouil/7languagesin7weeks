import scala.io._
val a  = scala.io.Source.fromURL("http://google.com", "UTF-8")


/*import scala.actors._
import Actor._

object PageLoader{
    def getPageSize(url :String): Int = scala.io.Source.fromURL(url, "UTF-8")
}

val urls = List( "http://www.reddit.com/")
   //              "http://www.twitter.com/",
//                 "http://www.google.com/",
  //               "http://www.cnn.com/",
    //             "http://www.facebook.com/")
                 
def timeMethod(method: () => Unit) {
    val start = System.nanoTime
    method()
    val end = System.nanoTime
    println("Method took " + (end - start)/1000000000.0 + " seconds.")
}

def getPageSizeSequentially() {
    for(url <- urls){
        println("Size for " + url + ": " + PageLoader.getPageSize(url))
    }
}

def getPageSizeConcurrently() {
    val caller = self
    for(url <- urls){
        actor { caller ! (url,
        println("Size for " + url + ": " + PageLoader.getPageSize(url))) }
    }
    
    for(i <- 1 to urls.size) {
        receive {
            case (url, size) =>
                println("Size for " + url + ": " + size)
        }
    }
}

println("Sequential run: ")
timeMethod( getPageSizeSequentially )

println("Concurrent run: ")
timeMethod( getPageSizeConcurrently)
*/