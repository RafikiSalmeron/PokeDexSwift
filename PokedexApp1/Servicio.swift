//
//  ViewController.swift
//  PokedexApp1
//
//  Created by dani on 13/02/2020.
//  Copyright © 2020 danirafa. All rights reserved.
//

import UIKit

class Servicio {
    
    static let shared = Servicio()
    //una url con datos de pokemon que encontramos por internet y de la que sacamos datos en forma de json y leemos ese json y lo pasamos a un objeto pokemon que contendrá todos sus datos. Son solo los 150 primeros pokemons.
    let BASE_URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/iosfirebase-e82fe.appspot.com/o/pokemon.json?alt=media&token=e37ee0c2-ac2a-474e-83b1-d3d2e57d667d")
    var jsonPokemon:JSONPokemon?
    
    func extraerPokemon2() {
        URLSession.shared.dataTask(with:BASE_URL!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            self.jsonPokemon = try? JSONDecoder().decode(JSONPokemon.self,from: data)
            //print(self.jsonPokemon)
            
        }).resume()
    }
                
    private func extraerImagen(withUrlString urlString: String, completion: @escaping(UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch image with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
            
        }.resume()
    }
           
    }
    
    func getCountLista(){
        
    }
