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
    var airQualityIndexLongName:String!
    
    init(airQualityIndexName:String, airQualityIndexValue: Double, airQualityLongValue: String) {
        self.airQualityIndexName = airQualityIndexName
        self.airQualityIndexValue = airQualityIndexValue
        self.airQualityIndexLongName = airQualityLongValue
    }
}
