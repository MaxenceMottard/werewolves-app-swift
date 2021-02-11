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
    var joinPartyAlterIsOpen = false {
        didSet {
            objectWillChange.send()
        }
    }

    var socketService: SocketService!

    func subscribeToEvents() {
        socketService.subscribe(event: .partyJoined) { (data: PartyIdData) in
            ViewProvider.shared.setEntrypoint(.party(partyId: data.id))
        }
        
        socketService.subscribe(event: .partyRefused, callback: weakify { (strongSelf, _: PartyIdData) in
            strongSelf.handleError(error: ViewError(errorCode: .PARTY_REFUSED))
        })
    }

    func handleCreateParty() {
        let params = CreatePartyParameter(username: usernameInput)
        socketService.emit(event: .partyCreate(params: params))
    }

    func handleJoinParty(partyId: String) {
        let params = JoinPartyParameter(id: String(partyId.dropFirst(1)), username: usernameInput)
        socketService.emit(event: .partyJoin(params: params))
    }

    func handleJoinParty() {
        joinPartyAlterIsOpen = true
    }

    func formatAlertTextField(text: String) -> String {
        var newText = text.hasPrefix("#")
            ? text
            : "#\(text)"
        
        if newText.hasPrefix("#") && newText.count == 1 {
            newText = ""
        }

        return newText.count > 7
            ? newText.prefix(7).uppercased()
            : newText.uppercased()
    }
}
