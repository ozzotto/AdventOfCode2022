//: [Previous](@previous)

import Foundation

enum Command {
    case noop
    case addx(Int)
}

var registerX = 1
var cycles: [Int: Int] = [:]
var commands: [Command] = []

let input = readInput(filename: "Input10")!
let lines = input.components(separatedBy: .newlines)
for line in lines {
    let components = line.components(separatedBy: .whitespaces)
    let command = components.first!
    switch command {
    case "noop": commands.append(.noop)
    case "addx":
        let count = components.last!
        commands.append(.addx(Int(count)!))
    default: break
    }
}

var cycle = 1
for command in commands {
    switch command {
    case .noop:
        cycle += 1
        cycles[cycle] = registerX
    case .addx(let count):
        cycles[cycle] = registerX
        cycles[cycle + 1] = registerX
        cycle += 2
        registerX += count
        cycles[cycle] = registerX
    }
}

// MARK: - Part 1

var sum = 0
for i in [20, 60, 100, 140, 180, 220] {
    let signalStrength = i * cycles[i]!
    sum += signalStrength
}
print(message: "Total is \(sum)", day: 10)

// MARK: - Part 2

var crtLines: [String] = []
var currentLine: String = ""
let maxCycle = cycles.keys.max()!
for cycle in 1...maxCycle {
    let position = cycle - 1
    let middle = cycles[cycle]! + crtLines.count * 40
    if [middle - 1, middle, middle + 1].contains(position) {
        currentLine.append("#")
    } else {
        currentLine.append(".")
    }
    if cycle % 40 == 0 {
        crtLines.append(currentLine)
        currentLine = ""
    }
}

for crtLine in crtLines { print(crtLine) }

//: [Next](@next)
