sealed interface BoardCell {
    val value: Int
}
class MarkedCell(override val value: Int) : BoardCell
class UnmarkedCell(override val value: Int) : BoardCell

class Board(grid: List<List<BoardCell>>) {
    private val grid: List<List<BoardCell>> = grid

    fun mark(value: Int): Board =
        Board(this.grid.map { row ->
            row.map {
                if(value == it.value){
                    MarkedCell(it.value)
                } else {
                    it
                }
            }
        })

    fun win() =
        this.grid.map { it.filterIsInstance<MarkedCell>().count() }.any { it == 5} || this.grid.t().map { it.filterIsInstance<MarkedCell>().count() }.any { it == 5}

    fun score() =
        this.grid.flatten().filterIsInstance<UnmarkedCell>().sumOf { it.value }

}

fun<T> List<List<T>>.t(): List<List<T>> {
    val t = mutableListOf<MutableList<T>>()
    for(j in 0..4) {
        t.add(mutableListOf())
    }
    for(i in 0..4){
        for(j in 0..4){
            t[j].add(this[i][j])
        }
    }
    return t
}