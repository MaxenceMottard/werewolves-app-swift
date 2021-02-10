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
    var asJoinParty = false {
        didSet {
            objectWillChange.send()
        }
    }
    var joinPartyViewIsShow = false {
        didSet {
            objectWillChange.send()
        }
    }

    var socketService: SocketService!
    var partyId: String?

    func subscribeToEvents() {
        socketService.subscribe(event: .partyJoined, callback: weakify { (strongSelf, data: PartyIdData) in
            strongSelf.partyId = data.id
            strongSelf.asJoinParty = true
        })
    }

    func connectSocket() {
        socketService.connect()
    }

    func handleCreateParty() {
        let params = CreatePartyParameter(username: usernameInput)
        socketService.emit(event: .partyCreate(params: params))
    }

    func handleJoinParty() {
        joinPartyViewIsShow = true
    }
}
