//
//  PartyLobbyView.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

import SwiftUI

struct PartyLobbyView: View {
    @ObservedObject var viewModel: PartyLobbyViewModel

    var body: some View {
        VStack {
            Text("Not Started")
            
            VStack {
                ForEach(viewModel.party.players, id: \.id) { player in
                    Text(player.username)
                        .padding()
                }
            }
            .padding()
            .background(Color.gray)
            
            if viewModel.isHost {
                Button(L10n.Party.Lobby.Button.startParty) {
                    viewModel.handleStartParty()
                }.padding()
            }
        }
    }
}

struct PartyLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        let data = PartyData(id: "AJBE", players: [], host: .init(username: "Toto", id: "AND8A4N"), isStarted: false)
        
        Group {
            ViewProvider.Party.lobby(with: data, true)
            ViewProvider.Party.lobby(with: data, false)
        }
    }
}
