//: [Previous](@previous)

import Foundation

let input0 = """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""

var current: String = "" {
    didSet {
        print(message: "Current is \(current)", day: 7)
    }
}
var pathSizes: [String: Int] = [:]
var path = "" {
    didSet {
        print(message: "Path is \(path)", day: 7)
    }
}

let input = readInput(filename: "Input7")!
var lines = input.components(separatedBy: .newlines)
for line in lines {
    // print(message: "\(line)", day: 7)
    if line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
    runCommand(line)
}

func runCommand(_ line: String) {
    let components = line.components(separatedBy: .whitespaces)

    // cd
    if line.hasPrefix("$ cd") {
        if line.hasPrefix("$ cd ..") {
            let parent = String(path.dropLast(current.count + 1))
            pathSizes[parent] = (pathSizes[parent] ?? 0) + pathSizes[path]!
            path = parent
            current = parent.components(separatedBy: "_").last!
            return
        }

        let name = components.last!
        if path.isEmpty {
            path = name
        } else {
            path += ("_" + name)
        }
        current = name
        return

    }

    // ls
    if line.hasPrefix("$ ls") {
        return
    }

    // dir
    if line.hasPrefix("dir") {
        return
    }

    // file
    let size = Int(components.first!)!
    pathSizes[path] = (pathSizes[path] ?? 0) + size
}

// MARK: - Part 1
var totalSize = 0
let numberOfDirUpRequired = path.components(separatedBy: "_").count - 1
for _ in 0..<numberOfDirUpRequired {
    runCommand("$ cd ..")
}
pathSizes.forEach { name, size in
    if size <= 100000 {
        print(message: "Path \(name) size is \(size)", day: 7)
        totalSize += size
    }
}
print(message: "Total size is \(totalSize)", day: 7)

// MARK: - Part 2

let diskSize = 70000000
let updateMinSizeRequired = 30000000
let sizeUsed = pathSizes["/"]!
let availableSize = diskSize - sizeUsed
let neededSizeToUpdate = updateMinSizeRequired - availableSize

let directoryTuples: [(String, Int)] = pathSizes.map { ($0, $1) }.sorted(by: { $0.1 < $1.1 })
let smallest = directoryTuples.first(where: { $0.1 >= neededSizeToUpdate })
print(message: "Smallest is \(smallest!.0) with size \(smallest!.1)", day: 7)

//: [Next](@next)
