//
//  KeyboardViewModel.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

import Foundation

class KeyboardViewModel : ObservableObject {
    var keyboardModel = KeyboardModel()
    var observers = [KeyboardObserver]()
    var pressedKey: String = " "
    
    func keyPressed(key: String) {
        self.pressedKey = key
        self.notifyObservers()
    }
    
    func addObserver(observer: KeyboardObserver) {
        observers.append(observer)
    }
    
    func notifyObservers() {
        for observer in self.observers{
            observer.keyPressed(self.pressedKey)
        }
    }
}

protocol KeyboardObserver {
    func keyPressed(_ key: String)
}


