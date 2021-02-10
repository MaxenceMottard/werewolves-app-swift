//
//  JoinPartyView.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import SwiftUI

struct JoinPartyView: View {
    @ObservedObject var viewModel: JoinPartyViewModel
    
    var body: some View {
        VStack {
            TextField("PartyId", text: $viewModel.partyIdInput)
                .padding()
            Button("Join Party") {
                viewModel.handleJoinParty()
            }
            .padding()
            .fullScreenCover(isPresented: $viewModel.asJoinParty, content: {
                ViewProvider.party(id: viewModel.partyId!)
            })
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear(perform: {
            viewModel.subscribeToEvents()
        })
    }
}

struct JoinPartyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProvider.joinParty()
    }
}
