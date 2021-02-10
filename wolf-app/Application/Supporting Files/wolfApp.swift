//
//  wolfApp.swift
//  wolf-app
//
//  Created by Maxence Mottard on 02/02/2021.
//

import SwiftUI

@main
struct wolfApp: App {
    @ObservedObject var viewProvider = ViewProvider.shared

    var body: some Scene {
        WindowGroup {
            Group {
                switch viewProvider.entrypoint {
                case .party(let partyId):
                    ViewProvider.Party.home(id: partyId)
                case .joinParty:
                    ViewProvider.joinParty()
                default:
                    ViewProvider.home()
                }
            }.onOpenURL(perform: handleOnOpenURL(url:))
        }
    }
    
    private func handleOnOpenURL(url: URL) {
        if url.path.hasPrefix("/party/") {
            let partyId = String(url.path.dropFirst("/party/".count))
            viewProvider.setEntrypoint(.party(partyId: partyId))
        }
    }
}
