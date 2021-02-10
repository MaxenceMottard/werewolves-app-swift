//
//  PartyView.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import SwiftUI

struct PartyView: View {
    @ObservedObject var viewModel: PartyViewModel

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .onAppear(perform: {
            viewModel.subscribeToEvents()
            viewModel.sendNewPlayerEvent()
        })
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProvider.party(id: "ABCD")
    }
}
