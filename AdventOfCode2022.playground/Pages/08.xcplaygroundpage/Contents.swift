//: [Previous](@previous)

import Foundation

let input0 = """
30373
25512
65332
33549
35390
"""

struct Index: Hashable {
    let row: Int
    let column: Int
}

var trees: [Index: Int] = [:]
var scores: [Index: Int] = [:]

let input = readInput(filename: "Input8")!
var linesCount = 0
let lines  = input.components(separatedBy: .whitespacesAndNewlines)
for i in 0..<lines.count {
    let line = lines[i]
    if line.trimmingCharacters(in: .whitespaces).isEmpty { continue }
    linesCount += 1
    for j in 0..<line.count {
        let value = line[line.index(line.startIndex, offsetBy: j)]
        let index = Index(row: i, column: j)
        trees[index] = Int(String(value))!
    }
}

let columnsCount = lines.first!.count
var visibleTrees = 2 * linesCount + 2 * (columnsCount - 2)

for (index, tree) in trees {
    if index.row == 0 || index.row == (linesCount - 1) || index.column == 0 || index.column == (columnsCount - 1) {
        continue
    }

    // left
    var visibleFromLeft = true
    var leftColumn = index.column - 1
    var scoreLeft = 0
    while leftColumn >= 0 {
        scoreLeft += 1
        let leftIndex = Index(row: index.row, column: leftColumn)
        let leftTree = trees[leftIndex]!
        if leftTree >= tree {
            visibleFromLeft = false
            break
        }
        leftColumn -= 1
    }

    // top
    var visibleFromTop = true
    var topRow = index.row - 1
    var scoreTop = 0
    while topRow >= 0 {
        scoreTop += 1
        let topIndex = Index(row: topRow, column: index.column)
        let topTree = trees[topIndex]!
        if topTree >= tree {
            visibleFromTop = false
            break
        }
        topRow -= 1
    }

    // right
    var visibleFromRight = true
    var rightColumn = index.column + 1
    var scoreRight = 0
    while rightColumn <= columnsCount - 1 {
        scoreRight += 1
        let rightIndex = Index(row: index.row, column: rightColumn)
        let rightTree = trees[rightIndex]!
        if rightTree >= tree {
            visibleFromRight = false
            break
        }
        rightColumn += 1
    }

    // bottom
    var visibleFromBottom = true
    var bottomRow = index.row + 1
    var scoreBottom = 0
    while bottomRow <= linesCount - 1 {
        scoreBottom += 1
        let bottomIndex = Index(row: bottomRow, column: index.column)
        let bottomTree = trees[bottomIndex]!
        if bottomTree >= tree {
            visibleFromBottom = false
            break
        }
        bottomRow += 1
    }

    if visibleFromLeft || visibleFromTop || visibleFromRight || visibleFromBottom {
        visibleTrees += 1
    }

    var score = scoreLeft * scoreTop * scoreRight * scoreBottom
    scores[index] = score
}

print(message: "\(visibleTrees)", day: 8)

let maxScore = scores.values.max()
print(message: "Max score is \(maxScore)", day: 8)

//: [Next](@next)
