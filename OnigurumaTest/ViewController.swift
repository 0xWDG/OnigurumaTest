//
//  ViewController.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 13/02/2023.
//

import Cocoa
import SwiftOniguruma

class ViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet weak var textViewCode: NSTextView!
    @IBOutlet weak var textViewOutput: NSTextView!

    var isProcessing = false

    let tokens: [Token] = TextMateLanguage().parse(language: "")

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
                        for middleMatch in self.match(
                            regex: currentToken,
                            string: textViewCode.string.substring(
                                match.range.lowerBound,
                                end: match.range.upperBound - 1
                            )
                        ) {
                            // Middle token, This uses the matched string (match), and work with that.
                            // To manipulate the textview, be sure to use the match.range.lowerBound.
                            // Calculate length with match.range.lowerBound + middleMatch
                            textViewOutput.string += "Middle Matched \"\(middleMatch.string!)\" " +
                            "@ Range \(middleMatch.range), Test:" +
                            textViewCode.string.substring(
                                match.range.lowerBound + middleMatch.range.lowerBound,
                                end: match.range.lowerBound + middleMatch.range.upperBound - 1
                            ) + "\r\n"

                            textViewCode.textStorage?.addAttributes(
                                [NSAttributedString.Key.foregroundColor: NSColor.red],
                                range: NSRange(
                                    location: match.range.lowerBound + middleMatch.range.lowerBound,
                                    length: (middleMatch.range.upperBound) - middleMatch.range.lowerBound
                                )
                            )
                        }
                    }
                }
            }
        }

        isProcessing = false
    }

    func match(regex: String, string: String = "") -> [Region] {
        let regex = try! SwiftOniguruma.Regex(pattern: regex)
        return try! regex.matches(
            in: (string == "" ? textViewCode.string : string),
            of: 0...
        )
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
