const fs = require("fs");

function Line(x1, y1, x2, y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.currentX = x1;
    this.currentY = y1;

    this.next = () => {
        if(this.currentX === this.x2 && this.currentY === this.y2) {
            return false;
        }
        if(this.currentY < this.y2) {
            this.currentY++;
        } else if (this.currentY > this.y2) {
            this.currentY--;
        }
        if(this.currentX < this.x2) {
            this.currentX++;
        } else if (this.currentX > this.x2) {
            this.currentX--;
        }
        return {x: this.currentX, y: this.currentY};
    }

    return this;
}

function readFile(fileName) {
    const lines = fs.readFileSync(fileName, "utf8").split("\n");

    return lines.map(line =>{
        const firstSecond = line.split(" -> ");
        const first = firstSecond[0].split(",");
        const second = firstSecond[1].split(",");
        const x1 = parseInt(first[0]);
        const y1 = parseInt(first[1]);
        const x2 = parseInt(second[0]);
        const y2 = parseInt(second[1]);

        return new Line(x1, y1, x2, y2);
    });
}

function addToGrid(grid, x, y) {
    if(grid.hasOwnProperty(`${x},${y}`)) {
        grid[`${x},${y}`]++;
    } else {
        grid[`${x},${y}`] = 1;
    }
}

function solution1(lines){
    const linesV1 = lines.filter(line => line.x1 === line.x2 || line.y1 === line.y2);
    const gridV1 = {};
    for(const line of linesV1) {
        addToGrid(gridV1, line.x1, line.y1);
        let current = line.next();
        while(current !== false){
            addToGrid(gridV1, current.x, current.y);
            current = line.next();
        }
    }
 
    return Object.keys(gridV1).map(key => gridV1[key]).filter(value => value >= 2).length;
}

function solution2(lines) {
    const linesV2 = lines;
    const gridV2 = {};
    for(const line of linesV2) {
            addToGrid(gridV2, line.x1, line.y1);
            let current = line.next();
            while(current !== false){
                addToGrid(gridV2, current.x, current.y);
                current = line.next();
            }
        }

    return Object.keys(gridV2).map(key => gridV2[key]).filter(value => value >= 2).length;
}

function main() {
    const lines = readFile("input");
    
    console.log("Solution1: ", solution1(lines));

    const linesV2 = readFile("input");
    
    console.log("Solution2: ", solution2(linesV2));
}

module.exports = {
    "solution1": solution1,
    "solution2": solution2,
    "readFile": readFile,
}

main();