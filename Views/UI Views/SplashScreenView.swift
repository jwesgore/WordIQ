//
//  SplashScreenView.swift
//  wordGame
//
//  Created by Wesley Gore on 4/1/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            if self.isActive {
                MainMenuView()
            }
            else {
                VStack {
                    Text("Word Game")
                        .font(.system(size: 20))
                        .kerning(3)
                        .fontWeight(.medium)
                        .frame(width: 200, height: 50.0)
                        .background()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
