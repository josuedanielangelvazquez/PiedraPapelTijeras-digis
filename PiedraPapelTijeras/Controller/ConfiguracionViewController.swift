//
//  ConfiguracionViewController.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 25/01/23.
//

import UIKit
import AVFoundation
class ConfiguracionViewController: UIViewController {
    
    var sonidoFondo : AVAudioPlayer?
    @IBOutlet weak var SonidoOf: UIButton!
    @IBOutlet weak var SonidoOn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Sonido.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            sonidoFondo = try AVAudioPlayer(contentsOf: url)
           
        } catch {
            print("Surgio un Error")
        }
        if sonidoFondo?.play() == true{
            SonidoOn.tintColor = .black
            SonidoOf.tintColor = .white
            SonidoOn.isEnabled = true
        }
        if sonidoFondo?.pause() == nil{
            SonidoOn.tintColor = .white
            SonidoOf.tintColor = .black
            SonidoOn.isEnabled =  true
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SonidoOnAction(_ sender: UIButton) {
        SonidoOn.tintColor = .black
        SonidoOf.tintColor = .white
        sonidoFondo?.play()
        
    }
    
    
    @IBAction func SonidoOffAction(_ sender: UIButton) {
        SonidoOf.tintColor = .black
        SonidoOn.tintColor = .white
        sonidoFondo?.pause()
        // sonidoFondo?.stop()
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
