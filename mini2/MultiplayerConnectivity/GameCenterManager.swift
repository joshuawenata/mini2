//
//  GameMatch.swift
//  mini2
//
//  Created by Doni Pebruwantoro on 12/06/24.
//

import Foundation
import GameKit
import SwiftUI
class GameCenterManager: NSObject, ObservableObject {
    
    var match: GKMatch?
    var localPlayer = GKLocalPlayer.local
    var otherPlayer: GKPlayer?
    @Published var authenticationState  = PlayerAuthState.authenticating
    @Published var battleView = false
    @Published var jungleView = true
    @Published var totalPlayer = 0
    
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
        let match = GKMatch()
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }

    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self        
        battleView = true
        jungleView = false
        totalPlayer = match?.players.count ?? 0
        print("player count", match?.players.count)
    }
}

extension GameCenterManager: GKMatchDelegate {
    // RECEIVING DATA FROM OTHER PLAYERS
   func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
       
       
   }
    
    // SENDING DATA TO ALL PLAYERS
   private func sendData(_ data: Data, mode: GKMatch.SendDataMode) {

   }
    
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
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        guard let model = GameModel.decode(data: data) else { return }
//        gameModel = model
    }
}

extension GameCenterManager: GKMatchmakerViewControllerDelegate  {
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true)
        startGame(newMatch: match)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: any Error) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
}
