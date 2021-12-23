import java.io.File

class OctopusGrid(
    private var grid: MutableList<MutableList<Int>>
){
    private var flashes = 0

    fun steps(n: Int): Int {
        for(i in 0 until n) {
            this.step()
        }
        return this.flashes
    }

    fun stepUntilSync(): Int {
        var n = 0
        while (!this.grid.flatten().all { it == 0 }) {
            this.step()
            n += 1
        }
        return n
    }

    private fun step() {
        while(this.grid.flatten().any { it in 9..99 }) {
            for(i in 0 until this.grid.size){
                for(j in 0 until this.grid[i].size) {
                    if(this.grid[i][j] in 9..99) {
                        this.grid[i][j] = 100
                        incCell(i-1, j-1)
                        incCell(i, j-1)
                        incCell(i+1, j-1)
                        incCell(i-1, j)
                        incCell(i+1, j)
                        incCell(i-1, j+1)
                        incCell(i, j+1)
                        incCell(i+1, j+1)
                    }
                }
            }
        }
        this.flashes += this.grid.flatten().count { it >= 50 }

        this.grid = this.grid.map { line ->
            line.map {
                it + 1
            }.toMutableList()
        }.toMutableList()

        this.grid = this.grid.map { line ->
            line.map {
                if(it >= 50) {
                    0
                } else {
                    it
                }
            }.toMutableList()
        }.toMutableList()
    }

    private fun incCell(i: Int, j: Int) {
        if(this.grid.getOrNull(i)?.getOrNull(j) != null){
            this.grid[i][j] += 1
        }
    }

    companion object {
        fun fromFile(filename: String): OctopusGrid {
            val grid = File(filename).readLines().map { line ->
                line.map { it.digitToInt() }.toMutableList()
            }.toMutableList()
            return OctopusGrid(grid)
        }
    }
}

fun main(args: Array<String>) {
    val grid = OctopusGrid.fromFile("input")
    val flashes = grid.steps(100)
    println("Solution 1: $flashes")

    val grid2 = OctopusGrid.fromFile("input")
    val step = grid2.stepUntilSync()
    println("Solution 2: $step")
}