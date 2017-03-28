//
//  Measurement.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 12.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import Foundation
import Alamofire

/// Air measurements class model
class AirMeasurement {
    
    /// Air Quality Indexes fetched from the API
    var airQualityIndexes:[AirQualityIndex] = []
    /// City name from which measurements are loaded
    var city:String = ""
    /// Time of measurement in particular city
    var whenMeasured:String = ""
    
    /**
     Initializes a new Measurement before loading request to API
     
     - Parameters:
     
     - Returns: An empty instance
     */
    init() {
        
    }
    
    /** 
     Sends request to API server
     
     - Parameters:
        - city: ID of the city
        - completionHandlerSuccess: an optional block which is used to manipulate downloaded data.
        - completionHandlerFailure: an optinal block which is used to handle request error.
     */
    func fetchMeasurements(city: String, completionHandlerSuccess: ((NSDictionary?) ->())?, completionHandlerFailure: ((Error?) -> ())?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request("https://api.waqi.info/feed/@\(city)/?token=\(API_KEY)").responseJSON { response in
            if let json = response.result.value {
                switch response.result {
                case .success:
                    let responseResult = json as! NSDictionary
                    completionHandlerSuccess?(responseResult)
                case .failure(let error):
                    completionHandlerFailure?(error)
                }
            }
        }
    }
    
    /**
     Parses downloaded data from API
     
     - Parameters:
        - dictionary: dictionary with raw measurement data.
     */
    func parseData(from dictionary: NSDictionary) {
        print(dictionary)
        self.city = ((dictionary.object(forKey: "data") as! NSDictionary).object(forKey: "city") as! NSDictionary).object(forKey: "name") as! String
        self.whenMeasured = ((dictionary.object(forKey: "data") as! NSDictionary).object(forKey: "time") as! NSDictionary).object(forKey: "s") as! String
        
        let partialMeasurements = (dictionary.object(forKey: "data") as! NSDictionary).object(forKey: "iaqi") as! NSDictionary
        
        for index in partialMeasurements.allKeys {
            let partialMeasurement = partialMeasurements.object(forKey: index) as! NSDictionary
            let indexStringValue = index as! String
            switch indexStringValue {
            case "p","t","h", "w", "r", "d":
                continue
            default: break
            }
            
            let indexName = UNITS[indexStringValue]?[0]
            let longName = UNITS[indexStringValue]?[1]
            let aiq = AirQualityIndex(airQualityIndexName: indexName!, airQualityIndexValue: partialMeasurement.object(forKey: "v") as! Double,
                                      airQualityLongValue: longName!)
            self.airQualityIndexes.append(aiq)
        }
    }
}
