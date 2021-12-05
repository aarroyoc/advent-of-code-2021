const { solution1, solution2, readFile} = require("./index");

test("sample 1", () => {
    const lines = readFile("sample");
    expect(solution1(lines)).toBe(5);
});

test("sample 2", () => {
    const lines = readFile("sample");
    expect(solution2(lines)).toBe(12);
});

test("solution 1", () => {
    const lines = readFile("input");
    expect(solution1(lines)).toBe(7142);
});

test("solution 2", () => {
    const lines = readFile("input");
    expect(solution2(lines)).toBe(20012);
});