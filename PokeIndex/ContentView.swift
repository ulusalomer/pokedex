//
//  ContentView.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 23/11/2023.
//

import SwiftUI

//https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png

//enum NavigationItem: Hashable {
//    case detail
//}

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
        }
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
//        let request = PokemonsRequest()
//        self.pokemons = await APIClient.shared.send(request)
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
