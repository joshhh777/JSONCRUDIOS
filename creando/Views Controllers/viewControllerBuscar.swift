//
//  viewControllerBuscar.swift
//  creando
//
//  Created by Mac 09 on 6/20/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class viewControllerBuscar: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bontOk: UIButton!
    @IBOutlet weak var TextNomPeli: UITextField!
    @IBOutlet weak var tablaPelis: UITableView!
    var peliculas = [Peliculas]()
    var usuario:Usuarios?
    
    func cargarPeliculas(ruta:String, completed: @escaping () -> ()){
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.peliculas = try JSONDecoder().decode([Peliculas].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Error en JSON el error: \(error)")
                    print("data cancino::\(response!)")
                }
            }
        }.resume()
    }
    
    func metodoDELETE(ruta:String, datos:Dictionary<String, Any>){
        let url : URL = URL(string: ruta)!
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "DELETE"
        let params = datos

        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            print("parametrosss: \(params)")
        }catch{
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request, completionHandler:
        {(data, response, error) in
            if (data != nil){
                do{
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    print("Dataaaaaaaaa cancino: \(data!)");
                    print("JSONNNNN cancino: \(dict)");
                }catch{
                    print("Error: \(error)")
                }
            }
            })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(peliculas[indexPath.row].nombre)"
        cell.detailTextLabel?.text = "Genero: \(peliculas[indexPath.row].genero) Duracion: \(peliculas[indexPath.row].duracion)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pelicula = peliculas[indexPath.row]
        if editingStyle == .delete{
            let alerta = UIAlertController(title: "Eliminando Pelicula", message: "Desea eliminar la pelicula: \(pelicula.nombre)", preferredStyle: .alert)
            let btnSI = UIAlertAction(title: "SI", style: .default, handler: {(UIAlertAction) in
                let ruta = "http://localhost:3000/peliculas/\(pelicula.id)"
                let rutamostrar = "http://localhost:3000/peliculas/"
                let datos = ["id": pelicula.id] as [String: Any]
                self.metodoDELETE(ruta: ruta, datos: datos)
                self.cargarPeliculas(ruta: rutamostrar){
                    self.tablaPelis.reloadData()
                }
            })
            let btnNO = UIAlertAction(title: "NO", style: .default, handler: {(UIAlertAction) in
                
            })
            alerta.addAction(btnSI)
            alerta.addAction(btnNO)
            self.present(alerta, animated: true, completion: nil)
            }
        }
        
    
    
    /*
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete{
             let juego = juegos[indexPath.row]
             let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             context.delete(juego)
             (UIApplication.shared.delegate as! AppDelegate).saveContext()
             do{
                 juegos = try
                     context.fetch(Jueguito.fetchRequest())
                 tableView.reloadData()
             }catch{}
         }
         
     }
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pelicula = peliculas[indexPath.row]
        print("usuario: \(Usuarios.self)")
        performSegue(withIdentifier: "segueEditar", sender: pelicula)
    }
    
    func mostrarAlerta(titulo:String, mensaje:String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnOK)
        present(alerta, animated: true, completion: nil)
    }
    
    
    @IBAction func BuscandoPeli(_ sender: Any) {
        let ruta = "http://localhost:3000/peliculas?"
        let nombre = TextNomPeli.text!
        let url = ruta + "nombre_like=\(nombre)"
        let crearURL = url.replacingOccurrences(of: " ", with: "%20")
        
        if nombre.isEmpty{
            let ruta = "http://localhost:3000/peliculas/"
            self.cargarPeliculas(ruta: ruta){
                self.tablaPelis.reloadData()
            }
        }else{
            cargarPeliculas(ruta: crearURL){
                if self.peliculas.count <= 0{
                    self.mostrarAlerta(titulo: "Error", mensaje: "No se encontraron coincidencias para: \(nombre)", accion: "cancel")
                }else{
                    self.tablaPelis.reloadData()
                }
            }
        }
    }
    
    @IBAction func Salir(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ruta = "http://localhost:3000/peliculas/"
        cargarPeliculas(ruta: ruta){
            self.tablaPelis.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEditar"{
            let siguienteVC = segue.destination as! viewControllerAgregar
            siguienteVC.pelicula = sender as? Peliculas
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPelis.delegate = self
        tablaPelis.dataSource = self
        
        let rutaa = "http://localhost:3000/peliculas/"
        cargarPeliculas(ruta: rutaa){
            self.tablaPelis.reloadData()
        }
        // Do any additional setup after loading the view.
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
