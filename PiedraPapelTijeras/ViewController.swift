//
//  ViewController.swift
//  PiedraPapelTijeras
//
//  Created by Daniel Angel on 14/01/23.
//

import UIKit

class ViewController: UIViewController {
    var seguesTipoJuego = ""
    
    @IBOutlet weak var Cronometro: UILabel!
    @IBOutlet weak var PiedraPc: UIButton!
    @IBOutlet weak var PapelPc: UIButton!
    @IBOutlet weak var TijerasPc: UIButton!
    
    @IBOutlet weak var PiedraJugador: UIButton!
    @IBOutlet weak var TijerasJugador: UIButton!
    @IBOutlet weak var PapelJugador: UIButton!
    
    
    @IBOutlet weak var PuntajePClbl: UILabel!
    @IBOutlet weak var PuntajeJugadorlbl: UILabel!
    var timer = Timer()
    var segundos = 5
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ContadordeTiempo), userInfo: nil, repeats: true)
        validar()
    }
    @objc func ContadordeTiempo(){
        segundos -= 1
        
        if (segundos == -1){
            if EleccionJugador1 == "", EleccionJugador2 != ""{
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    PiedraPc.backgroundColor = .green
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    PapelPc.backgroundColor = .green
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    TijerasPc.backgroundColor = .green
                }
                PartidasGanadasPC += 1
                PuntajeJugadorlbl.text = String(PartidasGanadasJugador)
                PuntajePClbl.text = String(PartidasGanadasPC)
                let alertPc = UIAlertController(title: "Ganador", message: "El Ganador es el jugador 2", preferredStyle: .alert)
                alertPc.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in self.reiniciar()}))
                self.present(alertPc, animated: true)
              
            }
            if EleccionJugador1 != "", EleccionJugador2 == ""{
                if EleccionJugador1.elementsEqual("PiedraJugador"){
                    PiedraJugador.backgroundColor = .green
                }
                if EleccionJugador1.elementsEqual("PapelJugador"){
                    PapelJugador.backgroundColor = .green
                }
                if EleccionJugador1.elementsEqual("TijerasJugador"){
                    TijerasJugador.backgroundColor = .green
                }
                PartidasGanadasJugador += 1
                PuntajeJugadorlbl.text = String(PartidasGanadasJugador)
                PuntajePClbl.text = String(PartidasGanadasPC)
                let alertJugador = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 1", preferredStyle: .alert)
                alertJugador.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in self.reiniciar()}))
                self.present(alertJugador, animated: true)
              
                
            }
            if EleccionJugador2 == "", EleccionJugador1 == ""{
                if seguesTipoJuego.elementsEqual("OnePlayer"){
                    Pc = Int(arc4random_uniform(3))
                    TipoPlaer(var: "")
                }
                let alert = UIAlertController(title: "Empate", message: "Surgio un Empate", preferredStyle: .alert)
                let accion = UIAlertAction(title: "Ok", style: .default, handler: {miAcccion in
                    self.reiniciar()
                
                })
                alert.addAction(accion)
                self.present(alert, animated: true)
            }
        }
        Cronometro.text = String(segundos)
    }
  
    

    func reiniciar(){
        self.segundos = 5
        PiedraPc.backgroundColor = .none
        PapelPc.backgroundColor = .none
        TijerasPc.backgroundColor = .none
        PiedraJugador.backgroundColor = .none
        PapelJugador.backgroundColor = .none
        TijerasJugador.backgroundColor = .none
        EleccionJugador1 = ""
        EleccionJugador2 = ""
    }
 
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguespuntajepartida"{
            let tiposegues = segue.destination as! PuntajeViewController
            tiposegues.tiposegues = seguesTipoJuego
        }
    }
    func Salir(){
       
        
        if PartidasGanadasPC == 0, PartidasGanadasJugador == 0{
            performSegue(withIdentifier: "SeguesInicio", sender: nil)
        }
        else{
            if seguesTipoJuego.elementsEqual("MultiPlayer"){
                let alert = UIAlertController(title: "!Jugadores!", message: "Jugadores, Ingresen sus Nombres", preferredStyle: .alert)
                alert.addTextField{(textfield: UITextField) in
                    textfield.placeholder = "Jugador 1"
                }
                alert.addTextField{(textfield2: UITextField) in textfield2.placeholder = "Jugador 2"}
                alert.addAction(UIAlertAction(title: "Cancelar", style: .default))
                alert.addAction(UIAlertAction(title: "Registrar", style: .default, handler: {miAccion in
                    
                    guard let fields = alert.textFields, fields.count == 2
                    else{
                        return
                    }
                    let Nombrefield1 = fields[0]
                    guard let Nombre = Nombrefield1.text, !Nombre.isEmpty else{
                        print("Invalido")
                            return
                    }
                    self.jugador = Nombre
                    let Nombrefield2 = fields[1]
                    guard let Nombre2 = Nombrefield2.text, !Nombre2.isEmpty else{
                        print("Invalido")
                        return
                    }
                    self.jugador2 = Nombre2
                    self.enviarDatos()
                }))
                self.present(alert, animated: true)
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
                
            }}
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
            self.reiniciar()
        }
        let alert = UIAlertController(title: "Ganador", message: "Surgio un Empate", preferredStyle: .alert)
                                      
        let alertJugador = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 1", preferredStyle: .alert)
        
        let alertPc = UIAlertController(title: "Ganador", message: "El Ganador es la PC", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertPc.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertJugador.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        Pc = Int(arc4random_uniform(3))
           print(Pc)
           var button = TipoPlayer
           switch button{
               
           case "PiedraJugador":
               if Pc == piedrapc{
                   PiedraJugador.backgroundColor = .green
                   PiedraPc.backgroundColor = .green
                   self.present(alert, animated: true)
                   
               }
               if Pc == papelpc{
                   self.present(alertPc, animated: true)
                   PiedraJugador.backgroundColor = .red
                   PapelPc.backgroundColor = .green
                   PartidasGanadasPC += 1
               }
               if Pc == tijeraspc{
                   self.present(alertJugador, animated: true)
                   PiedraJugador.backgroundColor = .green
                   TijerasPc.backgroundColor = .red
                   PartidasGanadasJugador += 1
               }
           case "PapelJugador":
               if Pc == piedrapc{
                   PapelJugador.backgroundColor = .green
                   PiedraPc.backgroundColor = .red
                   self.present(alertJugador, animated: true)
                   PartidasGanadasJugador += 1
               }
               if Pc == papelpc{
                   self.present(alert, animated: true)
                   PapelJugador.backgroundColor = .green
                   PapelPc.backgroundColor = .green
                   
               }
               if Pc == tijeraspc{
                   self.present(alertPc, animated: true)
                   TijerasPc.backgroundColor = .green
                   PapelJugador.backgroundColor = .red
                   PartidasGanadasPC += 1
               }
           case "TijerasJugador":
                if Pc == piedrapc{
                   PiedraPc.backgroundColor = .green
                    TijerasJugador.backgroundColor = .red
                   self.present(alertPc, animated: true)
                   PartidasGanadasPC += 1
               }
               if Pc == papelpc{
                   self.present(alertJugador, animated: true)
                   PapelPc.backgroundColor = .red
                   TijerasJugador.backgroundColor = .green
                   PartidasGanadasJugador += 1
               }
               if Pc == tijeraspc{
                   self.present(alert, animated: true)
                   TijerasPc.backgroundColor = .green
                   TijerasJugador.backgroundColor = .green

               }
           default:
               if Pc == piedrapc{
                              PiedraPc.backgroundColor = .green
                              self.present(alertPc, animated: true)
                              PartidasGanadasPC += 1
                          }
                          if Pc == papelpc{
                              self.present(alertPc, animated: true)
                              PapelPc.backgroundColor = .green
                              PartidasGanadasPC += 1
                          }
                          if Pc == tijeraspc{
                              self.present(alertPc, animated: true)
                              TijerasPc.backgroundColor = .green
                              PartidasGanadasPC += 1

                          }
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
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.ContadordeTiempo), userInfo: nil, repeats: true)
             self.reiniciar()
        }
        let alert = UIAlertController(title: "Ganador", message: "Surgio un Empate", preferredStyle: .alert)
                                      
        let alertJugador = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 1", preferredStyle: .alert)
       
        let alerJugador2 = UIAlertController(title: "Ganador", message: "El Ganador es el Jugador 2", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alerJugador2.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        alertJugador.addAction(UIAlertAction(title: "Ok", style: .default, handler: {miAccion in validarMessage()}))
        
           
        if EleccionJugador1 != "", EleccionJugador2 != ""{
            switch EleccionJugador1{
            case "PiedraJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alert, animated: true)
                    PiedraJugador.backgroundColor = .green
                    PiedraPc.backgroundColor = .green
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alerJugador2, animated: true)
                    PiedraJugador.backgroundColor = .red
                    PapelPc.backgroundColor = .green
                    PartidasGanadasPC += 1
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alertJugador, animated: true)
                    PiedraJugador.backgroundColor = .green
                    TijerasPc.backgroundColor = .red
                    PartidasGanadasJugador += 1                }
            case "PapelJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alertJugador, animated: true)
                    PapelJugador.backgroundColor = .green
                    PiedraPc.backgroundColor = .red
                    PartidasGanadasJugador += 1
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alert, animated: true)
                    PapelJugador.backgroundColor = .green
                    PapelPc.backgroundColor = .green
                    
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alerJugador2, animated: true)
                    PapelJugador.backgroundColor = .red
                    TijerasPc.backgroundColor = .green
                    PartidasGanadasPC += 1
                }
            case "TijerasJugador":
                if EleccionJugador2.elementsEqual("PiedraPc"){
                    self.present(alerJugador2, animated: true)
                    TijerasJugador.backgroundColor = .red
                    PiedraPc.backgroundColor = .green
                    PartidasGanadasPC += 1
                }
                if EleccionJugador2.elementsEqual("PapelPc"){
                    self.present(alertJugador, animated: true)
                    TijerasJugador.backgroundColor = .green
                    PapelPc.backgroundColor = .red
                    PartidasGanadasJugador += 1
                }
                if EleccionJugador2.elementsEqual("TijerasPc"){
                    self.present(alert, animated: true)
                    TijerasJugador.backgroundColor = .green
                    TijerasPc.backgroundColor = .green
                }
                
            default:
                switch EleccionJugador2{
                case "PiedraPc":
                    if EleccionJugador2.elementsEqual("PiedraJugador"){
                        self.present(alert, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PiedraPc.backgroundColor = .white
                    }
                    if EleccionJugador2.elementsEqual("PapelJugador"){
                        self.present(alertJugador, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PapelPc.backgroundColor = .white
                        PartidasGanadasJugador += 1
                    }
                    if EleccionJugador2.elementsEqual("TijerasJugador"){
                        self.present(alerJugador2, animated: true)
                        PiedraJugador.backgroundColor = .white
                        TijerasPc.backgroundColor = .white
                        PartidasGanadasPC += 1                }
                case "PapelPc":
                    if EleccionJugador2.elementsEqual("PiedraJugador"){
                        self.present(alerJugador2, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PiedraPc.backgroundColor = .white
                        PartidasGanadasPC += 1
                    }
                    if EleccionJugador2.elementsEqual("PapelJugador"){
                        self.present(alert, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PapelPc.backgroundColor = .white
                        
                    }
                    if EleccionJugador2.elementsEqual("TijerasJugador"){
                        self.present(alertJugador, animated: true)
                        PiedraJugador.backgroundColor = .white
                        TijerasPc.backgroundColor = .white
                        PartidasGanadasJugador
                    }
                case "TijerasPc":
                    if EleccionJugador2.elementsEqual("PiedraJugador"){
                        self.present(alertJugador, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PiedraPc.backgroundColor = .white
                        PartidasGanadasJugador += 1
                    }
                    if EleccionJugador2.elementsEqual("PapelJugador"){
                        self.present(alerJugador2, animated: true)
                        PiedraJugador.backgroundColor = .white
                        PapelPc.backgroundColor = .white
                        PartidasGanadasPC += 1
                        
                    }
                    if EleccionJugador2.elementsEqual("TijerasJugador"){
                        self.present(alert, animated: true)
                        PiedraJugador.backgroundColor = .white
                        TijerasPc.backgroundColor = .white
                    }
                    
                default:
                    print("No hay mas opciones")
                }}
            PuntajeJugadorlbl.text = String(PartidasGanadasJugador)
            PuntajePClbl.text = String(PartidasGanadasPC)
            self.timer.invalidate()
        }
        else{
            print("En espera del otro jugador")
        }
       
    }
    
    @IBAction func Paused(_ sender: UIButton){
        timer.invalidate()
        let alert = UIAlertController(title: "¿Salir?", message: "¿Quieres Seguir Jugando?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Salir", style: .cancel){miAccion in self.Salir()})
        alert.addAction(UIAlertAction(title: "Seguir Jugando", style: .default, handler: {miaccion in self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.ContadordeTiempo), userInfo: nil, repeats: true)
            print("Seguir jugando")
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func ButtonAction(_ sender: UIButton) {
        if seguesTipoJuego.elementsEqual("OnePlayer"){
            self.timer.invalidate()
            reiniciar()
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
