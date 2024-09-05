//
//  RandomDetailView.swift
//  RandomImageView
//
//  Created by J Oh on 9/5/24.
//

import SwiftUI

struct RandomDetailView: View {
    let image: AsyncImagePhase
    @Binding var sectionTitle: String
    
    var body: some View {
        VStack {
            image
                .image?.resizable()
                .scaledToFit()
                .frame(width: 200, height: 300) 
            
            TextField("섹션", text: $sectionTitle)
                .multilineTextAlignment(.center)
        }
    }
}
 
