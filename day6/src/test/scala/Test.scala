package eu.adrianistan.adventofcode

import eu.adrianistan.adventofcode.Main.*
import org.scalatest.funsuite.AnyFunSuite

class Test extends AnyFunSuite {
  test("sample 1") {
    val fishes = readFile("sample")
    val result = life(80, fishes)
    assert(result.length === 5934)
  }

  test("sample 2") {
    val fishes = readFile("sample")
    val result = lifeV2(256, convertToBag(fishes))
    assert(result.sum === 26984457539L)
  }

  test("solution 1") {
    val fishes = readFile("input")
    val result = life(80, fishes)
    assert(result.length === 343441)
  }

  test("solution 2") {
    val fishes = readFile("input")
    val result = lifeV2(256, convertToBag(fishes))
    assert(result.sum === 1569108373832L)
  }
}
