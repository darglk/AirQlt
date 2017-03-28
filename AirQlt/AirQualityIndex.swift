//
//  AirQualityIndex.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation

/// Class representing Air Quality Index eg. PM10, PM2.5, O3, N2O, SO2, CO
class AirQualityIndex {
    /// String representing aqi name
    var airQualityIndexName:String!
    /// Value of aqi
    var airQualityIndexValue:Double!
    /// Full name of aqi eg. Pył zawieszony
    var airQualityIndexLongName:String!
    
    /** 
        Initializes a new AQI with provided data
     
        - Parameters:
            - airQualityIndexName: name of aqi
            - airQualityIndexValue: value of aqi
            - airQualityLongValue: full name of aqi
     */
    init(airQualityIndexName:String, airQualityIndexValue: Double, airQualityLongValue: String) {
        self.airQualityIndexName = airQualityIndexName
        self.airQualityIndexValue = airQualityIndexValue
        self.airQualityIndexLongName = airQualityLongValue
    }
}
