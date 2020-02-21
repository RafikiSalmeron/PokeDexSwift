//
//  DetalleViewController.swift
//  PokedexApp1
//
//  Created by dani on 19/02/2020.
//  Copyright © 2020 danirafa. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

    var jsonPokemon:JSONPokemon?
    var pokemon:Pokemon?
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbNumero: UILabel!
    @IBOutlet weak var lbTipo: UILabel!
    @IBOutlet weak var imgPoke: UIImageView!
    @IBOutlet weak var lbPrevEvo: UILabel!
    @IBOutlet weak var lbNextEvo: UILabel!
    @IBOutlet weak var lbAltura: UILabel!
    @IBOutlet weak var lbPeso: UILabel!
    @IBOutlet weak var imgPrev: UIImageView!
    @IBOutlet weak var imgNext: UIImageView!
    @IBOutlet weak var lbDebilidades: UILabel!
    @IBOutlet weak var imgFondo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        self.lbNombre?.text = pokemon?.name
        lbNumero?.text = String(pokemon!.id)
        let numTipos = pokemon?.type.count
        if(numTipos==2){
            lbTipo.text = "Tipos:  "+(pokemon?.type[0])!.rawValue + ", " + (pokemon?.type[1])!.rawValue
            
        }else{
            lbTipo.text = "Tipo:  "+(pokemon?.type[0])!.rawValue
        }
        //self.lbNumero?.text = String(numIndexPath+1)
        let linkImagen = pokemon?.img ?? "https://i.imgur.com/p0KYb7i.png"
        //descarga la imagen de manera asíncrona y la carga
        self.imgPoke.descargarImagenDe(link: linkImagen)
        
        
        
        if(pokemon?.nextEvolution != nil){
            lbNextEvo.text = pokemon?.nextEvolution![0].name
            let numPokemonNext = Int(pokemon?.nextEvolution![0].num ?? "") ?? 0
            let pokemonNext = jsonPokemon?.pokemon[numPokemonNext-1]

            imgNext.descargarImagenDe(link: pokemonNext?.img ?? "")
        }else{
            lbNextEvo.text = ""
        }
        
        if(pokemon?.prevEvolution != nil ){
            if(pokemon?.prevEvolution?.count ?? 0>=2){
                lbPrevEvo.text = pokemon?.prevEvolution![1].name
                let numPokemonPrev = Int(pokemon?.prevEvolution![1].num ?? "") ?? 0
                let pokemonPrev = jsonPokemon?.pokemon[numPokemonPrev-1]
                imgPrev.descargarImagenDe(link: pokemonPrev?.img ?? "")
            }else{
                let numPokemonPrev = Int(pokemon?.prevEvolution![0].num ?? "") ?? 0
                lbPrevEvo.text = pokemon?.prevEvolution![0].name
                let pokemonPrev = jsonPokemon?.pokemon[numPokemonPrev-1]
                imgPrev.descargarImagenDe(link: pokemonPrev?.img ?? "")
            }
            
        }else{
            lbPrevEvo.text = ""
        }
        
        lbAltura.text = String(pokemon?.height ?? "")
        lbPeso.text = String(pokemon?.weight ?? "")
        
        var debilidades: String = ""
        for i in pokemon!.weaknesses {
            debilidades = debilidades+", "+i.rawValue
        }
        lbDebilidades.text = "Debilidades: "+debilidades[2...]
        
        
        var tipo: String = ""+(pokemon?.type[0])!.rawValue
        switch tipo {
        case "Grass", "Bug":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/kHVctyq.png")
        case "Fire":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/8OMS6Xy.png")
        case "Water":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/tJDTJwX.png")
        case "Electric":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/0jJ506F.png")
        case "Ground", "Rock":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/vbNopk5.png")
        case "Fighting":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/EZjavRi.png")
        case "Ice":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/PgXHOnv.png")
        case "Poison", "Ghost", "Psychic":
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/wExirYt.png")
        default:
            imgFondo.descargarImagenDe(link: "https://i.imgur.com/xyJ9Emn.png")
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}
