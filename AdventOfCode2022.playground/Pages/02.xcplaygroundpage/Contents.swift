//: [Previous](@previous)

import Foundation

enum MyMove: String {
    case x  // rock
    case y  // paper
    case z  // scissors

    var value: Int {
        switch self {
        case .x: return 1
        case .y: return 2
        case .z: return 3
        }
    }
}

enum OtherMove: String {
    case a  // rock
    case b  // paper
    case c  // scissors
}

enum Outcome: Int {
    case loss = 0
    case draw = 3
    case win = 6
}

enum Part2Outcome: String {
    case x  // loss
    case y  // draw
    case z  // win

    var value: Int {
        switch self {
        case .x: return 0
        case .y: return 3
        case .z: return 6
        }
    }
}

enum Part2MyMove: Int {
    case rock = 1
    case paper = 2
    case sciccors = 3
}

func calculateOutcome(otherMove: OtherMove, myMove: MyMove) -> Outcome {
    switch myMove {
    case .x:
        switch otherMove {
        case .a: return .draw
        case .b: return .loss
        case .c: return .win
        }
    case .y:
        switch otherMove {
        case .a: return .win
        case .b: return .draw
        case .c: return .loss
        }
    case .z:
        switch otherMove {
        case .a: return .loss
        case .b: return .win
        case .c: return .draw
        }
    }
}

func calculateScore(myMove: MyMove, outcome: Outcome) -> Int {
    return myMove.value + outcome.rawValue
}

func calculateScore(myMove: Part2MyMove, outcome: Part2Outcome) -> Int {
    return myMove.rawValue + outcome.value
}

func parseInputAndCalculateMoves(input: String) -> [(OtherMove, MyMove)] {
    let lines = input.components(separatedBy: .newlines)

    var moves: [(OtherMove, MyMove)] = []
    for line in lines {
        if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
        let characters = line.components(separatedBy: .whitespaces)
        print(message: "\(characters)", day: 2)
        let first = characters.first!.lowercased()
        let otherMove = OtherMove(rawValue: first)!
        let last = characters.last!.lowercased()
        let myMove = MyMove(rawValue: last)!
        moves.append((otherMove, myMove))
    }

    return moves
}

func parseInputAndCalculateRounds(input: String) -> [(OtherMove, Part2Outcome)] {
    let lines = input.components(separatedBy: .newlines)
    var rounds: [(OtherMove, Part2Outcome)] = []
    for line in lines {
        if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
        let characters = line.components(separatedBy: .whitespaces)
        // print(message: "\(characters)", day: 2)
        let first = characters.first!.lowercased()
        let otherMove = OtherMove(rawValue: first)!
        let last = characters.last!.lowercased()
        let outcome = Part2Outcome(rawValue: last)!
        rounds.append((otherMove, outcome))
    }
    return rounds
}

func calculateMyMove(otherMove: OtherMove, outcome: Part2Outcome) -> Part2MyMove {
    switch otherMove {
    case .a: // rock
        switch outcome {
        case .x: return .sciccors
        case .y: return .rock
        case .z: return .paper
        }
    case .b: // paper
        switch outcome {
        case .x: return .rock
        case .y: return .paper
        case .z: return .sciccors
        }
    case .c: // sciccors
        switch outcome {
        case .x: return .paper
        case .y: return .sciccors
        case .z: return .rock
        }
    }
}

func calculateTotalScore() {
    guard let input = readInput(filename: "Input2") else {
        print(message: "Invalid input", day: 1)
        return
    }

    var totalScore = 0
    let moves = parseInputAndCalculateMoves(input: input)

    for move in moves {
        let outcome = calculateOutcome(otherMove: move.0, myMove: move.1)
        let score = calculateScore(myMove: move.1, outcome: outcome)
        totalScore += score
    }

    print(message: "My score is \(totalScore)", day: 2)
}

func calculateTotalScorePart2() {
    guard let input = readInput(filename: "Input2") else {
        print(message: "Invalid input", day: 1)
        return
    }

    var totalScore = 0
    let rounds = parseInputAndCalculateRounds(input: input)

    for round in rounds {
        let myMove = calculateMyMove(otherMove: round.0, outcome: round.1)
        let score = calculateScore(myMove: myMove, outcome: round.1)
        totalScore += score
    }

    print(message: "My score is \(totalScore)", day: 2)
}

calculateTotalScorePart2()

//: [Next](@next)
