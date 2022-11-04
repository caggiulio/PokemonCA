//
//  SportXPHandleErrorManager.swift
//  SportXPFramework
//
//  Created by Nunzio Giulio Caggegi on 22/04/21.
//

import Foundation

class PKMNMainErrorManager: ErrorHandleable {
  private var parent: PKMNMainErrorManager?
  private let action: HandleAction<Error>

  convenience init(action: @escaping HandleAction<Error> = { throw $0 }) {
    self.init(action: action, parent: nil)
  }

  private init(action: @escaping HandleAction<Error>, parent: PKMNMainErrorManager? = nil) {
    self.action = action
    self.parent = parent
  }

  func `throw`(_ error: Error, finally: @escaping (Bool) -> Void) {
    `throw`(error, previous: [], finally: finally)
  }

  private func `throw`(_ error: Error, previous: [PKMNMainErrorManager], finally: ((Bool) -> Void)? = nil) {
    if let parent = parent {
      parent.throw(error, previous: previous + [self], finally: finally)
      return
    }
    serve(error, next: AnyCollection(previous.reversed()), finally: finally)
  }

  private func serve(_ error: Error, next: AnyCollection<PKMNMainErrorManager>, finally: ((Bool) -> Void)? = nil) {
    do {
      try action(error)
      finally?(true)
    } catch {
      if let nextHandler = next.first {
        nextHandler.serve(error, next: next.dropFirst(), finally: finally)
      } else {
        finally?(false)
      }
    }
  }

  func `catch`(action: @escaping HandleAction<Error>) -> ErrorHandleable {
    return PKMNMainErrorManager(action: action, parent: self)
  }
}
