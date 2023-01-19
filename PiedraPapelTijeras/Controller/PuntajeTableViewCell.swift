//
//  PuntajeTableViewCell.swift
//  PiedraPapelTijeras
//
//  Created by MacBookMBA6 on 18/01/23.
//

import UIKit

class PuntajeTableViewCell: UITableViewCell {

    @IBOutlet weak var Partidalbl: UILabel!
    @IBOutlet weak var Jugador1lbl: UILabel!
    @IBOutlet weak var Puntacionlbl: UILabel!
    @IBOutlet weak var Jugador2lbl: UILabel!
    @IBOutlet weak var Puntacion2lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
