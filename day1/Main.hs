module Main where

import Solution

main :: IO ()
main = do
    putStr "Solution 1: "
    sol1 <- solution1 "input"
    print sol1
    putStr "Solution 2: "
    sol2 <- solution2 "input"
    print sol2