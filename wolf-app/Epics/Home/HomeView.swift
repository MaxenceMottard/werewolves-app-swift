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
            TextField("Username", text: $viewModel.usernameInput)
                .padding()
            Button("Create Party") {
                viewModel.handleCreateParty()
            }.padding()
            .fullScreenCover(isPresented: $viewModel.asJoinParty, content: {
                ViewProvider.party(id: viewModel.partyId!)
            })
            Button("Join Party") {
                viewModel.handleJoinParty()
            }.padding()
            .sheet(isPresented: $viewModel.joinPartyViewIsShow, content: {
                ViewProvider.joinParty()
            })
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
