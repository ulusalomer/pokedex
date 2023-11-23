//
//  ContentView.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 23/11/2023.
//

import SwiftUI

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let pokemonId: Int
}

//https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png

struct ContentView: View {
    let decoder = JSONDecoder()
    
    @State var pokemons: [Pokemon] = []
    
    var body: some View {
        ZStack {
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
                            Text(pokemon.name)
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
        }
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        let urlString = "https://my-json-server.typicode.com/ozcanzaferayan/pokedex/pokemons"
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            self.pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print(error)
        }
    }
    
    func imageUrl(for pokemon: Pokemon) -> URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemon.pokemonId).png")!
    }
    
    enum FetchError: Error {
        case urlNotCorrect
    }
}

#Preview {
    ContentView()
}
