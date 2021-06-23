//
//  viewControllerAgregar.swift
//  creando
//
//  Created by Mac 09 on 6/21/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class viewControllerAgregar: UIViewController {
    
    @IBOutlet weak var TextoNombre: UITextField!
    @IBOutlet weak var TextoGenero: UITextField!
    @IBOutlet weak var TextoDuracion: UITextField!
    @IBOutlet weak var botonActual: UIButton!
    @IBOutlet weak var botonGuardar: UIButton!
    var pelicula:Peliculas?
    
    @IBAction func btnGuardar(_ sender: Any) {
        let nombre = TextoNombre.text!
        let genero = TextoGenero.text!
        let duracion = TextoDuracion.text!
        let datos = ["usuarioId": 1, "nombre": "\(nombre)", "genero": "\(genero)", "duracion": "\(duracion)"] as Dictionary<String, Any>
        let ruta = "http://localhost:3000/peliculas"
        metodoPOST(ruta: ruta, datos: datos)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
        let nombre = TextoNombre.text!
        let genero = TextoGenero.text!
        let duracion = TextoDuracion.text!
        let datos = ["usuarioId": 4, "nombre": "\(nombre)", "genero": "\(genero)", "duracion": "\(duracion)"] as Dictionary<String, Any>
        let ruta = "http://localhost:3000/peliculas/\(pelicula!.id)"
        metodoPUT(ruta: ruta, datos: datos)
        navigationController?.popViewController(animated: true)
    }
    
    func metodoPOST(ruta:String, datos:Dictionary<String, Any>){
        let url : URL = URL(string: ruta)!
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "POST"
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
    
    func metodoPUT(ruta:String, datos:Dictionary<String, Any>){
        let url : URL = URL(string: ruta)!
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "PUT"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pelicula == nil{
            botonGuardar.isEnabled = true
            botonActual.isEnabled = false
        }else{
            botonActual.isEnabled = true
            botonGuardar.isEnabled = false
            TextoNombre.text = pelicula!.nombre
            TextoGenero.text = pelicula!.genero
            TextoDuracion.text = pelicula!.duracion
        }
 

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation segueAgregar

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
