//
//  HomeView.swift
//  wolf-app
//
//  Created by Maxence Mottard on 02/02/2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            Spacer()
            TextField(L10n.Home.username, text: $viewModel.usernameInput)
                .padding()
            Button(L10n.Home.Button.createParty) {
                viewModel.handleCreateParty()
            }.padding()
            Button(L10n.Home.Button.joinParty) {
                viewModel.handleJoinParty()
            }.padding()
            .background(
                AlertTextField(
                    isPresented: $viewModel.joinPartyAlterIsOpen,
                    title: L10n.Home.Alert.title,
                    description: L10n.Home.Alert.description,
                    placeholder: L10n.Home.Alert.placeholder,
                    keyboardType:  .default,
                    actionHandler: viewModel.handleJoinParty(partyId:),
                    cancelHandler: nil,
                    formatText: viewModel.formatAlertTextField(text:)
                )
            )
            Spacer()
        }
        .background(Color.black)
        .onAppear(perform: {
            viewModel.subscribeToEvents()
        })
        .onTapGesture {
          self.hideKeyboard()
        }
    } 
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ViewProvider.home()
    }
}
