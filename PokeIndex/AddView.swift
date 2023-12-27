//
//  AddView.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 21/12/2023.
//

import SwiftUI

struct AddView: View {
    @State var name: String = ""
    @State var id: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form(content: {
            TextField(
                text: $name,
                prompt: Text("Enter Pokemon Name")
            ) {
                
            }
            
            TextField(
                text: $id,
                prompt: Text("Enter Pokemon Id")
            ) {
                
            }
            
            Button(action: {
                guard name.count > 2 else {
                    // error handling
                    return
                }
                
                guard let pokemonId = Int(id), (2...100).contains(pokemonId) else {
                    // error handling
                    return
                }
                
                let request = AddPokemonRequest(
                    pokemon: .init(
                        id: nil,
                        name: name,
                        pokemonId: pokemonId
                    )
                )
                
                Task {
                    do {
                        _ = try await APIClient.shared.send(request)
                        dismiss()
                    } catch {
                        print(error)
                    }
                }
                
            }, label: {
                Text("Add")
            })
        })
        .navigationTitle("Add")
    }
}

#Preview {
    AddView()
}
