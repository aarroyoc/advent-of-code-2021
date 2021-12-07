use std::fs;

fn load_data(filename: &str) -> Vec<i32> {
    fs::read_to_string(filename).unwrap().split(',').map(|x| x.parse().unwrap()).collect()
}

fn max<T : Ord + Copy>(vec: &Vec<T>) -> T {
    vec.iter().fold(vec[0], |acc, elem| acc.max(*elem))
}

fn min<T : Ord + Copy>(vec: &Vec<T>) -> T {
    vec.iter().fold(vec[0], |acc, elem| acc.min(*elem))
}

fn calculate_fuel(positions: i32) -> i32 {
    positions*(1 + positions)/2
}

fn solution1(data: &Vec<i32>) -> Option<i32> {
    let min_bound = min(&data);
    let max_bound = max(&data);
    (min_bound..max_bound).map(|i|{
        data.iter().map(|x| (*x-i).abs()).sum()
    }).min()
}

fn solution2(data: &Vec<i32>) -> Option<i32> {
    let min_bound = min(&data);
    let max_bound = max(&data);
    (min_bound..max_bound).map(|i|{
        data.iter().map(|x| (*x-i).abs()).map(calculate_fuel).sum()
    }).min()
}

fn main() {
    let data = load_data("input");
    let solution1 = solution1(&data);
    println!("Solution 1: {}", solution1.unwrap());
    let solution2 = solution2(&data);
    println!("Solution 2: {}", solution2.unwrap());
}

#[cfg(test)]
mod tests {
    use crate::{load_data, solution1, solution2};

    #[test]
    fn test_sample1() {
        let data = load_data("sample");
        assert_eq!(Some(37), solution1(&data));
    }

    #[test]
    fn test_sample2() {
        let data = load_data("sample");
        assert_eq!(Some(168), solution2(&data));
    }

    #[test]
    fn test_solution1() {
        let data = load_data("input");
        assert_eq!(Some(344138), solution1(&data));
    }

    #[test]
    fn test_solution2() {
        let data = load_data("input");
        assert_eq!(Some(94862124), solution2(&data));
    }
}