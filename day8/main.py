class Sample:
    def __init__(self, patterns, targets):
        self.patterns = patterns
        self.targets = targets

def main():
    samples = []
    with open("input") as f:
        lines = f.readlines()
        for line in lines:
            patterns_targets = line.split(" | ")

            samples.append(Sample(patterns_targets[0].split(" "), patterns_targets[1].split(" ")))
    n1 = solution1(samples)
    print(n1)
    n2 = solution2(samples)
    print(n2)

def solution2(samples):
    n = 0

    for sample in samples:
        a = find_a(sample.patterns)
        c = find_c(sample.patterns)
        f = find_f(sample.patterns, c)
        e = find_e(sample.patterns)
        d = find_d(sample.patterns)
        b = find_b(sample.patterns, d)
        g = (set("abcdefg") - set([a,b,c,d,e,f])).pop()
        table = {
            "a": a,
            "b": b,
            "c": c,
            "d": d,
            "e": e,
            "f": f,
            "g": g
        }
        inv_map = {v: k for k, v in table.items()}
        tvalue = 0
        for i, target in enumerate(sample.targets):
            target = target.strip()
            decoded = [inv_map[x] for x in target]
            tvalue += get_value(decoded) * (10**(3 - i))
        n += tvalue

    return n

def get_value(value):
    if len(value) == 2:
        return 1
    elif len(value) == 3:
        return 7
    elif len(value) == 7:
        return 8
    elif len(value) == 4:
        return 4
    elif len(value) == 6:
        if "d" not in value:
            return 0
        elif "c" not in value:
            return 6
        elif "e" not in value:
            return 9
    else:
        if "e" in value:
            return 2
        elif "b" in value:
            return 5
        elif "f" in value:
            return 3
    
    raise ValueError(f"Invalid value: {value}")

def solution1(samples):
    n = 0
    for sample in samples:
        for target in sample.targets:
            target = target.strip()
            if len(target) == 7:
                n += 1
            elif len(target) == 2:
                n += 1
            elif len(target) == 3:
                n += 1
            elif len(target) == 4:
                n += 1
    return n

def find_a(patterns):
    for pattern1 in patterns:
        if len(pattern1) == 2:
            for pattern7 in patterns:
                if len(pattern7) == 3:
                    return (set(pattern7) - set(pattern1)).pop()

def find_d(patterns):
    for pattern1 in patterns:
        if len(pattern1) == 2:
            for pattern4 in patterns:
                if len(pattern4) == 4:
                    for pattern0 in patterns:
                        if len(pattern0) == 6 and len(set(pattern0) - set(pattern1)) == 4 and len(set(pattern0) - set(pattern4)) == 3:
                            return (set("abcdefg") - set(pattern0)).pop()

def find_e(patterns):
    for pattern4 in patterns:
        if len(pattern4) == 4:
            for pattern9 in patterns:
                if len(pattern9) == 6 and len(set(pattern9) - set(pattern4)) == 2:
                    return (set("abcdefg") - set(pattern9)).pop()

def find_b(patterns, d):
    for pattern4 in patterns:
        if len(pattern4) == 4:
            for pattern1 in patterns:
                if len(pattern1) == 2:
                    return (set(pattern4) - set(pattern1) - set(d)).pop()

def find_c(patterns):
    for pattern1 in patterns:
        if len(pattern1) == 2:
            for pattern6 in patterns:
                if len(pattern6) == 6 and len(set(pattern6) - set(pattern1)) == 5:
                    return (set("abcdefg") - set(pattern6)).pop()

def find_f(patterns, c):
    for pattern1 in patterns:
        if len(pattern1) == 2:
            return (set(pattern1) - set(c)).pop()

main()