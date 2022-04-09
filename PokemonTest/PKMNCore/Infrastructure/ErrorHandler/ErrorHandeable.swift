//
//  ErrorHandeable.swift
//  SportXPFramework
//
//  Created by Nunzio Giulio Caggegi on 22/04/21.
//

import Foundation

public typealias HandleAction<T> = (T) throws -> Void

// MARK: - ErrorHandleable

public protocol ErrorHandleable: AnyObject {
  func `throw`(_: Error, finally: @escaping (Bool) -> Void)
  func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable
}
