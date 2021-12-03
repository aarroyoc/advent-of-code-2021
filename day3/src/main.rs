use std::fs::read_to_string;

struct Counter {
    ones: u32,
    zeros: u32
}

impl Default for Counter {
    fn default() -> Self {
        Counter {
            ones: 0,
            zeros: 0
        }
    }
}

fn gamma(counters: &Vec<Counter>) -> u32 {
    let mut gamma_string = String::new();
    for counter in counters {
        if counter.ones > counter.zeros {
            gamma_string.push('1');
        } else {
            gamma_string.push('0');
        }
    }
    isize::from_str_radix(&gamma_string, 2).unwrap().try_into().unwrap()
}

fn epsilon(counters: &Vec<Counter>) -> u32 {
    let mut epsilon_string = String::new();
    for counter in counters {
        if counter.ones > counter.zeros {
            epsilon_string.push('0');
        } else {
            epsilon_string.push('1');
        }
    }
    isize::from_str_radix(&epsilon_string, 2).unwrap().try_into().unwrap()
}

fn oxygen(original_lines: &Vec<&str>) -> u32 {
    let mut lines = original_lines.clone();
    for i in 0..lines[0].len() {
        let counters = build_counters(&lines);
        if counters[i].ones >= counters[i].zeros {
            lines = lines.into_iter().filter(|line| (line.as_bytes()[i] as char) == '1').collect();
        } else {
            lines = lines.into_iter().filter(|line| (line.as_bytes()[i] as char) == '0').collect();
        }
        if lines.len() == 1 {
            return isize::from_str_radix(&lines[0], 2).unwrap().try_into().unwrap();
        }
    }
    panic!("Unexpected!");
}

fn co2(original_lines: &Vec<&str>) -> u32 {
    let mut lines = original_lines.clone();
    for i in 0..lines[0].len() {
        let counters = build_counters(&lines);
        if counters[i].ones >= counters[i].zeros {
            lines = lines.into_iter().filter(|line| (line.as_bytes()[i] as char) == '0').collect();
        } else {
            lines = lines.into_iter().filter(|line| (line.as_bytes()[i] as char) == '1').collect();
        }
        if lines.len() == 1 {
            return isize::from_str_radix(&lines[0], 2).unwrap().try_into().unwrap();
        }
    }
    panic!("Unexpected!");
}

fn build_counters(lines: &Vec<&str>) -> Vec<Counter> {
    let mut counters: Vec<Counter> = Vec::new();
    for _ in 0..lines[0].len() {
        counters.push(Default::default());
    }
    for line in lines.iter() {
        for (i, x) in line.chars().enumerate() {
            match x {
                '1' => {
                    counters[i].ones += 1
                }
                '0' => {
                    counters[i].zeros += 1
                }
                _ => panic!("Unexpected")
            }
        }
    }
    counters
}

fn solution1(data: &str) -> u32 {
    let lines: Vec<&str> = data.lines().collect();
    let counters = build_counters(&lines);
    let gamma = gamma(&counters);
    let epsilon = epsilon(&counters);
    gamma * epsilon
}

fn solution2(data: &str) -> u32 {
    let lines: Vec<&str> = data.lines().collect();
    let oxygen = oxygen(&lines);
    let co2 = co2(&lines);
    oxygen * co2
}

fn main() {
    let data = read_to_string("input").expect("File couldn't load");
    let result1 = solution1(&data);
    println!("Solution 1: {}", result1);
    let result2 = solution2(&data);
    println!("Solution 2: {}", result2);
}


#[cfg(test)]
mod tests {
    use std::fs::read_to_string;

    #[test]
    fn sample1() {
        let data = read_to_string("sample").unwrap();
        let result = crate::solution1(&data);
        assert_eq!(198, result);
    }

    #[test]
    fn sample2() {
        let data = read_to_string("sample").unwrap();
        let result = crate::solution2(&data);
        assert_eq!(230, result);
    }

    #[test]
    fn solution1() {
        let data = read_to_string("input").unwrap();
        let result = crate::solution1(&data);
        assert_eq!(852500, result);
    }

    #[test]
    fn solution2() {
        let data = read_to_string("input").unwrap();
        let result = crate::solution2(&data);
        assert_eq!(1007985, result);
    }
}