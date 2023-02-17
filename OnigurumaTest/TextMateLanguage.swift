//
//  TextMateLanguage.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Foundation

class TextMateLanguage {
    var language: TextMateFile?

    private var rawData: Data?
    private var dict: [String: Any] = [:]

    func parse(language: String) -> [Token] {
        do {
            rawData = try Data(
                contentsOf: Bundle.main.url(
                    forResource: "swift.tmLanguage",
                    withExtension: "json"
                )!
            )

            guard let rawData = rawData,
                  let dict = try JSONSerialization.jsonObject(
                    with: rawData, options: .mutableContainers) as? [String: Any] else {
                fatalError("invalid Json")
            }

            self.language = try JSONDecoder().decode(TextMateFile.self, from: rawData)

//            print(dict)
//            print("-----")
//            print("tmf = ", self.language)
            
        }
        catch {
            print(error)
            fatalError(error.localizedDescription)
        }

        return [
            .init(start: "(weak|var|struct|class|try|return|override|super|import|didSet|Any)", color: .purple), // def.
            .init(start: "(String|NSTextView|NSColor)", color: .orange), // Types
            .init(start: "func [a-zA-Z]+\\(.*\\)", color: .systemTeal), // Function (call)
            .init(start: "//.*", color: .gray), // Single line Comment
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
        ]
    }
}
