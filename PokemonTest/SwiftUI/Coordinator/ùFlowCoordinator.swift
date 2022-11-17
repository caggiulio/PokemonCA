//
//  ContentFlowCoordinator.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 17/11/22.
//

import SwiftUI

/// The `View` used for navigation. It will be contains the `Content`.
struct ContentFlowCoordinator<StateContainer: CoordinatorFlowStateProtocol, Content: View>: View {
  
  // MARK: - Stored Properties
  
  /// The assembler of the app.
  @Injected var assembler: PKMNSwiftUIAssembler
  
  /// The `CoordinatorFlowStateProtocol` state of the coordinator.
  @ObservedObject var stateContainer: StateContainer
  
  /// The `Content` struct `View`.
  let content: () -> Content
  
  // MARK: - Computed Properties
  
  /// The active `CoordinatorLink` to navigate.
  private var activeLink: Binding<CoordinatorLink?> {
    $stateContainer.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
  }
  
  /// The special `CoordinatorLink` to show the bottom sheet.
  private var sheetItem: Binding<CoordinatorLink?> {
    $stateContainer.activeLink.map(get: { $0?.sheetItem }, set: { $0 })
  }
  
  // MARK: - Body
  
  var body: some View {
    NavigationView {
      ZStack {
        content()
          .sheet(item: sheetItem, content: sheetContent)
        
        navigationLinks
      }
    }
    .navigationViewStyle(.stack)
  }
}

private extension ContentFlowCoordinator {
  /// The `NavigationLink` views used to push in a navigation stack.
  @ViewBuilder
  var navigationLinks: some View {
    NavigationLink(tag: .home, selection: activeLink, destination: assembler.home) { EmptyView() }
    NavigationLink(tag: .detail, selection: activeLink, destination: assembler.detail) { EmptyView() }
  }
  
  /// The `View` item to pass in the `.sheet` to show a view as a bottom sheet.
  @ViewBuilder
  private func sheetContent(sheetItem: CoordinatorLink) -> some View {
      switch sheetItem {
      case .detailSheet:
        assembler.detail()
        
      default:
          EmptyView()
      }
  }
}
