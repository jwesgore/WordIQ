//
//  GameOverModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/29/24.
//

import Foundation
import SwiftUI

class GameOverVM: ObservableObject {

    @Published var titleText: String
    @Published var bodyText: String
    @Published var buttonText: String
    @Published var isActive: Bool
    @Published var offset: CGFloat = 1000
    
    var observers: [GameOverVMObserver]
    
    init(titleText: String = "Game Over" , bodyText: String = "Placeholder", buttonText: String = "Play Again") {
        self.titleText = titleText
        self.bodyText = bodyText
        self.buttonText = buttonText
        self.isActive = false
        
        self.observers = [GameOverVMObserver]()
    }
    
    func addObserver(observer: GameOverVMObserver) {
        observers.append(observer)
    }
    
    func open() {
        withAnimation(.spring(response:0.8, dampingFraction: 0.7)) {
            offset = 0
        }
    }
    
    func close() {
        withAnimation(.spring(response:1.2).delay(0.2)) {
            offset = 1000
            isActive = false
        }
    }
    
    func closePressed() {
        for observer in observers {
            observer.closePressed()
        }
        close()
    }
    
    func buttonPressed() {
        for observer in observers {
            observer.buttonPressed()
        }
        close()
    }
}

protocol GameOverVMObserver {
    func closePressed()
    func buttonPressed()
}
