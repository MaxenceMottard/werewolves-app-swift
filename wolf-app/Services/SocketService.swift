//
//  SocketClient.swift
//  wolf-app
//
//  Created by Maxence Mottard on 02/02/2021.
//

import SwiftUI
import SocketIO

class SocketService: ObservableObject, Weakable {
    private let url = URL(string: PlistFiles.serverUrl)!
    private let manager: SocketManager
    private let client: SocketIOClient
    private var socketId: String? {
        didSet {
            objectWillChange.send()
        }
    }
    var isConnected: Bool {
        !(socketId?.isEmpty ?? true)
    }

    static let shared = SocketService()

    init() {
        manager = SocketManager(socketURL: url, config: [.log(true), .reconnects(true), .path("/socket.io")])
        client = manager.defaultSocket

        subscribe(event: .userId, callback: weakify { (strongSelf, data: UserIdData) in
            strongSelf.socketId = data.userId
        })
    }

    func getSocketId() -> String! {
        return socketId
    }
    
    func connect() {
        client.connect()
    }
    
    func disconnect() {
        client.disconnect()
        socketId = nil
    }
    
    func emit(event: EmitEvent) {
        switch event {
        case .partyCreate(let params as SocketParameter),
             .partyJoin(let params as SocketParameter),
             .partyLeave(let params as SocketParameter):
            client.emit(event.key, params.dictionary)
        default:
            client.emit(event.key)
        }
    }

    func subscribe<T: Decodable>(event: SubscribeEvent, callback: @escaping (T) -> Void) {
        client.on(event.rawValue) { result, _ in
            if let dataString = result.first as? String,
               let data = dataString.data(using: .utf8) {
                let decodedDdata = try! JSONDecoder().decode(T.self, from: data)

                callback(decodedDdata)
            } else {
                fatalError("Data return not JSON")
            }
        }
    }
    
    enum EmitEvent {
        case partyCreate(params: CreatePartyParameter)
        case partyJoin(params: JoinPartyParameter)
        case partyLeave(params: PartyIdParameter)
        case roomsList

        var key: String {
            switch self {
            case .partyCreate:
                return "party:create"
            case .partyJoin:
                return "party:join"
            case .roomsList:
                return "rooms:list"
            case .partyLeave:
                return "party:leave"
            }
        }
    }

    enum SubscribeEvent: String {
        case userId = "user:id"
        case partyJoined = "party:joined"
        case partyRefused = "party:refused"
        case partyInfo = "party:info"
        case roomsList = "rooms:list"
        case connect = "connect"
    }
}
