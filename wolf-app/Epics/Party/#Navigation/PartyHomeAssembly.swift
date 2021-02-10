//
//  PartyAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwinjectAutoregistration

final class PartyHomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PartyHomeViewModel.self) { (r, id: String) -> PartyHomeViewModel in
            let viewModel = PartyHomeViewModel()

            viewModel.partyId = id
            viewModel.socketService = r.resolve(SocketService.self)!

            return viewModel
        }
        
        container.register(PartyHomeView.self) { (r, id: String) -> PartyHomeView in
            let viewModel = r.resolve(PartyHomeViewModel.self, argument: id)!
            return PartyHomeView(viewModel: viewModel)
        }
    }
}
