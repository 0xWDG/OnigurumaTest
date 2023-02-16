//
//  Token.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Cocoa

struct Token {
    var start: String
    var middle: [String]?
    var end: String?

    var color: NSColor

    var debugDescription: String {
        switch color {
        case .purple:
            return "Token(\"\(start)\", Purple)"
        case .orange:
            return "Token(\"\(start)\", Orange)"
        case .systemTeal:
            return "Token(\"\(start)\", System Teal)"
        case .gray:
            return "Token(\"\(start)\", Grey)"
        case .red:
            return "Token(\"\(start)\", Red)"
        case .blue:
            return "Token(\"\(start)\", Blue)"
        default:
            return "Token(\"\(start)\", \(color))"
        }
    }
}
