//
//  iBeaconCell.swift
//  iBeaconScaner
//
//  Created by Tomasz Jaeschke on 28/02/2019.
//  Copyright © 2019 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreLocation

class iBeaconCell: UITableViewCell {

    @IBOutlet weak var majorLbl: UILabel!
    @IBOutlet weak var minorLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    func setupCell(for beacon: CLBeacon){
        majorLbl.text = beacon.minor.stringValue
        minorLbl.text = beacon.major.stringValue
        distanceLbl.text = String(format: "%.2f", beacon.accuracy.binade) + "m"
    }
}
