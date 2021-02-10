//
//  JoinPartyAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwinjectAutoregistration

final class JoinPartyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(JoinPartyViewModel.self) { r -> JoinPartyViewModel in
            let viewModel = JoinPartyViewModel()

            viewModel.socketService = r.resolve(SocketService.self)!

            return viewModel
        }
        
        container.register(JoinPartyView.self) { r -> JoinPartyView in
            let viewModel = r.resolve(JoinPartyViewModel.self)!
            return JoinPartyView(viewModel: viewModel)
        }
    }
}
