//
//  TextMateDeclaration.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Foundation

struct TextMateFile: Codable {
    var information_for_contributors: [String]
    var name: String
    var patterns: [[String: String]]
    var scopeName: String
    var version: String
//    var repository: Any
}

struct TMRepositoryItem {
    var captures: [String]
    var match: String
}
