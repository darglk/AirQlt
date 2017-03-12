//
//  Constants.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation

let API_KEY = "42f4616237f399cf57daf96bd20ad84c528420ac"

let UNITS:[String:[String]] = [
    "pm25":["PM2.5", "Pył zawieszony"],
    "pm10":["PM10", "Pył zawieszony"],
    "o3":["O3", "Ozon"],
    "no2":["NO2", "Dwutlenek azotu"],
    "so2":["SO2", "Dwutlenek siarki"],
    "co":["CO", "Tlenek węgla"],
    "t":["Temp", "Temperatura"],
    "w":["Wiatr", "Wiatr"],
    "r":["Deszcz", "Deszcz"],
    "h":["Wilgotność", "Wilgotność"],
    "d":["Rosa", "Rosa"],
    "p":["Ciśnienie", "Ciśnienie"]
]

let NORM:[String:Double] = [
    "PM2.5": 25.0,
    "PM10": 50.0,
    "O3": 120.0,
    "NO2": 200.0,
    "SO2": 20.0,
    "CO": 10000.0
]
