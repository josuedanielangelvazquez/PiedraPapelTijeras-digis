//
//  JugadorViewModel.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 18/01/23.
//

import Foundation
import CoreData
import UIKit

class JugadorViewModel{
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    func Add(jugador : Jugador) -> Result{
        var result = Result()
        do{
            let context = appdelegate.persistentContainer.viewContext
            let entidad = NSEntityDescription.entity(forEntityName: "Partida", in: context)
            let jugadorCoreData = NSManagedObject(entity: entidad!, insertInto: context)
                
            jugadorCoreData.setValue(jugador.Jugador1, forKey: "jugador")
            jugadorCoreData.setValue(jugador.Puntuacion, forKey: "puntaje")
            jugadorCoreData.setValue(jugador.Jugador2, forKey: "jugador2")
            jugadorCoreData.setValue(jugador.Puntuacion2, forKey: "puntaje2")
            try! context.save()
            result.Correct = true
            
            
        }catch let error{
            result.ErrorMessage = error.localizedDescription
            result.Correct = false
            result.Ex = error
            
        }
        return result
    }
    func GETALL()-> Result{
        var result = Result()
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Partida")
        
        do{
            let jugadores = try context.fetch(request)
            result.Objects = [Jugador]()
            for obpartidas in jugadores as! [NSManagedObject]{
                var Jugador =  Jugador()
                Jugador.Partida = Int(obpartidas.objectID.uriRepresentation().absoluteString.components(separatedBy: "/p")[1])!
                Jugador.Jugador1 = obpartidas.value(forKey: "jugador") as! String
                Jugador.Puntuacion = obpartidas.value(forKey: "puntaje") as! Int
                Jugador.Jugador2 = obpartidas.value(forKey: "jugador2") as! String
                Jugador.Puntuacion2 = obpartidas.value(forKey: "puntaje2") as! Int
                result.Objects?.append(Jugador)

            }
            result.Correct = true
        }
        catch let error{
            result.Correct = false
                      result.ErrorMessage = error.localizedDescription
                      result.Ex = error
        }
        return result
    }
}
