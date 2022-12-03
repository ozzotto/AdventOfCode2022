import Foundation

public func readInput(filename: String) -> String? {
    guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "txt") else {
        return nil
    }
    return try? String(contentsOf: fileURL, encoding: String.Encoding.utf8)
}

public func print(message: String, day: Int) {
    print("AdventOfCode2022 - Day \(day) ==> \(message)")
}
