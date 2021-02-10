//
//  JoinPartyViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Combine
import SwiftUI

class JoinPartyViewModel: ViewModel {
    @Published var partyIdInput: String = ""
    @AppStorage("username") var username: String = ""

    var socketService: SocketService!
    var partyId: String?

    func subscribeToEvents() {
        socketService.subscribe(event: .partyJoined) { (data: PartyIdData) in
            ViewProvider.shared.setEntrypoint(.party(partyId: data.id))
        }

        socketService.subscribe(event: .partyRefused, callback: weakify { (strongSelf, data: PartyIdData) in
            print(data)
        })
    }

    func handleJoinParty() {
        let params = JoinPartyParameter(id: partyIdInput, username: username)
        socketService.emit(event: .partyJoin(params: params))
    }
}
