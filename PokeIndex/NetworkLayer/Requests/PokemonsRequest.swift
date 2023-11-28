//
//  PokemonsRequest.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 28/11/2023.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let pokemonId: Int
}

typealias PokemonsResponse = [Pokemon]

struct PokemonsRequest: Request {
    typealias Response = PokemonsResponse
    
    let baseUrl: String = "https://my-json-server.typicode.com/ozcanzaferayan/pokedex"
    let path: String = "/pokemons"
    let method: HTTPMethod = .GET
}
