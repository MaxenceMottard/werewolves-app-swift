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
            TextField(L10n.JoinParty.partyCode, text: $viewModel.partyIdInput)
                .padding()
            Button(L10n.JoinParty.Button.joinParty) {
                viewModel.handleJoinParty()
            }
            .padding()
            .fullScreenCover(isPresented: $viewModel.asJoinParty, content: {
                ViewProvider.Party.home(id: viewModel.partyId!)
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
