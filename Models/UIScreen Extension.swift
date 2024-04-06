//
//  UISreen Extension.swift
//  wordGame
//
//  Created by Wesley Gore on 4/5/24.
//

import Foundation
import SwiftUI

struct ScreenSize {
    let width = UIScreen.current?.bounds.width
    let height = UIScreen.current?.bounds.height
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
