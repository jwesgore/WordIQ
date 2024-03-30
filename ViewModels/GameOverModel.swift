//
//  GameOverModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/29/24.
//

import Foundation
import SwiftUI

class GameOverModel: ObservableObject, GameViewModelObserver {

    @Published var titleText: String
    @Published var bodyText: String
    @Published var buttonText: String
    @Published var isActive: Bool
    @Published var offset: CGFloat = 1000
    var observers = [GameOverObserver]()
    
    init(titleText: String = "Game Over" , bodyText: String = "Placeholder", buttonText: String = "Play Again") {
        self.titleText = titleText
        self.bodyText = bodyText
        self.buttonText = buttonText
        self.isActive = false
    }
    
    func gameEnded() {
        isActive = true
    }
    
    func open() {
        withAnimation(.spring(response:0.8, dampingFraction: 0.7)) {
            offset = 0
        }
    }
    
    func button() {
        for observer in self.observers{
            observer.buttonPressed()
        }
    }
    
    func close() {
        withAnimation(.spring(response:1.2).delay(0.2)) {
            offset = 1000
            isActive = false
        }
        for observer in self.observers{
            observer.closePressed()
        }
    }
    
    func addObserver(observer: GameOverObserver) {
        observers.append(observer)
    }
}

protocol GameOverObserver {
    func closePressed()
    func buttonPressed()
}
