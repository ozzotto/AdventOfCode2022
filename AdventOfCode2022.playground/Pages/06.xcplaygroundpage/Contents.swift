//: [Previous](@previous)

import Foundation

let input0 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
let input1 = "nppdvjthqldpwncqszvftbrmjlhg"
let input2 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
let input3 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

// MARK: - Methods

func findCharacterCountForDistinct(input: String, distinctCount: Int) -> Int {
    var recentCharacters: [Character] = []

    for (index, character) in input.enumerated() {
        // print(message: "Checking \(character) at \(index)", day: 6)
        if recentCharacters.contains(character) {
            recentCharacters.removeAll(where: { $0 == character })
            recentCharacters.append(character)
            if recentCharacters.count == distinctCount {
                if checkStringIfDistinct(input: input, index: index, distinctCount: distinctCount) {
                    return index + 1
                } else {
                    recentCharacters.removeFirst()
                }
            }
        } else {
            recentCharacters.append(character)
            if recentCharacters.count == distinctCount {
                if checkStringIfDistinct(input: input, index: index, distinctCount: distinctCount) {
                    return index + 1
                } else {
                    recentCharacters.removeFirst()
                }
            }
        }
    }
    return -1
}

func checkStringIfDistinct(input: String, index: Int, distinctCount: Int) -> Bool {
    let end = input.index(input.startIndex, offsetBy: index)
    let start = input.index(end, offsetBy: -1 * (distinctCount - 1))
    let range = start...end
    let recentString = input[range]
    // print(message: "Checking recent \(recentString)", day: 6)
    let unique = Set(recentString)
    // print(message: "Unique \(unique)", day: 6)
    let isMarker = (unique.count == distinctCount)
    // print(message: "Marker \(isMarker)", day: 6)
    return isMarker
}

let input = readInput(filename: "Input6")!

// MARK: - Part 1
// print(message: "Marker is \(findCharacterCountForDistinct(input: input, distinctCount: 4))", day: 6)

// MARK: - Part 2
print(message: "Message is \(findCharacterCountForDistinct(input: input, distinctCount: 14))", day: 6)

//: [Next](@next)
