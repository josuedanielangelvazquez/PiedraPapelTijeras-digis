//
//  InicioViewController.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 19/01/23.
//

import UIKit


class InicioViewController: UIViewController {
    var segues = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func puntajesegues(_ sender: Any) {
        self.performSegue(withIdentifier: "seguespuntaje", sender: nil)
    }
    
   
    
    @IBAction func OnePlayerAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "seguesOnePlayer", sender: nil)
    }
    
    @IBAction func MultiPlayerAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SeguesMultiPlayer", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguespuntaje"{
            let Seguedestino = segue.destination as! PuntajeViewController
            Seguedestino.segueproveniente = "Inicio"
        }
        if segue.identifier == "seguesOnePlayer"{
            let seguesOneplayer = segue.destination as! ViewController
            seguesOneplayer.seguesTipoJuego = "OnePlayer"
        }
        if segue.identifier == "SeguesMultiPlayer"{
            let segueMultiplayer = segue.destination as! ViewController
            segueMultiplayer.seguesTipoJuego = "MultiPlayer"
        }
    }

    
    
    
    /*
     @IBAction func puntajesegue4s(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
