//
//  PuntajeViewController.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 18/01/23.
//

import UIKit
import CoreData
class PuntajeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let puntajeviewmodel = JugadorViewModel()
    var jugador = [Jugador]()
    @IBOutlet weak var tableview: UITableView!
    
    //ViewController.delegate = self
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
             tableview.dataSource = self
             view.addSubview(tableview)
        
        self.tableview.register(UINib(nibName: "PuntajeTableViewCell", bundle: .main), forCellReuseIdentifier: "puntajecell")
        // Do any additional setup after loading the view.
        loadData()
    }
    func loadData(){
        let result = JugadorViewModel().GETALL()
        if result.Correct == true{
            jugador = result.Objects! as! [Jugador]
            tableview.reloadData()
        }
        else{
            print("Error al jalar los datos de viewmodel")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  jugador.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "puntajecell", for: indexPath) as! PuntajeTableViewCell
        cell.Partidalbl.text = String(jugador[indexPath.row].Partida!)
        cell.Jugador1lbl.text = jugador[indexPath.row].Jugador1
        cell.Puntacionlbl.text = String(jugador[indexPath.row].Puntuacion)
        cell.Jugador2lbl.text = jugador[indexPath.row].Jugador2
        cell.Puntacion2lbl.text = String(jugador[indexPath.row].Puntuacion)
        
        
        
        
        return cell
    }}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


