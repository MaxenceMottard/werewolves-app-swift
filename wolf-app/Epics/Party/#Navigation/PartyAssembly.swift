//
//  PartyAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwinjectAutoregistration

final class PartyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PartyViewModel.self) { (r, id: String) -> PartyViewModel in
            let viewModel = PartyViewModel()

            viewModel.partyId = id
            viewModel.socketService = r.resolve(SocketService.self)!

            return viewModel
        }
        
        container.register(PartyView.self) { (r, id: String) -> PartyView in
            let viewModel = r.resolve(PartyViewModel.self, argument: id)!
            return PartyView(viewModel: viewModel)
        }
    }
}
