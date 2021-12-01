module Solution where

solution1 :: String -> IO Int
solution1 fileName = do
    file <- readFile fileName
    let numbers = map read $ lines file
    return $ increments numbers

solution2 :: String -> IO Int
solution2 fileName = do
    file <- readFile fileName
    let numbers = map read $ lines file
    return $ increments $ slides numbers

increments :: [Int] -> Int
increments (x:xs) = increments_ (x:xs) xs

increments_ :: [Int] -> [Int] -> Int
increments_ _ [] = 0
increments_ (x:xs) (y:ys) = (increments_ xs ys) + if y > x then 1 else 0

slides :: [Int] -> [Int]
slides [x, y, z] = [x + y + z]
slides (x:y:z:xs) = (x + y + z):(slides (y:z:xs))
