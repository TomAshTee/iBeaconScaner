//
//  ViewController.swift
//  iBeaconScaner
//
//  Created by Tomasz Jaeschke on 28/02/2019.
//  Copyright © 2019 Tomasz Jaeschke. All rights reserved.
//

import UIKit
import CoreLocation

class iBeaconVC: UIViewController{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ibeaconTableView: UITableView!
    
    var iBeaconList: [CLBeacon] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        ibeaconTableView.delegate = self
        ibeaconTableView.dataSource = self
        
        activityIndicator.isHidden = true
    }
}

extension iBeaconVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iBeaconList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ibeaconTableView.dequeueReusableCell(withIdentifier: "iBeaconCell") as? iBeaconCell else {
            return UITableViewCell()
        }
        cell.setupCell(for: iBeaconList[indexPath.row])
        return cell
    }
}

extension iBeaconVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                startScanning()
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "00000000-0000-0000-0000-00000000E6BE")!
        //let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 1, minor: 258, identifier: "MyBeacon")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //print(beacons)
        
        iBeaconList.removeAll()
        for ibeacon in beacons {
            iBeaconList.append(ibeacon)
        }
        
        for i in iBeaconList {
            print("\(i.minor)")
        }
        ibeaconTableView.reloadData()
    }
}


