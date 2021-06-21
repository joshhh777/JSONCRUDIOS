//
//  Peliculas.swift
//  creando
//
//  Created by Mac 09 on 6/20/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import Foundation

struct Peliculas:Decodable{
    let usuarioId:Int
    let id:Int
    let nombre:String
    let genero:String
    let duracion:String
}
