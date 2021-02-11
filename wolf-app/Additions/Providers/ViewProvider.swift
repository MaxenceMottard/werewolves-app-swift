//
//  ViewProvider.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import Swinject
import SwiftUI

class ViewProvider: ObservableObject {
    var entrypoint: Entrypoint? {
        didSet {
            objectWillChange.send()
        }
    }

    static var shared = ViewProvider()
    
    
    static func generateAssembler(viewControllerAssembly: Assembly) -> Assembler {
        return Assembler([viewControllerAssembly, HelperAssembly()])
    }

    func setEntrypoint(_ entrypoint: Entrypoint) {
        self.entrypoint = entrypoint
    }
    
    enum Entrypoint {
        case party(partyId: String),
             home
    }
}
