//
//  EditarUsuarioViewController.swift
//  creando
//
//  Created by Mac 09 on 6/22/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class EditarUsuarioViewController: UIViewController {
    
    
    @IBOutlet weak var lblUsuario: UILabel!
    
    @IBOutlet weak var TextoEmail: UITextField!
    @IBOutlet weak var TextoClave: UITextField!
    @IBOutlet weak var TextoNombre: UITextField!
    @IBOutlet weak var btnActualizar: UIButton!
    var usuario:Usuarios?
    
    
    
    @IBAction func ActualizarUsuario(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
