module Main where

import Solution

main :: IO ()
main = do
    result1 <- solution1 "input" 
    putStr "Solution 1: "
    print result1
    result2 <- solution2 "input"
    putStr "Solution 2: "
    print result2