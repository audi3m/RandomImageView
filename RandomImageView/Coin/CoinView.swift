//
//  CoinView.swift
//  RandomImageView
//
//  Created by J Oh on 9/6/24.
//

import SwiftUI

struct CoinView: View {
    
    @State private var allCoinList = [Coin]()
    @State private var filteredCoinList = [Coin]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                bannerView()
                listView()
            }
            .navigationTitle("My Money")
            .searchable(text: $searchText)
            .onSubmit(of: .search) { // 실시간 검색에서 엔터해야 검색으로 바뀜
                if searchText.isEmpty {
                    filteredCoinList = allCoinList
                } else {
                    filteredCoinList = allCoinList.filter { filterCoin(coin: $0) }
                }
            }
            .navigationBarLeadingTrailingItems {
                Button("불러오기") {
                    Task {
                        do {
                            print("API call in nav")
                            let result = try await UpbitAPI.fetchMarkets()
                            allCoinList = result
                            filteredCoinList = allCoinList
                        } catch {
                            print(error)
                        }
                    }
                }
            } trailing: {
                Button("닫기") {
                    print("닫기 누름")
                }
            }

        }
        .task {
            do {
                print("API call")
                let result = try await UpbitAPI.fetchMarkets()
                allCoinList = result
                filteredCoinList = allCoinList
            } catch {
                print(error)
            }
        }
    }
    
    func listView() -> some View {
        
        ForEach($filteredCoinList) { $coin in
            NavigationLink {
                NavigationLazyView(CoinDetailView(coin: $coin))
            } label: {
                CoinItemRowView(coin: $coin)
            }
            .foregroundStyle(.black)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "01497c"))
                .frame(height: 170)
                .overlay(alignment: .leading) {
                    Circle()
                        .foregroundStyle(.black.opacity(0.4))
                        .scaleEffect(CGSize(width: 1.7, height: 1.7))
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("오늘의 마켓")
                        .bold()
                        .foregroundStyle(.white)
                    Text(allCoinList.randomElement()?.market ?? "")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                .shadow(radius: 5)
                
                Spacer()
                Image("mastercard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 30)
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
    
    private func filterCoin(coin: Coin) -> Bool {
        coin.market.lowercased().contains(searchText.lowercased()) ||
        coin.koreanName.lowercased().contains(searchText.lowercased()) ||
        coin.englishName.lowercased().contains(searchText.lowercased())
    }
}

struct CoinItemRowView: View {
    @Binding var coin: Coin
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(coin.koreanName)
                    .bold()
                Text(coin.englishName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(coin.market)
                .font(.subheadline)
                .fontWeight(.semibold)
            Button {
                coin.like.toggle()
            } label: {
                Image(systemName: coin.like ? "heart.fill" : "heart")
                    .foregroundStyle(coin.like ? .pink : .black)
            }
        }
    }
}

struct CoinDetailView: View {
    @Binding var coin: Coin
    
    init(coin: Binding<Coin>) {
        self._coin = coin
        print("CoinDetailView init")
    }
    
    var body: some View {
        Button {
            coin.like.toggle()
        } label: {
            Image(systemName: coin.like ? "heart.fill" : "heart")
                .font(.largeTitle)
                .foregroundStyle(coin.like ? .pink : .black)
        }
        .padding()
        Text(coin.market)
            .font(.title).bold()
        Text(coin.koreanName)
            .font(.title2)
        Text(coin.englishName)
            .font(.title2)
    }
}

#Preview {
    CoinView()
}
