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
    @ObservedObject var socketService = SocketService.shared

    var body: some Scene {
        WindowGroup {
            if !socketService.isConnected{
                ProgressView()
                    .onAppear(perform: {
                        socketService.connect()
                    })
            } else {
                ErrorHandler {
                    Group {
                        switch viewProvider.entrypoint {
                        case .party(let partyId):
                            ViewProvider.Party.home(id: partyId)
                        default:
                            ViewProvider.home()
                        }
                    }
                }
                .onOpenURL(perform: handleOnOpenURL(url:))
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    socketService.disconnect()
                }
            }
        }
    }
    
    private func handleOnOpenURL(url: URL) {
        if url.path.hasPrefix("/party/") {
            let partyId = String(url.path.dropFirst("/party/".count))
            viewProvider.setEntrypoint(.party(partyId: partyId))
        }
    }
}
