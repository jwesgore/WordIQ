//
//  StatsSection.swift
//  wordGame
//
//  Created by Wesley Gore on 5/4/24.
//

import SwiftUI

struct StatsSection: View {
    let header: AnyView
    let contents: AnyView
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Section {
                    contents
                } header: {
                    header
                }
                .frame(maxWidth: UISize.stats.itemMaxWidth)
            }
            .padding(.horizontal, UISize.stats.sectionSidePadding)
            .padding(.bottom, UISize.stats.sectionBottomPadding)
            
            Spacer()
        }
    }
}

//#Preview {
//    StatsSection()
//}
