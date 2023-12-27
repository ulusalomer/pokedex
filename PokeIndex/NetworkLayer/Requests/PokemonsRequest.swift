//
//  PokemonsRequest.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 28/11/2023.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int?
    let name: String?
    let pokemonId: Int?
}

typealias PokemonsResponse = [Pokemon]

struct PokemonsRequest: Request {
    typealias Response = PokemonsResponse
    
    let baseUrl: String = "https://pokedex-api-taupe-phi.vercel.app"
    let path: String = "/pokemons"
    let method: HTTPMethod = .GET
    let body: Data? = nil
}

struct AddPokemonRequest: Request {
    typealias Response = Pokemon
    
    let baseUrl: String = "https://pokedex-api-taupe-phi.vercel.app"
    let path: String = "/pokemons"
    let method: HTTPMethod = .POST
    let body: Data?
    
    init(pokemon: Pokemon) {
        body = try? JSONEncoder().encode(pokemon)
    }
}
