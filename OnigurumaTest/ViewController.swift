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

class ViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet weak var textViewCode: NSTextView!
    @IBOutlet weak var textViewOutput: NSTextView!

    var isProcessing = false

    let tokens: [Token] = [
        .init(start: "(weak|var|struct|class|try|return|override|super|import|didSet|Any)", color: .purple), // def.
        .init(start: "(String|NSTextView|NSColor)", color: .orange), // Types
        .init(start: "func [a-zA-Z]+\\(.*\\)", color: .systemTeal), // Function (call)
        .init(start: "// .*", color: .gray), // Single line Comment
        .init(start: "\".*\"", color: .red), // String contents
        .init(start: "({|}|\\(|\\))", color: .blue), // Brackets
        .init(start: "(@)(?<q>`?)[\\p{L}_][\\p{L}_\\p{N}\\p{M}]*(\\k<q>)", color: .brown),

        // TextMate regular expression
            .init(
                start: "((@)available)(\\()",
                middle: [
                    "\\b(swift|(?:iOS|macOS|OSX|watchOS|tvOS|UIKitForMac)(?:ApplicationExtension)?)\\b(?:\\s+([0-9]+(?:\\.[0-9]+)*\\b))?",
                    "\\b(introduced|deprecated|obsoleted)\\s*(:)\\s*(?!\\G)",
                    "\\b(message|renamed)\\s*(:)\\s*(?=\")(?!\\G)",
                    "(?:(\\*)|\\b(deprecated|unavailable|noasync)\\b)\\s*(.*?)(?=[,)])"
                ],
                end: "\\)",
                color: .green
            )
    ];

    let swiftCode = try! String(
        contentsOf: Bundle.main.url(
            forResource: "TestCode",
            withExtension: "txt"
        )!
    )

    override func viewDidLoad() {

        super.viewDidLoad()

        textViewCode.textStorage?.setAttributedString(
            NSAttributedString(string: swiftCode)
        )

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
            for match in match(
                regex: token.start + ".*" + (token.end ?? "")
            ) {
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

                if let middle = token.middle {
                    for currentToken in middle {
                        for match in self.match(regex: currentToken) {
                            textViewOutput.string += "Matched \"\(match.string!)\" " +
                            "@ Range \(match.range), Test:" +
                            textViewCode.string.substring(
                                match.range.lowerBound,
                                end: match.range.upperBound - 1
                            ) + "\r\n"

                            textViewCode.textStorage?.addAttributes(
                                [NSAttributedString.Key.foregroundColor: NSColor.red],
                                range: NSRange(
                                    location: match.range.lowerBound,
                                    length: (match.range.upperBound) - match.range.lowerBound
                                )
                            )

                        }
                    }
                }
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
