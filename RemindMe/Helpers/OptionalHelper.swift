//
//  OptionalHelper.swift
//  Volve
//
//  Created by Azura Sakan Taufik on 22/08/21.
//

import Foundation

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension Optional where Wrapped == Date {
    var _bound: Date? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: Date {
        get {
            return _bound ?? Date()
        }
        set {
            _bound = newValue
        }
    }
}
