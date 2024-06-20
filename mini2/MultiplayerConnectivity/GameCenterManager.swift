//
//  GameMatch.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 12/06/24.
//

import Foundation
import GameKit

class GameCenterManager: NSObject, ObservableObject {
    
    var match: GKMatch?
    var localPlayer = GKLocalPlayer.local
    var otherPlayer: GKPlayer?
    @Published var authenticationState  = PlayerAuthState.authenticating
    @Published var enumSendData = SendingData.playerPosition

    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticatePlayer() {
        GKLocalPlayer.local.authenticateHandler = { [self] controller, err in
            if let viewController = controller {
                rootViewController?.present(viewController, animated: true)
                return
            }
            
            if err != nil {
                authenticationState = .error
                return
            }
            
            if !localPlayer.isAuthenticated {
                authenticationState = .unauthenticated
            } else {
                if !localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .authenticated
                } else {
                    authenticationState = .restricted
                }
            }
        }
    }
    
    func startMatchmaking() {
        print("start match making")
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        request.queueName = "map"
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }

    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first        
    }
}

extension GameCenterManager: GKMatchDelegate {
    // RECEIVING DATA FROM OTHER PLAYERS
//    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        do {
//            print("received data")
//            let decoder = JSONDecoder()
//            let playerData = try decoder.decode(SendingDataModel.self, from: data)
//            
//            if playerData.name == "player position" {
//                let playerPosition = try decoder.decode(PlayerDataModel.self, from: playerData.data)
//                print(playerPosition)
//            }
//        } catch {
//            
//        }
//    }
    
    // SENDING DATA TO ALL PLAYERS
    private func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
         do {
             try match?.sendData(toAllPlayers: data, with: mode)
         } catch {
             // CATCH ERROR
         }
    }

//    func sendPlayerData(_ message: PlayerDataModel) {
//        enumSendData = .playerPosition
//        let encoder = JSONEncoder()
//        do {
//            let encodeData = try encoder.encode(message)
//            let sendingData = SendingDataModel(name: enumSendData.rawValue, data: encodeData)
//            let encodeSendingData = try encoder.encode(sendingData)
//            print("data send")
//            sendData(encodeSendingData, mode: .reliable)
//        } catch {}
//    }
    
    // HANDLING PLAYERS CONNECTION STATE
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        guard state == .disconnected else { return }
        let alert = UIAlertController(title: "Player disconnected", message: "The other player disconnected from the game.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
            self.match?.disconnect()
        })
        
        DispatchQueue.main.async {
            self.rootViewController?.present(alert, animated: true)
        }

    }
    
    // HANDLING LOCAL PLAYERS ERROR
    func match(_ match: GKMatch, didFailWithError: (any Error)?) {
        if didFailWithError != nil {
            let alert = UIAlertController(title: "Error", message: "There is an error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
                self.match?.disconnect()
            })
            
            DispatchQueue.main.async {
                self.rootViewController?.present(alert, animated: true)
            }
        }
    }
}

extension GameCenterManager: GKMatchmakerViewControllerDelegate {
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("check1")
        viewController.dismiss(animated: true)
        startGame(newMatch: match)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: any Error) {
        print("check2")
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        print("check3")
        viewController.dismiss(animated: true)
    }
    
//    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
//        let request = GKMatchRequest()
//
//        if let viewController = GKMatchmakerViewController(invite: invite) {
//            viewController.matchmakerDelegate = self
//            rootViewController?.present(viewController, animated: true) { }
//        }
        
//        if let viewController = GKMatchmakerViewController(matchRequest: request) {
//            request.minPlayers = 2
//            request.maxPlayers = 10
//            request.queueName = "map"
//
//            viewController.matchmakerDelegate = self
//            rootViewController?.present(viewController, animated: true) { }
//        }
//    }
}
