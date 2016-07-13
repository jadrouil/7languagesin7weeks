

/*Write a game that will take a tic-tac-toe board and determine the state of the game
I am making the following assumptions:
    -the only allowable chars on a board are X,O,'_'
    -the board will be completely finished. That is: if both players realize the game is going to tie, they still continue to fill out all tiles.
    -wins can leave board with empty spaces

*/


    object boardStates extends Enumeration{
        type boardStates = Value
        val XWINS, OWINS, TIE, UNFINISHED = Value
    }

    import boardStates._

    class TicTacToeChecker {
        
        def check(board: Array[Array[Char]]): boardStates =  {
            assert(board.size == 3)
            
            var defaultResult = TIE
                    
            var result = checkHorizontals(board)
            if(result == XWINS || result == OWINS){
                return result
            }
            if(result ==  UNFINISHED){
                defaultResult = UNFINISHED
            }
            
            result = checkVerticals(board)
            if(result == XWINS || result == OWINS){
                return result
            }
            if(result ==  UNFINISHED){
                defaultResult = UNFINISHED
            }
            
            
            result = checkDiagonals(board)
            if(result == XWINS || result == OWINS){
                return result
            }
            
            return defaultResult
        }
        
        private def checkHorizontals(board: Array[Array[Char]]): boardStates = {
            var default = TIE
            board.foreach {row => 
                assert(row.size == 3)
                val result = checkRow(row)
                if(result == XWINS || result == OWINS){
                    return result
                }
                else if(result == UNFINISHED){
                    default = result
                }
            }
            return default
        }
        
        private def checkRow(row:Array[Char] ): boardStates = {
            var charInterest = 'X' 
            var countInterest = 0
            row.foreach{cell =>
                if(charInterest == cell){
                    countInterest += 1
                }
                else if(cell == '_'){
                    return UNFINISHED
                }
                else if(countInterest == 0){
                    charInterest = cell
                    countInterest = 1
                }
            }
            
        if (countInterest != 3) return TIE
        
        if(charInterest == 'X') return XWINS
        else if (charInterest == 'O') return OWINS
        else{
                println("BADDDDD")
                System.exit(1)
                return TIE
        }
    }
    
        
        private def checkVerticals(board: Array[Array[Char]]): boardStates ={
            var defaultResult = TIE
            for(i <- 0 to 2){
                if(board(0)(i) == '_' || board(1)(i) == '_' || board(2)(i) == '_'){
                    defaultResult = UNFINISHED
                }
                else if(board(0)(i) == board(1)(i) && board(1)(i) == board(2)(i)){
                    if (board(2)(i) == 'X') return XWINS
                    return OWINS
                }
            
            }
            return defaultResult
        }
        
        
        private def checkDiagonals(board: Array[Array[Char]]): boardStates = {
            var defaultResult = TIE
            if(board(0)(0) == '_' || board(0)(2) == '_' || board(1)(1) == '_' || board(2)(0) == '_' || board(2)(2) == '_'){
                defaultResult = UNFINISHED
            } 
            
            if(board(0)(0) == board(1)(1) && board(1)(1) == board(2)(2) && board(2)(2) != '_') {
                if (board(0)(0) == 'X') return XWINS
                return OWINS
            }
            
            if( board(0)(2) == board(1)(1) && board(1)(1) == board(2)(0) && board(2)(0) != '_') {
                if (board(0)(0) == 'X') return XWINS
                return OWINS
            }
            
            return defaultResult
        }
    }

    
def createBoard():Array[Array[Char]] = {
    var a = Array.ofDim[Char](3,3)
    for(i <- 0 to 2){
        for(j <- 0 to 2) {
            a(i)(j) = '_'
        }
    }
    
    return a
}
    


val checker = new TicTacToeChecker
assert(checker.check(createBoard()) == UNFINISHED)

var b = createBoard()
b(0)(0) = 'X'
b(0)(1) = 'X'
b(0)(2) = 'X'


assert(checker.check(b) == XWINS)

b = createBoard()

b(0)(0) = 'X'
b(1)(1) = 'X'
b(2)(2) = 'X'

assert(checker.check(b) == XWINS)


b = createBoard()

b(0)(0) = 'X'
b(1)(0) = 'X'
b(2)(0) = 'X'

assert(checker.check(b) == XWINS)

b = createBoard()

b(0)(1) = 'X'
b(0)(0) = 'O'
b(0)(2) = 'O'

b(1)(0) = 'O'
b(1)(1) = 'X'
b(1)(2) = 'O'

b(2)(0) = 'X'
b(2)(1) = 'O'
b(2)(2) = 'X'


assert(checker.check(b) ==  TIE)



println("passed tests")