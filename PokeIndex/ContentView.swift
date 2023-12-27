//
//  ContentView.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 23/11/2023.
//

import SwiftUI

//https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png

enum FullScreenItem: String, Identifiable {
    var id: String { rawValue }
    
    case add
}

struct ContentView: View {
    let decoder = JSONDecoder()
    
    @State var pokemons: [Pokemon] = []
    @State var fullScreenItem: FullScreenItem?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(colors: [.pink, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(pokemons) { pokemon in
                        HStack {
                            AsyncImage(url: imageUrl(for: pokemon)) { image in
                                image.resizable()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(pokemon.name ?? "caner")
                                .foregroundStyle(Color.purple)
                                .fontWeight(.bold)
                                .font(.title)
                            Spacer()
                        }
                        .background(Color.white)
                        .clipShape(.buttonBorder)
                    }
                }
            }
            .padding()
            
            Button {
                fullScreenItem = .add
            } label: {
                Image(systemName: "plus")
                    .padding(20)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(20)
            }
        }
        .task {
            await fetchData()
        }
        .sheet(item: $fullScreenItem) { item in
            switch item {
            case .add:
                AddView()
            }
        }
    }
    
    func fetchData() async {
        let request = PokemonsRequest()
        do {
            self.pokemons = try await APIClient.shared.send(request)
        } catch {
            print(error)
        }
    }
    
    func imageUrl(for pokemon: Pokemon) -> URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemon.pokemonId!)).png")!
    }
    
    enum FetchError: Error {
        case urlNotCorrect
    }
}

#Preview {
    ContentView()
}
