package eu.adrianistan.adventofcode

import scala.annotation.tailrec
import scala.io.Source

object Main {
  def readFile(filename: String) = {
    val line = Source.fromFile(filename).getLines().next()
    line.split(",").map(_.toInt)
  }

  @tailrec
  def life(ticks: Int, fishes: Array[Int]): Array[Int] = {
    if(ticks == 0) {
      fishes
    } else {
      val fish0 = fishes.map(_ - 1)
      val newFish = fish0.filter(_ == -1).map(_ => 8)
      def reset(value: Int) = if(value == -1) 6 else value
      val fish1 = fish0.map(reset)
      val fishFinal = fish1 ++ newFish
      life(ticks - 1, fishFinal)
    }
  }

  def convertToBag(fishes: Array[Int]) = {
    LanterfishBag(
      fishes.filter(_ == 0).length,
      fishes.filter(_ == 1).length,
      fishes.filter(_ == 2).length,
      fishes.filter(_ == 3).length,
      fishes.filter(_ == 4).length,
      fishes.filter(_ == 5).length,
      fishes.filter(_ == 6).length,
      fishes.filter(_ == 7).length,
      fishes.filter(_ == 8).length,
    )
  }

  @tailrec
  def lifeV2(ticks: Int, fishBag: LanterfishBag): LanterfishBag = {
    if(ticks == 0){
      fishBag
    } else {
      val newBag = LanterfishBag(
        zeros = fishBag.ones,
        ones = fishBag.twos,
        twos = fishBag.threes,
        threes = fishBag.fours,
        fours = fishBag.fives,
        fives = fishBag.sixs,
        sixs = fishBag.sevens + fishBag.zeros,
        sevens = fishBag.eights,
        eights = fishBag.zeros
      )
      lifeV2(ticks - 1, newBag)
    }
  }

  def main(args: Array[String]) = {
    val fishes = readFile("input")

    val endFishes = life(80, fishes)
    println(s"Solution 1. ${endFishes.length}")

    val endFishes2 = lifeV2(256, convertToBag(fishes))
    println(s"Solution 2: ${endFishes2.sum}")
  }
}
