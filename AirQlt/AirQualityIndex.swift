//
//  AirQualityIndex.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation

class AirQualityIndex {
    var airQualityIndexName:String!
    var airQualityIndexValue:Double!
    
    init(airQualityIndexName:String, airQualityIndexValue: Double) {
        self.airQualityIndexName = airQualityIndexName
        self.airQualityIndexValue = airQualityIndexValue
    }
}
