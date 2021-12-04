import java.io.File

fun main(args: Array<String>) {
    val game = readGame("input")
    val score = game.playToWin()
    println("Solution 1: $score")
    val score2 = game.playToLoose()
    println("Solution 2: $score2")
}

fun readGame(filename: String): Game {
    val lines = File(filename).readLines()
    // First line is order
    val order = lines[0].split(",").map { it.toInt() }

    val boards = mutableListOf<Board>()
    var n = 2
    while(n < lines.size){
        boards.add(Board((0..4).map { row ->
            lines[n+row].split(" ").filter { it.isNotEmpty() }.map { UnmarkedCell(it.toInt()) }
        }))
        n += 6
    }

    return Game(
        order,
        boards
    )
}