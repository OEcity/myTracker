//
//  CarsCell.swift
//  Speedometer
//
//  Created by Tom Odler on 21.01.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit

class CarsCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var engineLbl: UILabel!
    
    func configureCell(car : Car){
        header.text = "\(car.brand!) \(car.model!)"
        yearLbl.text = "\(car.year)"
        engineLbl.text = "\(car.engineCapacity), \(car.fuel!)"
    }


}
