//: [Previous](@previous)

import Foundation

enum Item: String {
    case a, b, c, d, e, f, g, h, i, j, k , l, m, n, o, p, q, r, s , t, u, v, w, x, y, z
    case A, B, C, D, E, F, G, H, I, J, K , L, M, N, O, P, Q, R, S , T, U, V, W, X, Y, Z

    var value: Int {
        switch self {
        case .a: return 1
        case .b: return 2
        case .c: return 3
        case .d: return 4
        case .e: return 5
        case .f: return 6
        case .g: return 7
        case .h: return 8
        case .i: return 9
        case .j: return 10
        case .k: return 11
        case .l: return 12
        case .m: return 13
        case .n: return 14
        case .o: return 15
        case .p: return 16
        case .q: return 17
        case .r: return 18
        case .s: return 19
        case .t: return 20
        case .u: return 21
        case .v: return 22
        case .w: return 23
        case .x: return 24
        case .y: return 25
        case .z: return 26
        case .A: return 27
        case .B: return 28
        case .C: return 29
        case .D: return 30
        case .E: return 31
        case .F: return 32
        case .G: return 33
        case .H: return 34
        case .I: return 35
        case .J: return 36
        case .K: return 37
        case .L: return 38
        case .M: return 39
        case .N: return 40
        case .O: return 41
        case .P: return 42
        case .Q: return 43
        case .R: return 44
        case .S: return 45
        case .T: return 46
        case .U: return 47
        case .V: return 48
        case .W: return 49
        case .X: return 50
        case .Y: return 51
        case .Z: return 52
        }
    }
}

struct Rucksack {
    let value: String

    var firstCompartment: String {
        let middle = value.index(value.startIndex, offsetBy: (value.count / 2))
        return String(value[..<middle])
    }

    var secondCompartment: String {
        let middle = value.index(value.startIndex, offsetBy: (value.count / 2))
        return String(value[middle..<value.endIndex])
    }

    var commonItem: String? {
        let first = Set(firstCompartment)
        let second = Set(secondCompartment)
        let common = first.intersection(second)
        guard let first = common.first else {
            return nil
        }
        return String(first)
    }
}

// MARK: - Part 1

func parseInputAndCalculateRucksacks() -> [Rucksack] {
    guard let input = readInput(filename: "Input3") else {
        print(message: "Invalid input", day: 3)
        return []
    }

    let lines = input.components(separatedBy: .newlines)
    let rucksacks = lines.map { Rucksack(value: $0) }
    return rucksacks
}

func calculateSumOfPriorities(_ ruckSacks: [Rucksack]) {
    let sum = ruckSacks.reduce(0) { previousSum, ruckSack in
        if let common = ruckSack.commonItem, let item = Item(rawValue: common) {
            return previousSum + item.value
        }
        return previousSum
    }
    print(message: "Sum is \(sum)", day: 3)
}

// MARK: - Part 2

func parseInputAndCalculateGroups() -> [[Rucksack]] {
    guard let input = readInput(filename: "Input3") else {
        print(message: "Invalid input", day: 3)
        return []
    }

//    let input = """
//    vJrwpWtwJgWrhcsFMMfFFhFp
//    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
//    PmmdzqPrVvPwwTWBwg
//    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
//    ttgJtRGJQctTZtZT
//    CrZsJsPPZsGzwwsLwLmpwMDw
//    """

    var rucksacks: [Rucksack] = []
    var groups: [[Rucksack]] = []
    let lines = input.components(separatedBy: .newlines)

    for i in 0..<lines.count {
        let line = lines[i]
        let rucksack = Rucksack(value: line)
        rucksacks.append(rucksack)

        if i % 3 == 2 {
            groups.append(rucksacks)
            rucksacks.removeAll()
        }
    }

    return groups
}

func calculateSumOfPrioritiesInGroups(_ groups: [[Rucksack]]) {
    let commonItems = groups.compactMap { group in
        let common = group.reduce(Set(group[0].value)) { $0.intersection($1.value) }
        return common.first
    }
    let items = commonItems.compactMap { Item(rawValue: String($0)) }
    let sum = items.reduce(0) { $0 + $1.value }
    print(message: "Sum is \(sum)", day: 3)

}


// MARK: - Run

//let ruckSacks = parseInputAndCalculateRucksacks()
// calculateSumOfPriorities(ruckSacks)
calculateSumOfPrioritiesInGroups(parseInputAndCalculateGroups())

//: [Next](@next)
