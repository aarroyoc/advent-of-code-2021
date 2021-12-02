module Main (main) where

import Test.HUnit
import System.Exit

import Solution

testSample1 = TestCase(assertEqual "Test Sample 1" 150 =<< solution1 "sample")
testSample2 = TestCase(assertEqual "Test Sample 2" 900 =<< solution2 "sample")
testProblem1 = TestCase(assertEqual "Test Problem 1" 2102357 =<< solution1 "input")
testProblem2 = TestCase(assertEqual "Test Problem 2" 2101031224 =<< solution2 "input")

main :: IO ()
main = do
    counts <- runTestTT (test [
        testSample1,
        testSample2,
        testProblem1,
        testProblem2
        ])
    if errors counts + failures counts == 0
        then exitSuccess
        else exitFailure