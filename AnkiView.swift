//
//  AnkiView.swift
//  free-anki
//
//  Created by Roman Yaremko on 09.06.2023.
//

import SwiftUI

struct AnkiView: View {
    @EnvironmentObject var appState: AppState
    @State var pack = [Anki]()
    @State var exa = Anki(raw: ["a", "b", "c"])
    @State var progress = 0
    @State var errorsAll = 0
    @State var all = 0
    @State var randMax = 0
    @State var nextWord: Anki?
    @State var curPos = 0
    let _randMaxConst = 30
    @State var showMeaning = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text(String(progress) + "/" + String(all))
                    Text(String(errorsAll))
                }.padding(.bottom, 5)
                VStack{
                    if !showMeaning {
                        Text(exa.word).font(.system(size: 24 ))
                    } else {
                        Text(exa.reading).padding(.bottom, 5)
                        Text(exa.meaning)
                    }
                }.padding(.bottom, 5)
                .onTapGesture {
                    showMeaning = !showMeaning
                }
                HStack{
                    Button("ok", action: {
                        pack.remove(at: curPos)
                        if pack.count == 0 {
                            appState.view = CurrentView.MainView
                            return
                        }
                        randMax = pack.count > _randMaxConst ? _randMaxConst : pack.count
                        curPos = Int.random(in: 0..<randMax)
                        nextWord = pack[curPos]
                        self.exa = nextWord!
                        showMeaning = false
                        progress = progress + 1
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(
                        width: UIScreen.main.bounds.width/2 - 100,
                        height: 50,
                        alignment: .center)
                    Button("Fail", action: {
                        curPos = Int.random(in: 0..<randMax)
                        nextWord = pack[curPos]
                        self.exa = nextWord!
                        showMeaning = false
                        errorsAll = errorsAll + 1
                    })
                    .buttonStyle(.borderedProminent)
                    .frame(
                        width: UIScreen.main.bounds.width/2 - 100,
                        height: 50,
                        alignment: .center)
                }
                Button("Return", action: {
                    appState.view = CurrentView.MainView
                    return
                })
            }
        }.onAppear {
            pack = loadCsv(from: appState.fileName).shuffled()
            randMax = pack.count > _randMaxConst ? _randMaxConst : pack.count
            curPos = Int.random(in: 0..<randMax)
            nextWord = pack[curPos]
            self.exa = nextWord!
            all = pack.count
        }
    }
}

struct AnkiView_Previews: PreviewProvider {
    static var previews: some View {
        AnkiView()
    }
}
