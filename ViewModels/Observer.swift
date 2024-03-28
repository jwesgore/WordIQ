//
//  Observer.swift
//  testWordle
//
//  Created by Wesley Gore on 3/28/24.
//

//import Foundation
//
//import Combine
//
//// Define a protocol for view model updates
//
//
//// Make GameBoardViewModel conform to KeyboardObserver
//class GameBoardViewModel: KeyboardObserver {
//    // Implement the method to update itself when a key is pressed
//    func keyPressed(_ key: String) {
//        // Update the game board accordingly using the pressed key
//        print("Key pressed: \(key)")
//    }
//}
//
//class KeyboardViewModel: ObservableObject {
//    @Published var pressedKey: String = ""
//}
//
//struct KeyboardView: View {
//    @ObservedObject var keyboardViewModel: KeyboardViewModel
//    
//    var observers: [KeyboardObserver]
//
//    var body: some View {
//        VStack {
//            // Your keyboard buttons
//            Button("A") {
//                // Update the pressed key and notify observers
//                keyboardViewModel.pressedKey = "A"
//                notifyObservers()
//            }
//        }
//    }
//
//    func notifyObservers() {
//        // Notify all observers about the pressed key
//        for observer in observers {
//            observer.keyPressed(keyboardViewModel.pressedKey)
//        }
//    }
//}
//
//// Usage Example:
//let gameBoardViewModel = GameBoardViewModel()
//let keyboardViewModel = KeyboardViewModel()
//
//let keyboardView = KeyboardView(keyboardViewModel: keyboardViewModel, observers: [gameBoardViewModel])
//
//// Output:
//// Key pressed: A
