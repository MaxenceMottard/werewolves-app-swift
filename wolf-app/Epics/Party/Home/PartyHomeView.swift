//
//  PartyHomeView.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import SwiftUI
import Foundation

struct PartyHomeView: View {
    @ObservedObject var viewModel: PartyHomeViewModel

    var body: some View {
        VStack {
            if let party = viewModel.party {
                if party.isStarted {
                    Text("Started")
                } else {
                    ViewProvider.Party.lobby(with: party, viewModel.isHost)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            viewModel.subscribeToEvents()
            viewModel.sendNewPlayerEvent()
        })
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProvider.Party.home(id: "ABCD")
    }
}
