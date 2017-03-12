//
//  Measurement.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation
import Alamofire

class AirMeasurement {
    var airQualityIndexes:[AirQualityIndex] = []
    var city:String = ""
    var whenMeasured:String=""
    
    init() {
        
    }
    
    init(withDictionary: NSDictionary) {
        self.city = ((withDictionary.object(forKey: "data") as! NSDictionary).object(forKey: "city") as! NSDictionary).object(forKey: "name") as! String
        self.whenMeasured = ((withDictionary.object(forKey: "data") as! NSDictionary).object(forKey: "time") as! NSDictionary).object(forKey: "s") as! String
        
        let partialMeasurements = (withDictionary.object(forKey: "data") as! NSDictionary).object(forKey: "iaqi") as! NSDictionary
        
        for index in partialMeasurements.allKeys {
            let partialMeasurement = partialMeasurements.object(forKey: index) as! NSDictionary
            
            let aiq = AirQualityIndex(airQualityIndexName: index as! String, airQualityIndexValue: partialMeasurement.object(forKey: "v") as! Double)
            self.airQualityIndexes.append(aiq)
        }
    }
    
    
}
