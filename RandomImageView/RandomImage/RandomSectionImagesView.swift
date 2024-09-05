//
//  RandomSectionImagesView.swift
//  RandomImageView
//
//  Created by J Oh on 9/5/24.
//

import SwiftUI

struct RandomSection: Identifiable {
    let id = UUID()
    var title: String
}

struct RandomSectionImagesView: View {
    @State private var sections = [RandomSection(title: "첫번째 섹션"),
                                   RandomSection(title: "두번째 섹션"),
                                   RandomSection(title: "세번째 섹션"),
                                   RandomSection(title: "네번째 섹션"),
                                   RandomSection(title: "다섯번째 섹션")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($sections) { $section in
                    LazyVStack(alignment: .leading) {
                        Text(section.title)
                            .font(.title3).bold()
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(0..<5) { _ in
                                    let url = URL(string: "https://picsum.photos/120/180")
                                    AsyncImage(url: url) { image in
                                        NavigationLink {
                                            RandomDetailView(image: image, sectionTitle: $section.title)
                                        } label: {
                                            image
                                                .image?.resizable()
                                        }
                                    }
                                    .frame(width: 120, height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("랜덤 이미지")
        }
    }
}

#Preview {
    RandomSectionImagesView()
}
