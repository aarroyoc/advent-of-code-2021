import kotlin.test.Test
import kotlin.test.assertEquals

class Test {

    @Test
    fun `sample 1`() {
        val game = readGame("sample")
        assertEquals(4512, game.playToWin())
    }

    @Test
    fun `sample 2`() {
        val game = readGame("sample")
        assertEquals(1924, game.playToLoose())
    }

    @Test
    fun `solution 1`() {
        val game = readGame("input")
        assertEquals(35670, game.playToWin())
    }

    @Test
    fun `solution 2`() {
        val game = readGame("input")
        assertEquals(22704, game.playToLoose())
    }
}