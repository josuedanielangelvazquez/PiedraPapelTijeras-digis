//
//  ViewController.swift
//  PiedraPapelTijeras
//
//  Created by Daniel Angel on 14/01/23.
//

import UIKit

class ViewController: UIViewController {
    var seguesTipoJuego = ""
    @IBOutlet weak var PiedraPc: UIButton!
    @IBOutlet weak var PapelPc: UIButton!
    @IBOutlet weak var TijerasPc: UIButton!
    
    @IBOutlet weak var PiedraJugador: UIButton!
    @IBOutlet weak var TijerasJugador: UIButton!
    @IBOutlet weak var PapelJugador: UIButton!
    
    
    @IBOutlet weak var PuntajePClbl: UILabel!
    @IBOutlet weak var PuntajeJugadorlbl: UILabel!
    
    var EleccionJugador1 = ""
    var EleccionJugador2 = ""
    var piedrapc = 0
    var papelpc = 1
    var tijeraspc = 2
    var Pc = 0
    var computadora = 0
    var PartidasGanadasPC = 0
    var PartidasGanadasJugador = 0
    var jugador = ""
    var jugador2 = ""
    let jugadorviewmodel = JugadorViewModel()
    var jugadormodel = Jugador()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validar()
    }
    let alert = UIAlertController(title: "Ganador", message: "Surgio un Empate", preferredStyle: .alert)
                                  
    let alertJugador = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 1", preferredStyle: .alert)
    
    let alertPc = UIAlertController(title: "Ganador", message: "El Ganador es la PC", preferredStyle: .alert)
    let alerJugador2 = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 2", preferredStyle: .alert
    )


 
    func validar(){
        if seguesTipoJuego.elementsEqual("OnePlayer"){
            PiedraPc.isEnabled = false
            PapelPc.isEnabled = false
            TijerasPc.isEnabled = false
            
        }
        if seguesTipoJuego.elementsEqual("MultiPlayer"){
            PiedraPc.isEnabled = true
            PapelPc.isEnabled = true
            TijerasPc.isEnabled = true
        }
    }
    func enviarDatos(){
        jugadormodel.Jugador1 = jugador
        jugadormodel.Jugador2 = jugador2
        jugadormodel.Puntuacion = PartidasGanadasJugador
        jugadormodel.Puntuacion2 = PartidasGanadasPC
        
        let result = jugadorviewmodel.Add(jugador: jugadormodel)
        if result.Correct == true{
            print("Registro correcto")
        }
        else{
            print("Registro Erroneo")
        }
        performSegue(withIdentifier: "seguespuntajepartida", sender: nil)
        
    }
    func Salir(){
        
        if PartidasGanadasPC == 0, PartidasGanadasJugador == 0{
            performSegue(withIdentifier: "SeguesInicio", sender: nil)
        }
        else{
            let alert = UIAlertController(title: "!Jugador¡", message: "Ingresa tu Nombre", preferredStyle: .alert)
            alert.addTextField{(textfield: UITextField) in
                
            }
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default))
            alert.addAction(UIAlertAction(title: "Registrar", style: .default, handler: {miAccion in
                
                guard let fields = alert.textFields, fields.count == 1 else{
                    return
                }
                let Nombrefield = fields[0]
                guard let Nombre = Nombrefield.text, !Nombre.isEmpty else{
                    print("invalido")
                    return
                }
                self.jugador = Nombre
                self.enviarDatos()
            }))
            present(alert, animated: true)
            
        }
    }
 
    
    func TipoPlaer(var TipoPlayer: String){
        func validarMessage(){
            PiedraPc.backgroundColor = .none
            PapelPc.backgroundColor = .none
            TijerasPc.backgroundColor = .none
            PiedraJugador.backgroundColor = .none
            PapelJugador.backgroundColor = .none
            TijerasJugador.backgroundColor = .none
            EleccionJugador1 = ""
            EleccionJugador2 = ""
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertPc.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertJugador.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
           Pc = Int(arc4random_uniform(3))
           print(Pc)
           var button = TipoPlayer
           switch button{
               
           case "PiedraJugador":
               PiedraJugador.tintColor = .black
               PiedraJugador.backgroundColor = .white
               if Pc == piedrapc{
                   PiedraPc.backgroundColor = .white
                   PiedraPc.tintColor = .black
                   self.present(alert, animated: true)
                   
               }
               if Pc == papelpc{
                   self.present(alertPc, animated: true)
                   PapelPc.tintColor = .black
                   PapelPc.backgroundColor = .white
                   PartidasGanadasPC += 1
               }
               if Pc == tijeraspc{
                   self.present(alertJugador, animated: true)
                   TijerasPc.tintColor = .black
                   TijerasPc.backgroundColor = .white
                   PartidasGanadasJugador += 1
               }
           case "PapelJugador":
               PapelJugador.backgroundColor = .white
               PapelJugador.tintColor = .white
               if Pc == piedrapc{
                   PiedraPc.backgroundColor = .white
                   PiedraPc.tintColor = .black
                   self.present(alertJugador, animated: true)
                   PartidasGanadasJugador += 1
               }
               if Pc == papelpc{
                   self.present(alert, animated: true)
                   PapelPc.tintColor = .black
                   PapelPc.backgroundColor = .white
                   
               }
               if Pc == tijeraspc{
                   self.present(alertPc, animated: true)
                   TijerasPc.backgroundColor = .white
                   TijerasPc.tintColor = .black
                   PartidasGanadasPC += 1
               }
           case "TijerasJugador":
               TijerasJugador.backgroundColor = .white
               TijerasJugador.tintColor = .white
               
               if Pc == piedrapc{
                   PiedraPc.backgroundColor = .white
                   PiedraPc.tintColor = .black
                   self.present(alertPc, animated: true)
                   PartidasGanadasPC += 1
               }
               if Pc == papelpc{
                   self.present(alertJugador, animated: true)
                   PapelPc.tintColor = .black
                   PapelPc.backgroundColor = .white
                   PartidasGanadasJugador += 1
               }
               if Pc == tijeraspc{
                   self.present(alert, animated: true)
                   TijerasPc.backgroundColor = .white
                   TijerasPc.tintColor = .black
               }
           default:
               print("termino")
           }
           PuntajeJugadorlbl.text = String(PartidasGanadasJugador)
           PuntajePClbl.text = String(PartidasGanadasPC)
       }
    func PlayMultiplayer(){
        
        func validarMessage(){
            PiedraPc.backgroundColor = .none
            PapelPc.backgroundColor = .none
            TijerasPc.backgroundColor = .none
            PiedraJugador.backgroundColor = .none
            PapelJugador.backgroundColor = .none
            TijerasJugador.backgroundColor = .none
            EleccionJugador1 = ""
            EleccionJugador2 = ""
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alerJugador2.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertJugador.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        
           
        if EleccionJugador1 != "", EleccionJugador2 != ""{
            switch EleccionJugador1{
            case "PiedraJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alert, animated: true)
                    PiedraJugador.backgroundColor = .white
                    PiedraPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alerJugador2, animated: true)
                    PiedraJugador.backgroundColor = .white
                    PapelPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alertJugador, animated: true)
                    PiedraJugador.backgroundColor = .white
                    TijerasPc.backgroundColor = .white
                }
            case "PapelJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alertJugador, animated: true)
                    PapelJugador.backgroundColor = .white
                    PiedraPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alert, animated: true)
                    PapelJugador.backgroundColor = .white
                    PapelPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alerJugador2, animated: true)
                    PapelJugador.backgroundColor = .white
                    TijerasPc.backgroundColor = .white
                }
            case "TijerasJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alerJugador2, animated: true)
                    TijerasJugador.backgroundColor = .white
                    PiedraPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alertJugador, animated: true)
                    TijerasJugador.backgroundColor = .white
                    PapelPc.backgroundColor = .white
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alert, animated: true)
                    TijerasJugador.backgroundColor = .white
                    TijerasPc.backgroundColor = .white
                }
                
            default:
                print("El otro jugador esta escogiendo")
            }}
        else{
            print("En espera del otro jugador")
        }
    }
    
    @IBAction func Paused(_ sender: UIButton){
        let alert = UIAlertController(title: "¿Salir?", message: "¿Quieres Seguir Jugando?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Salir", style: .cancel){miAccion in self.Salir()})
        alert.addAction(UIAlertAction(title: "Seguir Jugando", style: .default))
        self.present(alert, animated: true)
    }
    
    @IBAction func ButtonAction(_ sender: UIButton) {
        if seguesTipoJuego.elementsEqual("OnePlayer"){
            
            TipoPlaer(var: String(sender.restorationIdentifier!))
            jugador2 = "Pc"

        }
        if seguesTipoJuego.elementsEqual("MultiPlayer"){
            var accion  = String(sender.restorationIdentifier!)
            if accion.elementsEqual("PiedraJugador") || accion.elementsEqual("PapelJugador") || accion.elementsEqual("TijerasJugador"){
                EleccionJugador1 = String(sender.restorationIdentifier!)
                PlayMultiplayer()
            }
            else{
                  EleccionJugador2 = String(sender.restorationIdentifier!)
                PlayMultiplayer()

            }
          
            }
        
    }}
