//
//  multijugadorcontroller.swift
//  PiedraPapelTijeras
//
//  Created by Daniel Angel on 15/01/23.
//

import Foundation
import UIKit
class multijugadorController: UIViewController{
    
    @IBOutlet weak var Piedra1: UIButton!
    @IBOutlet weak var Papel1: UIButton!
    @IBOutlet weak var Tijeras1: UIButton!
    @IBOutlet weak var Piedra2: UIButton!
    @IBOutlet weak var Papel2: UIButton!
    @IBOutlet weak var Tijeras2: UIButton!
    
    var ButtonAction1 = ""
    var ButtonAction2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validar()
    }
    let alertjugador1 = UIAlertController(title: "¡GANADOR!", message: "¡Gano el Juagador 1!", preferredStyle: .alert)
    let alertjugador2 = UIAlertController(title: "¡GANADOR!", message: "¡Gano el Juagador 2!", preferredStyle: .alert)
    let alertEmpate = UIAlertController(title: "¡GANADOR!", message: "¡Gano el Juagador 3!", preferredStyle: .alert)
    let Ok = UIAlertAction(title: "OK", style: .default)
    
    func validar(){
     
        
    }
    
    
    
    @IBAction func ButtonAction(_ sender: UIButton)
    {
       
        ButtonAction1 = String(sender.restorationIdentifier!)
        
      
        }
    
    
    @IBAction func ButtonAction2(_ sender: UIButton){
        
        ButtonAction2 = String(sender.restorationIdentifier!)
    }
}
