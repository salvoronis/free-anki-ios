//
//  free_ankiApp.swift
//  free-anki
//
//  Created by Roman Yaremko on 09.06.2023.
//

import SwiftUI

enum CurrentView {
    case MainView
    case Anki
}

class AppState: ObservableObject {
    @Published var view: CurrentView
    @Published var fileName: String
    
    init(view: CurrentView) {
        self.view = view
        self.fileName = ""
    }
}

@main
struct free_ankiApp: App {
    @ObservedObject var appState = AppState(view: CurrentView.MainView)
    
    var body: some Scene {
        WindowGroup {
            switch appState.view {
            case CurrentView.Anki:
                AnkiView().environmentObject(appState)
            default:
                ContentView().environmentObject(appState)
            }
        }
    }
}
