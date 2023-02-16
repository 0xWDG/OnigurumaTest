//
//  String.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Foundation

extension String {
    /// Substring
    /// - Parameters:
    ///   - start: start
    ///   - end: end
    /// - Returns: subscripted string (int+int)
    func substring(_ start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        if startIndex > endIndex {
            print("Index \(start) > \(end)")
            return self
        }
        return String(self[startIndex...endIndex])
    }
}
