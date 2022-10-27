//
//  Interaction.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 23/10/22.
//

import Foundation

/// Typically used as a user interaction where it takes no parameters.
public typealias Interaction = () -> Void

/// A user interaction that needs a parameter for the input.
public typealias CustomInteraction<T> = (T) -> Void
