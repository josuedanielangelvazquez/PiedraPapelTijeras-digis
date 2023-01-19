//
//  Jugadores.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 18/01/23.
//

import Foundation

struct Jugador{
    var Partida: Int?
    var Jugador1: String
    var Jugador2: String
    var Puntuacion: Int
    var Puntuacion2: Int
    
    init(Partida:Int, Jugador1: String, Jugador2: String, Puntuacion: Int, Puntuacion2: Int) {
        self.Partida = Partida
        self.Jugador1 = Jugador1
        self.Jugador2 = Jugador2
        self.Puntuacion = Puntuacion
        self.Puntuacion2 = Puntuacion2
    }
    
    init() {
        self.Partida = 0
        self.Jugador1 = ""
        self.Jugador2 = ""
        self.Puntuacion = 0
        self.Puntuacion2 = 0
    }
}
