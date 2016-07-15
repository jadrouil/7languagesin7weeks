/*

using foldLeft to compute the total size of a list of strings

*/
def calcSize(list : List[String]): Int = {
    val size = (0 /: list) {(sum, str) => sum + str.size}
    return size
}

assert(calcSize(Nil) == 0)
assert(calcSize(List("My", "Name", ":", "Jeremy Drouillard")) ==  24)
assert(calcSize(List("", "", "")) == 0)
assert(calcSize(List("1")) == 1)

println("passed calcSize tests")

trait Censor{
    def switchBadWords(str: String): String
}

class Censorer(filename :String) extends Censor{
    import scala.io.Source

    def loadMapFromFile(): Map[String,String] = filename.isEmpty match {
        case false => Source.fromFile(filename).getLines
                        .map(_.split(","))
                        .map(x => x(0) -> x(1))
                        .toMap
        case _     => Map.empty
    }
    
    val switchWords = Map("Shoot" -> "Pucky", "Darn" -> "Beans") ++ loadMapFromFile()

    def switchBadWords(str : String): String = switchWords.getOrElse(str, str)
    
}

val tester = new Censorer("cleanItUp.txt")

assert(tester.switchBadWords("Darn") == "Beans")
assert(tester.switchBadWords("darn") == "darn")
assert(tester.switchBadWords("Shoot") == "Pucky")
assert(tester.switchBadWords("aasfas") == "aasfas")
assert(tester.switchBadWords("badWord") == "goodWord")
assert(tester.switchBadWords("terribleWord") == "terrificWord")

println("passed censorship test")