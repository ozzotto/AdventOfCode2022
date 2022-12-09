//: [Previous](@previous)

import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int

    func isAdjacent(other: Point) -> Bool {
        return (self.x == other.x && self.y == other.y)
        || (self.x == other.x && abs(self.y - other.y) == 1)
        || (self.y == other.y && abs(self.x - other.x) == 1)
        || (abs(self.x - other.x) == 1 && abs(self.y - other.y) == 1)
    }

    mutating func moveUp() { y += 1 }

    mutating func moveDown() { y -= 1 }

    mutating func moveLeft() { x -= 1 }

    mutating func moveRight() { x += 1 }

    mutating func moveClose(other: Point) {
        if self.isAdjacent(other: other) { return }
        if self.x == other.x {
            if self.y > other.y { self.y = other.y + 1 }
            if self.y < other.y { self.y = other.y - 1 }
            return
        }

        if self.y == other.y {
            if self.x > other.x { self.x = other.x + 1 }
            if self.x < other.x { self.x = other.x - 1 }
            return
        }

        if self.x > other.x && self.y > other.y {
            self.x -= 1
            self.y -= 1
            return
        }

        if self.x < other.x && self.y < other.y {
            self.x += 1
            self.y += 1
            return
        }

        if self.x > other.x && self.y < other.y {
            self.x -= 1
            self.y += 1
            return
        }

        if self.x < other.x && self.y > other.y {
            self.x += 1
            self.y -= 1
            return
        }
    }
}

let input0 = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

// MARK: - Part 1

var placesVisited: Set<Point> = Set([])
var head: Point = Point(x: 0, y: 0) {
    didSet {
        // print(message: "Head is at (\(head.x), \(head.y))", day: 9)
    }
}
var tail: Point = Point(x: 0, y: 0) {
    didSet {
        // print(message: "Tail is at (\(tail.y), \(tail.x))", day: 9)
    }
}

placesVisited.insert(tail)
let input = readInput(filename: "Input9")!
let lines = input.components(separatedBy: .newlines)
var moves: [(direction: String, count: Int)] = []
for line in lines {
    // print(message: "\(line)", day: 9)
    if line.trimmingCharacters(in: .whitespaces).isEmpty { continue }
    let components = line.components(separatedBy: .whitespaces)
    moves.append((direction: String(components.first!), count: Int(components.last!)!))
}

for move in moves {
    // print(message: "=== Command is \(move.direction) \(move.count) ===", day: 9)
    switch move.direction {
    case "U": for _ in 0..<move.count {
        head.moveUp()
        if !head.isAdjacent(other: tail) {
            tail.moveClose(other: head)
            placesVisited.insert(tail)
        }
    }
    case "D": for _ in 0..<move.count {
        head.moveDown()
        if !head.isAdjacent(other: tail) {
            tail.moveClose(other: head)
            placesVisited.insert(tail)
        }
    }
    case "L": for _ in 0..<move.count {
        head.moveLeft()
        if !head.isAdjacent(other: tail) {
            tail.moveClose(other: head)
            placesVisited.insert(tail)
        }
    }
    case "R": for _ in 0..<move.count {
        head.moveRight()
        if !head.isAdjacent(other: tail) {
            tail.moveClose(other: head)
            placesVisited.insert(tail)
        }
    }
    default: break
    }
}

let visited = placesVisited.count
print(message: "Visited count is \(visited)", day: 9)

// MARK: - Part 2

let input1 = """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""

var pointsTailVisited: Set<Point> = Set([])
pointsTailVisited.insert(.init(x: 0, y: 0))

var points: [Point] = [
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
    Point(x: 0, y: 0),
]

for move in moves {
    // print(message: "=== Command is \(move.direction) \(move.count) ===", day: 9)
    switch move.direction {
    case "U": for _ in 0..<move.count { moveUp() }
    case "D": for _ in 0..<move.count { moveDown() }
    case "L": for _ in 0..<move.count { moveLeft() }
    case "R": for _ in 0..<move.count { moveRight() }
    default: break
    }
}

func moveUp() {
    points[0].moveUp()
    for i in 1..<points.count {
        var point = points[i]
        point.moveClose(other: points[i-1])
        points[i] = point
        if i == points.count - 1 { pointsTailVisited.insert(points[i]) }
    }
}

func moveDown() {
    points[0].moveDown()
    for i in 1..<points.count {
        var point = points[i]
        point.moveClose(other: points[i-1])
        points[i] = point
        if i == points.count - 1 { pointsTailVisited.insert(points[i]) }
    }
}

func moveLeft() {
    points[0].moveLeft()
    for i in 1..<points.count {
        var point = points[i]
        point.moveClose(other: points[i-1])
        points[i] = point
        if i == points.count - 1 { pointsTailVisited.insert(points[i]) }
    }
}

func moveRight() {
    points[0].moveRight()
    for i in 1..<points.count {
        var point = points[i]
        point.moveClose(other: points[i-1])
        points[i] = point
        if i == points.count - 1 { pointsTailVisited.insert(points[i]) }
    }
}

print(message: "Visited count is \(pointsTailVisited.count)", day: 9)


//: [Next](@next)
