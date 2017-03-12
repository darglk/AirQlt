//
//  Measurement.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation

class AirMeasurement {
    let apiCommunicator: PAPICommunicator!
    var airQualityIndexes:[AirQualityIndex] = []
    let city:String = ""
    let whenMeasured:String=""
    
    init(apiCommunicator: PAPICommunicator) {
        self.apiCommunicator = apiCommunicator
    }
    
    func fetchMeasurement() {
        let rawData = self.apiCommunicator.get()
        //deserialize json
    }
    
}
