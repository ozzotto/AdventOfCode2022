//: [Previous](@previous)

import Foundation

struct Move {
    let from: Int
    let to: Int
    let count: Int
}

//var stacks = [
//    ["Z", "N"],
//    ["M", "C", "D"],
//    ["P"]
//]
//
//let movesString = """
//move 1 from 2 to 1
//move 3 from 1 to 3
//move 2 from 2 to 1
//move 1 from 1 to 2
//"""

/*
 [T]             [P]     [J]
 [F]     [S]     [T]     [R]     [B]
 [V]     [M] [H] [S]     [F]     [R]
 [Z]     [P] [Q] [B]     [S] [W] [P]
 [C]     [Q] [R] [D] [Z] [N] [H] [Q]
 [W] [B] [T] [F] [L] [T] [M] [F] [T]
 [S] [R] [Z] [V] [G] [R] [Q] [N] [Z]
 [Q] [Q] [B] [D] [J] [W] [H] [R] [J]
  1   2   3   4   5   6   7   8   9
 */
var stacks = [
    ["Q", "S", "W", "C", "Z", "V", "F", "T"],
    ["Q", "R", "B"],
    ["B", "Z", "T", "Q", "P", "M", "S"],
    ["D", "V", "F", "R", "Q", "H"],
    ["J", "G", "L", "D", "B", "S", "T", "P"],
    ["W", "R", "T", "Z"],
    ["H", "Q", "M", "N", "S", "F", "R", "J"],
    ["R", "N", "F", "W", "H", "W"],
    ["J", "Z", "T", "Q", "P", "R", "B"],
]

var moves: [Move] = []
let movesString = readInput(filename: "Moves")!
let lines = movesString.components(separatedBy: .newlines)
for line in lines {
    if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
    let moveRange = line.firstRange(of: "move")!
    let fromRange = line.firstRange(of: "from")!
    let toRange = line.firstRange(of: "to")!

    let countString = line[moveRange.upperBound..<fromRange.lowerBound].trimmingCharacters(in: .whitespaces)
    let fromString = line[fromRange.upperBound..<toRange.lowerBound].trimmingCharacters(in: .whitespaces)
    let toString = line[toRange.upperBound...].trimmingCharacters(in: .whitespaces)

    // print(message: "\(countString) - \(fromString) - \(toString)", day: 5)

    let count = Int(countString)!
    let from = Int(fromString)!
    let to = Int(toString)!

    // print(message: "\(count) - \(from) - \(to)", day: 5)

    let move = Move(from: from, to: to, count: count)
    moves.append(move)
}

// MARK: Part 1

//for move in moves {
//    var items: [String] = []
//    for _ in 0..<move.count {
//        items.append(stacks[move.from - 1].removeLast())
//    }
//    stacks[move.to - 1].append(contentsOf: items)
//}

// MARK: Part 2

for move in moves {
    var items: [String] = []
    for _ in 0..<move.count {
        items.append(stacks[move.from - 1].removeLast())
    }
    stacks[move.to - 1].append(contentsOf: items.reversed())
}

let topString = stacks.reduce("") { $0.appending($1.last!) }
print(message: "\(topString)", day: 5)

//: [Next](@next)
