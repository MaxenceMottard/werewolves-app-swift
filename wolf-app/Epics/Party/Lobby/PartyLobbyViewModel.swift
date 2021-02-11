//
//  PartyLobbyViewModel.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

class PartyLobbyViewModel: ViewModel {
    var socketService: SocketService!
    var party: PartyData!
    var isHost: Bool!
    var hasToShare: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }

    func handleStartParty() {
//        socketService.emit
    }

    func handleLeaveParty() {
        let params = PartyIdParameter(id: party.id)
        socketService.emit(event: .partyLeave(params: params))
        ViewProvider.shared.setEntrypoint(.home)
    }
}
