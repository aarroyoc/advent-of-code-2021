module Solution where

import Data.List

data Instruction = Forward Int | Down Int | Up Int
type InstructionResult = (Int, Int)
data SubmarineState = MkSubmarineState
    { submarineX :: Int
    , submarineY :: Int
    , submarineAim :: Int
} deriving(Show)

solution1 :: String -> IO Int
solution1 fileName = do
    file <- readFile fileName
    let instructions = map parseInstruction $ lines file
    let result = executeInstructionsV1 instructions
    pure $ uncurry (*) result

solution2 :: String -> IO Int
solution2 fileName = do
    file <- readFile fileName
    let instructions = map parseInstruction $ lines file
    let result = executeInstructionsV2 instructions
    pure $ submarineX result * submarineY result

parseInstruction :: String -> Instruction
parseInstruction str =
    case instructionStr of
        "forward" -> Forward arg
        "down" -> Down arg
        "up" -> Up arg
        _ -> error "Invalid Instruction"
    where
        strWords = words str
        instructionStr = head strWords
        arg = read $ last strWords

executeInstructionsV1 :: [Instruction] -> InstructionResult
executeInstructionsV1 = foldr executeInstructionV1 (0, 0)

executeInstructionV1 :: Instruction -> InstructionResult -> InstructionResult
executeInstructionV1 (Forward n) state = (fst state + n, snd state)
executeInstructionV1 (Down n) state = (fst state, snd state + n)
executeInstructionV1 (Up n) state = (fst state, snd state - n)

executeInstructionsV2 :: [Instruction] -> SubmarineState
executeInstructionsV2 = foldl' executeInstructionV2 MkSubmarineState { submarineX = 0, submarineY = 0, submarineAim = 0}

executeInstructionV2 :: SubmarineState -> Instruction -> SubmarineState
executeInstructionV2 state (Down n) = state { submarineAim = submarineAim state + n}
executeInstructionV2 state (Up n) = state { submarineAim = submarineAim state - n}
executeInstructionV2 state (Forward n) = state { submarineX = newSubmarineX, submarineY = newSubmarineY }
    where
        newSubmarineX = submarineX state + n
        newSubmarineY = submarineY state + submarineAim state * n