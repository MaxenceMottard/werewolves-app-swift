//
//  JoinPartyAssembly.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwinjectAutoregistration

final class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeViewModel.self) { r -> HomeViewModel in
            let viewModel = HomeViewModel()

            viewModel.socketService = r.resolve(SocketService.self)!

            return viewModel
        }
        
        container.register(HomeView.self) { r -> HomeView in
            let viewModel = r.resolve(HomeViewModel.self)!
            return HomeView(viewModel: viewModel)
        }
    }
}
