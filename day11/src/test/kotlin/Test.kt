import kotlin.test.Test
import kotlin.test.assertEquals

class Test {
    @Test
    fun `sample 1`() {
        val grid = OctopusGrid.fromFile("sample")
        assertEquals(1656, grid.steps(100))
    }

    @Test
    fun `sample 2`() {
        val grid = OctopusGrid.fromFile("sample")
        assertEquals(195, grid.stepUntilSync())
    }

    @Test
    fun `solution 1`() {
        val grid = OctopusGrid.fromFile("input")
        assertEquals(1620, grid.steps(100))
    }

    @Test
    fun `solution 2`() {
        val grid = OctopusGrid.fromFile("input")
        assertEquals(371, grid.stepUntilSync())
    }
}