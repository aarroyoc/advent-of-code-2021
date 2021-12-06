package eu.adrianistan.adventofcode

case class LanterfishBag(val zeros: Long, val ones: Long, val twos: Long, val threes: Long, val fours: Long, val fives: Long, val sixs: Long, val sevens: Long, val eights: Long) {
  def sum = {
    zeros + ones + twos + threes + fours + fives + sixs + sevens + eights
  }
}
