//
//  NSColor.swift
//  OnigurumaTest
//
//  Created by Wesley de Groot on 16/02/2023.
//

import Cocoa

extension NSColor {
    public func random() -> NSColor {
        return [
            NSColor.red, NSColor.blue, NSColor.orange
        ].randomElement()!
    }
}
