//
//  ContentView.swift
//  free-anki
//
//  Created by Roman Yaremko on 09.06.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    // TODO change to folders search
    var items = [
        MenuItem(name: "All Vocab N2", path: "All Vocab N2"),
        MenuItem(name: "All Vocab N3", path: "All Vocab N3"),
        MenuItem(name: "All Vocab N4", path: "All Vocab N4"),
        MenuItem(name: "All Vocab N5", path: "All Vocab N5"),
        MenuItem(name: "Favourites IPhone", path: "Favourites IPhone"),
        MenuItem(name: "Vocab N2 P1", path: "Vocab N2 P1"),
        MenuItem(name: "Vocab N2 P2", path: "Vocab N2 P2"),
        MenuItem(name: "Vocab N3 P1", path: "Vocab N3 P1"),
        MenuItem(name: "Vocab N3 P2", path: "Vocab N3 P2"),
        MenuItem(name: "Untitled spreadsheet - Sheet2", path: "Untitled spreadsheet - Sheet2"),
    ]
    var body: some View {
        NavigationView {
            List {
                ForEach(self.items) {item in
                    HStack {
                        Text(item.name)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appState.fileName = item.path
                        appState.view = CurrentView.Anki
                    }
                }
            }.navigationTitle("Words packs")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
