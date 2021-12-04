data class Game(
    val order: List<Int>,
    val boards: List<Board>
) {
    fun playToWin(): Int {
        var playingBoards = boards
        for(n in order){
            playingBoards = playingBoards.map { it.mark(n) }
            for(board in playingBoards){
                if(board.win()){
                    return n*board.score()
                }
            }
        }
        throw RuntimeException("Invalid game")
    }

    fun playToLoose(): Int {
        var playingBoards = boards
        for(n in order){
            if(playingBoards.size > 1){
                playingBoards = playingBoards.map { it.mark(n) }.filter { !it.win() }
            } else {
                playingBoards = playingBoards.map { it.mark(n) }
                if(playingBoards[0].win()){
                    return n*playingBoards[0].score()
                }
            }
        }
        throw RuntimeException("Invalid game")
    }
}
