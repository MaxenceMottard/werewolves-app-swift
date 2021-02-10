//
//  PartyLobbyAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 10/02/2021.
//

import Swinject
import SwinjectAutoregistration

final class PartyLobbyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PartyLobbyViewModel.self) { (r, party: PartyData, isHost: Bool) -> PartyLobbyViewModel in
            let viewModel = PartyLobbyViewModel()

            viewModel.party = party
            viewModel.isHost = isHost
            viewModel.socketService = r.resolve(SocketService.self)!

            return viewModel
        }
        
        container.register(PartyLobbyView.self) { (r, party: PartyData, isHost: Bool) -> PartyLobbyView in
            let viewModel = r.resolve(PartyLobbyViewModel.self, arguments: party, isHost)!
            return PartyLobbyView(viewModel: viewModel)
        }
    }
}
