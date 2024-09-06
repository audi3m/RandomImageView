//
//  CategoryView.swift
//  RandomImageView
//
//  Created by J Oh on 9/6/24.
//

import SwiftUI

struct MoneyView: View {
    
    let genres = ["SF", "가족", "스릴러", "드라마", "다큐멘터리"]
    
    @State private var searchText = ""
    @State private var categories = [
        Category(name: "SF", count: 12),
        Category(name: "가족", count: 12),
        Category(name: "스릴러", count: 12),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories.filter { filterCategories(category: $0) }) { category in
                    NavigationLink {
                        
                    } label: {
                        MoviesRowView(category: category)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarLeadingTrailingItems {
                
            } trailing: {
                Button("추가") {
                    let newCategory = Category(name: genres.randomElement() ?? "UNKOWN",
                                               count: Int.random(in: 1...100))
                    categories.append(newCategory)
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    private func filterCategories(category: Category) -> Bool {
        if searchText.isEmpty {
            return true
        } else {
            return category.name.lowercased().contains(searchText.lowercased())
        }
    }
    
}

struct MoviesRowView: View {
    let category: Category
    var body: some View {
        HStack {
            Image(systemName: "person")
            Text(category.name + " (\(category.count))")
        }
    }
}

#Preview {
    MoneyView()
}


