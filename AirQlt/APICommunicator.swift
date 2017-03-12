//
//  APICommunicator.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation

class APICommunicator : PAPICommunicator {
    var baseURL: String
    init(URLAddress: String) {
        baseURL = URLAddress
    }
    
    func get() -> AnyObject? {
        return nil
    }
}
