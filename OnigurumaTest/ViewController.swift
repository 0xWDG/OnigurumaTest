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

class ViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet weak var textViewCode: NSTextView!
    @IBOutlet weak var textViewOutput: NSTextView!

    let tokens = [
        "Foundation", "viewDidLoad\\(\\)",
        "func", "super", "override", "NSViewController", "class",
        "String", "try", "!", "SwiftOniguruma", "regex"
    ];

    let swiftCode = """
// Change me to see live results
// in the other textview ->

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
        textViewCode.string += swiftCode
        textViewCode.delegate = self

        reprocess()
    }

    func reprocess() {
        textViewOutput.string = ""
        textViewOutput.string += "Loaded Oniguruma version " + SwiftOniguruma.version() + "\r\n\r\n"
        textViewOutput.string += "Tokens: \"\(tokens.joined(separator: "\", \""))\".\r\n\r\n"

        for word in tokens {
            for match in match(regex: word) {

                textViewOutput.string += "Matched \"\(match.string!)\" " +
                                         "@ Range \(match.range), Test:" +
                textViewCode.string.substring(
                    match.range.lowerBound,
                    end: match.range.upperBound - 1
                ) + "\r\n"
            }
        }
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
