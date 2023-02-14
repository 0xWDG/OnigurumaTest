//
//  ViewController.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 13/02/2023.
//

import Cocoa
import SwiftOniguruma

extension String {
    /// Substring
    /// - Parameters:
    ///   - start: start
    ///   - end: end
    /// - Returns: subscripted string (int+int)
    func substring(_ start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex...endIndex])
    }
}

extension NSColor {
    public func random() -> NSColor {
        return [
            NSColor.red, NSColor.blue, NSColor.orange
        ].randomElement()!
    }
}
struct Token {
    var regex: String
    var color: NSColor

    var debugDescription: String {
        switch color {
        case .purple:
            return "Token(\"\(regex)\", Purple)"
        case .orange:
            return "Token(\"\(regex)\", Orange)"
        case .systemTeal:
            return "Token(\"\(regex)\", System Teal)"
        case .gray:
            return "Token(\"\(regex)\", Grey)"
        case .red:
            return "Token(\"\(regex)\", Red)"
        case .blue:
            return "Token(\"\(regex)\", Blue)"
        default:
            return "Token(\"\(regex)\", \(color))"
        }
    }
}

class ViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet weak var textViewCode: NSTextView!
    @IBOutlet weak var textViewOutput: NSTextView!

    var isProcessing = false

    let tokens: [Token] = [
        .init(regex: "(weak|var|struct|class|try|return|override|super|import|didSet|Any)", color: .purple), // def.
        .init(regex: "(String|NSTextView|NSColor)", color: .orange), // Types
        .init(regex: "func [a-zA-Z]+\\(.*\\)", color: .systemTeal), // Function (call)
        .init(regex: "// .*", color: .gray), // Single line Comment
        .init(regex: "\".*\"", color: .red), // String contents
        .init(regex: "({|}|\\(|\\))", color: .blue) // Brackets
    ];

    let swiftCode = """
// Change me to see live results
// in both text views.

import Foundation

class VC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func match(regex: String) -> [Region] {
        let regex = try! SwiftOniguruma.Regex(pattern: regex)
        return try! regex.matches(in: swiftCode, of: 0...)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
"""

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewCode.textStorage?.setAttributedString(NSAttributedString(string: swiftCode))
        textViewCode.delegate = self

        reprocess()
    }

    func reprocess() {
        if isProcessing {
            return
        }

        isProcessing = true
        textViewOutput.string = ""
        textViewOutput.string += "Loaded Oniguruma version " + SwiftOniguruma.version() + "\r\n\r\n"
        textViewOutput.string += "Tokens:\r\n- \(tokens.map({$0.debugDescription}).joined(separator: ",\r\n- ")))\".\r\n\r\n"


        for token in tokens {
            for match in match(regex: token.regex) {

                textViewOutput.string += "Matched \"\(match.string!)\" " +
                                         "@ Range \(match.range), Test:" +
                textViewCode.string.substring(
                    match.range.lowerBound,
                    end: match.range.upperBound - 1
                ) + "\r\n"

                textViewCode.textStorage?.addAttributes(
                    [NSAttributedString.Key.foregroundColor: token.color],
                    range: NSRange(
                        location: match.range.lowerBound,
                        length: (match.range.upperBound) - match.range.lowerBound
                    )
                )
            }
        }

        isProcessing = false
    }

    func match(regex: String) -> [Region] {
        let regex = try! SwiftOniguruma.Regex(pattern: regex)
        return try! regex.matches(in: textViewCode.string, of: 0...)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func textDidChange(_ notification: Notification) {
        reprocess()
    }
}
