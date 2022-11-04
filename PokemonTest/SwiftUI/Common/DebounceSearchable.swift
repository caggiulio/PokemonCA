//
//  DebounceSearchable.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 04/11/22.
//

import Combine
import Foundation

/// The `DebounceStringObject` to debounce a task when a user write on a search bar.
final class DebounceStringObject: ObservableObject {
  // MARK: - Computed Properties
  
  /// The text written in the search bar.
  @Published var text = String()
  
  /// The debounced text to return.
  @Published var debouncedText = String()
  
  /// The set of `Combine` `AnyCancellable`.
  private var cancellables = Set<AnyCancellable>()

  // MARK: - Init
  
  /// The init of the `ObservableObject`.
  /// - Parameter dueTime: the `TimeInterval` to debounce.
  public init(dueTime: TimeInterval = 0.5) {
    $text
      .removeDuplicates()
      .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
      .sink(receiveValue: { [weak self] value in
        self?.debouncedText = value
      })
      .store(in: &cancellables)
    }
}
