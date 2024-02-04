import XCTest
@testable import Spiral

final class SpiralTests: XCTestCase {
    func test() {
        printSpiral(size: 3)
    }
}

func spiral(_ size: Int) -> [[Int]] {
    guard size > 1 else { return [[1]] }
    var grid = createGrid(size)
    var state = State(Pos(x: 0, y: 0), .right)
    
    let max = size * size
    for v in 0..<max {
        grid[state.pos.y][state.pos.x] = v + 1
        if v < max - 1 {
            state = nextState(state, grid)
        }
    }
    return grid
}

func printSpiral(size: Int) {
    spiral(3)
        .forEach { row in
        var string = ""
        row.forEach { v in
            string += String(format: "%02d ", v)
        }
        print(string)
    }
}

func nextState(_ state: State, _ grid: [[Int]]) -> State {
    let max = grid.count
    let dir = state.dir
    let pos = state.pos
    switch state.dir {
    case .right:
        if pos.x == max - 1 || grid[pos.y][pos.x + 1] != 0 {
            return nextState(State(pos, dir.nextDirection), grid)
        } else {
            return State(Pos(x: pos.x + 1, y: pos.y), dir)
        }
    case .down:
        if pos.y == max - 1 || grid[pos.y + 1][pos.x] != 0 {
            return nextState(State(pos, dir.nextDirection), grid)
        } else {
            return State(Pos(x: pos.x, y: pos.y + 1), dir)
        }
    case .left:
        if pos.x == 0 || grid[pos.y][pos.x - 1] != 0 {
            return nextState(State(pos, dir.nextDirection), grid)
        } else {
            return State(Pos(x: pos.x - 1, y: pos.y), dir)
        }
    case .up:
        if pos.y == 0 || grid[pos.y - 1][pos.x] != 0 {
            return nextState(State(pos, dir.nextDirection), grid)
        } else {
            return State(Pos(x: pos.x, y: pos.y - 1), dir)
        }
    }
}


struct Pos {
    var x: Int
    var y: Int
}

struct State {
    var pos: Pos
    var dir: Direction
    init(_ pos: Pos, _ dir: Direction) {
        self.pos = pos
        self.dir = dir
    }
}

func createGrid(_ size: Int) -> [[Int]] {
    var row = [Int]()
    for _ in 0..<size {
        row.append(0)
    }
    var rows = [[Int]]()
    for _ in 0..<size {
        rows.append(row)
    }
    return rows
}

enum Direction {
    case right
    case down
    case left
    case up
    
    var nextDirection: Direction {
        switch self {
        case .right: return .down
        case .down: return .left
        case .left: return .up
        case .up: return .right
        }
    }
}
