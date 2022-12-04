//: [Previous](@previous)

import Foundation

struct Pair {
    let elfA: ClosedRange<Int>
    let elfB: ClosedRange<Int>

    var fullyContains: Bool {
        return (elfA.contains(elfB.lowerBound) && elfA.contains(elfB.upperBound)) || (elfB.contains(elfA.lowerBound) && elfB.contains(elfA.upperBound))
    }

    var overlaps: Bool {
        elfA.overlaps(elfB) || elfB.overlaps(elfA)
    }
}

func parseInput() -> [Pair] {

//    let input = """
//    2-4,6-8
//    2-3,4-5
//    5-7,7-9
//    2-8,3-7
//    6-6,4-6
//    2-6,4-8
//    """

    guard let input = readInput(filename: "Input4") else {
        print(message: "Invalid input", day: 3)
        return []
    }

    let lines = input.components(separatedBy: .newlines)
    var pairs: [Pair] = []
    for line in lines {
        if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
        let components = line.components(separatedBy: ",") // [2-4, 6-8]
        var elfA: ClosedRange<Int>?
        var elfB: ClosedRange<Int>?
        for component in components {
            let dashIndex = component.firstIndex(of: "-")!
            let startChar = component.prefix(upTo: dashIndex)
            let start = Int(startChar)!
            let suffixIndex = component.index(dashIndex, offsetBy: 1)
            let endChar = component.suffix(from: suffixIndex)
            let end = Int(endChar)!
            print(message: "\(start)-\(end)", day: 4)
            let range = start...end

            if elfA == nil {
                elfA = range
            } else if elfB == nil {
                elfB = range
            } else {
                break
            }
        }
        let pair = Pair(elfA: elfA!, elfB: elfB!)
        pairs.append(pair)

    }
    return pairs
}

// MARK: - Part 1

func calculateFullyContainingPairs(pairs: [Pair]) {
    let fullyContained = pairs.filter { $0.fullyContains == true }
    print(message: "Count is \(fullyContained.count)", day: 4)
}

// MARK: - Part 2

func calculateOverlappingPairs(pairs: [Pair]) {
    let overlapping = pairs.filter { $0.overlaps == true }
    print(message: "Count is \(overlapping.count)", day: 4)
}


let pairs = parseInput()
//calculateFullyContainingPairs(pairs: pairs)
calculateOverlappingPairs(pairs: pairs)

//: [Next](@next)
