//
//  ViewController.swift
//  creando
//
//  Created by Mac 09 on 6/20/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextoContraseña: UITextField!
    @IBOutlet weak var TextoUsuario: UITextField!
    @IBOutlet weak var btnIniciarSesion: UIButton!
    var usuarios = [Usuarios]()
    
    func validarUsuario(ruta:String, completed: @escaping() -> ()){
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.usuarios = try JSONDecoder().decode([Usuarios].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Error en JSON")
                }
            }
        }.resume()
    }
    
    @IBAction func IniciarSesion(_ sender: Any) {
        let ruta = "http://localhost:3000/usuarios?"
        let usuario = TextoUsuario.text!
        let contraseña = TextoContraseña.text!
        let url = ruta + "nombre=\(usuario)&clave=\(contraseña)"
        let crearURL = url.replacingOccurrences(of: " ", with: "%20")
        print("aaaaaaaaaaaaaaa: \(crearURL)")
        validarUsuario(ruta: crearURL){
            if self.usuarios.count <= 0{
                print("Nombre de usuaro  y/o contraseña incorrectos")
            }else{
                print("Logueo Exitoso")
                
                self.performSegue(withIdentifier: "segueLogueo", sender: nil)
                for data in self.usuarios{
                    print("id:\(data.id),nombre:\(data.nombre),email:\(data.email)")
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

