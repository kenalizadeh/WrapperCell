//
//  Buildable.swift
//

import Foundation

public protocol Updatable {}

public extension Updatable {
    /// Updates object with passed block by creating a copy of it.
    /// - Parameter block: update block
    /// - Throws: rethrows
    /// - Returns: updated object
    func update(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

public protocol Mutable {}

public extension Mutable {
    /// Mutates object with passed block by creating a copy of it.
    /// - Parameter block: update block
    /// - Throws: rethrows
    /// - Returns: updated object
    mutating func mutate(_ block: (inout Self) throws -> Void) rethrows -> Self {
        try block(&self)
        return self
    }
}

public protocol Buildable: Updatable, Mutable {
    init()
}

extension Buildable {
    /// Builds object applying passed block.
    /// - Parameter block: update block
    /// - Throws: rethrows
    /// - Returns: updated object
    public static func build(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var instance = Self.init()
        try block(&instance)
        return instance
    }
}

extension NSObject: Buildable {}
extension Array: Buildable {}
