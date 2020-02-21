//
//  ViewController.swift
//  PokedexApp1
//
//  Created by dani on 13/02/2020.
//  Copyright © 2020 danirafa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var barraBusqueda: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var numIndex: Int = 0
    var jsonPokemon:JSONPokemon?
    var buscarPokemon = [Pokemon]()
    var buscando = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate = self
        self.tableView.rowHeight=85
        extraerPokemons()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if buscando{
            return buscarPokemon.count
        }else{
            return jsonPokemon?.pokemon.count ?? 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        let pokemon = jsonPokemon?.pokemon[indexPath.section]
        let labelNombre = cell.viewWithTag(100) as! UILabel
        let labelTipos = cell.viewWithTag(101) as! UILabel
        let labelNumero = cell.viewWithTag(103) as! UILabel
        let imgViewImg = cell.viewWithTag(102) as! UIImageView
        
        if buscando{
            //si estamos buscando rellenamos el tableview según lo que busquemos
            labelNombre.text = buscarPokemon[indexPath.section].name
            labelNumero.text = String(buscarPokemon[indexPath.section].id)
            let numTipos = buscarPokemon[indexPath.section].type.count
            
            if(numTipos==2){
                labelTipos.text = buscarPokemon[indexPath.section].type[0].rawValue + ", " +
                    buscarPokemon[indexPath.section].type[1].rawValue
                
            }else{
                labelTipos.text = buscarPokemon[indexPath.section].type[0].rawValue
            }
            
            let linkImagen = buscarPokemon[indexPath.section].img
            //descarga la imagen de manera asíncrona y la carga
            imgViewImg.descargarImagenDe(link: linkImagen)
            
            
        }else{
            //si no estamos buscando se rellena la lista completa, del 1 al 151
            labelNombre.text = pokemon?.name
            let numTipos = pokemon?.type.count ?? 0
            
            if(numTipos==2){
                labelTipos.text = (pokemon?.type[0]).map { $0.rawValue }! + ", " + (pokemon?.type[1]).map { $0.rawValue }!
            }else{
                labelTipos.text = (pokemon?.type[0]).map { $0.rawValue }
            }
            
            labelNumero.text = String(pokemon!.id)
            
            let linkImagen = pokemon?.img ?? "https://i.imgur.com/p0KYb7i.png"
            //descarga la imagen de manera asíncrona y la carga
            imgViewImg.descargarImagenDe(link: linkImagen)
        }
        
        return cell
    }
    
    let BASE_URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/iosfirebase-e82fe.appspot.com/o/pokemon.json?alt=media&token=e37ee0c2-ac2a-474e-83b1-d3d2e57d667d")
    
    func extraerPokemons () {
        URLSession.shared.dataTask(with:BASE_URL!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            self.jsonPokemon = try? JSONDecoder().decode(JSONPokemon.self,from: data)

            //cuando carga los datos al array de pokemons lo recargar
            //tenemos que hacerlo desde el main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).resume()
        
    }
    
    //para pasar información del view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is DetalleViewController{
            let vc = segue.destination as? DetalleViewController
            //de la celda seleccionada accede al número del pokemon para poder localizar el id o numero del pokemon
            //al que le hemos hecho click
            let cell = tableView.cellForRow(at: self.tableView!.indexPathForSelectedRow!)
            
            let labelNumero = cell?.viewWithTag(103) as! UILabel
            
            //le pasamos un objeto pokemon según el id o número del pokemon al detalleviewcontroller
            let idPokemon = Int(labelNumero.text!)
            vc?.pokemon = jsonPokemon?.pokemon[(idPokemon ?? 0)-1]
            vc?.jsonPokemon = jsonPokemon
            
        }
    }
    
}

extension UIImageView{
    //función para UIImageView que descarga la imagen de internet de manera asíncrona y la carga
    func descargarImagenDe(link: String){
        URLSession.shared.dataTask(with: URL(string: link)!){
            (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                self.image = UIImage(data:data)
            }
        }.resume()
        
    }
    
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        buscarPokemon =  (jsonPokemon?.pokemon.filter({$0.name.prefix(searchText.count) == searchText}))!
        buscando = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        buscando = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
