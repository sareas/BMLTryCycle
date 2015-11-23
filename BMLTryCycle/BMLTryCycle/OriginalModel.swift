//
//  OriginalModel.swift
//  BMLTryCycle
//
//  Created by Mustafa Al-Hayali on 2015-11-20.
//  Copyright © 2015 Mustafa Al-Hayali. All rights reserved.
//

import Foundation
import UIKit

struct OriginalModel {
    
    let station = Station()
    
    
    init(){
    
    if let bikeShareStations = station.json["stationBeanList"] as? NSArray {

        let bikeShareDepots = bikeShareStations

    
        for var i = 0; i < bikeShareDepots.count; ++i {
    
            let bikeShareData = bikeShareDepots[i] as? NSDictionary
            if let bikeShare = bikeShareData {
                guard let availableBikes = bikeShare["availableBikes"] as? Int else { return }
                guard let availableDocks = bikeShare["availableDocks"] as? Int else { return }
                guard let latitude = bikeShare["latitude"] as? Float else { return }
                guard let longitude = bikeShare["longitude"] as? Float else { return }
                guard let stationName = bikeShare["stationName"] as? String else { return }
                
            }
        }
    }
        

    }
    
}


