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
            Spacer()
        }
        .background(Color.black)
        .onAppear(perform: {
            viewModel.subscribeToEvents()
            viewModel.connectSocket()
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
