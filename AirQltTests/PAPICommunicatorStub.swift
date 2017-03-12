//
//  PAPICommunicatorStub.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation
@testable import AirQlt

class PAPICommunicatorStub : PAPICommunicator {
    var baseURL: String
    var getWasCalled = false
    
    init(URLAddress: String) {
        baseURL = URLAddress
    }
    
    func get() -> AnyObject? {
        getWasCalled = true
        return nil
    }
}
