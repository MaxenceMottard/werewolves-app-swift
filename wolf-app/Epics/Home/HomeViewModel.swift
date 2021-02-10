//
//  HomeViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 02/02/2021.
//

import Foundation
import SocketIO
import SwiftUI

class HomeViewModel: ViewModel {
    @AppStorage("username") var usernameInput: String = ""

    var socketService: SocketService!

    func subscribeToEvents() {
        socketService.subscribe(event: .partyJoined) { (data: PartyIdData) in
            ViewProvider.shared.setEntrypoint(.party(partyId: data.id))
        }
    }

    func connectSocket() {
        socketService.connect()
    }

    func handleCreateParty() {
        let params = CreatePartyParameter(username: usernameInput)
        socketService.emit(event: .partyCreate(params: params))
    }

    func handleJoinParty() {
        ViewProvider.shared.setEntrypoint(.joinParty)
    }
}
