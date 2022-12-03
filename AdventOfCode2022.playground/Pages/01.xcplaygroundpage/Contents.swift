//: [Previous](@previous)

import Foundation

func parseInputAndCalculateSumOfCaloriesPerElf(input: String) -> [Int] {
    var calories: [Int] = []

    let lines = input.components(separatedBy: .newlines)

    var sum = 0
    for line in lines {
        if line.isEmpty {
            calories.append(sum)
            sum = 0
            continue
        }
        if let value = Int(line) {
            sum += value
        }
    }

    return calories
}

func findTheElfCarryingTheMostCalories() {
    guard let input = readInput(filename: "Input1") else {
        print(message: "Invalid input", day: 1)
        return
    }

    let caloriesPerElf = parseInputAndCalculateSumOfCaloriesPerElf(input: input)

    let maxCalories = caloriesPerElf.max() ?? -1
    print(message: "\(maxCalories)", day: 1)
}

func findTheTopThreeElvesCarryingTheMostCalories() {
    guard let input = readInput(filename: "Input1") else {
        print(message: "Invalid input", day: 1)
        return
    }

    let caloriesPerElf = parseInputAndCalculateSumOfCaloriesPerElf(input: input).sorted(by: >)
    let sumOfTopThreeElves = caloriesPerElf[0] + caloriesPerElf[1] + caloriesPerElf[2]
    print(message: "\(sumOfTopThreeElves)", day: 1)
}

findTheElfCarryingTheMostCalories()
findTheTopThreeElvesCarryingTheMostCalories()

//: [Next](@next)
