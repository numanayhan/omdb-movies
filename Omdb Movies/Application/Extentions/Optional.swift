//
//  Optional.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }

    var nonEmpty: Wrapped? {
        guard let collection = self else { return nil }
        guard !collection.isEmpty else { return nil }
        return collection
    }
}

public protocol DefaultValue {
    associatedtype DefaultType: DefaultValue where DefaultType.DefaultType == Self
    static var defaultValue: DefaultType { get }
}

public extension Optional where Wrapped: DefaultValue, Wrapped.DefaultType == Wrapped {
    var required: Wrapped {
        defer {
            if self == nil {
                assertionFailure("Value can not be nil because you try to unwrap value")
            }
        }
        return valueOrDefault
    }

    var valueOrDefault: Wrapped {
        guard let notNilSelf = self else {
            return Wrapped.defaultValue
        }
        return notNilSelf
    }
}

public extension Optional {
    var required: Wrapped {
        guard let notNilSelf = self else {
            return self!
        }
        return notNilSelf
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isEmpty
        } else {
            return true
        }
    }
}

extension Int: DefaultValue {
    public static var defaultValue: Int { return 0 }
}

extension Double: DefaultValue {
    public static var defaultValue: Double { return 0.0 }
}

extension Float: DefaultValue {
    public static var defaultValue: Float { return 0.0 }
}

extension String: DefaultValue {
    public static var defaultValue: String { return "" }
}

extension Bool: DefaultValue {
    public static var defaultValue: Bool { return false }
}

extension Array: DefaultValue {
    public static var defaultValue: [Element] { return [] }
}
