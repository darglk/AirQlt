//
//  ViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import RESideMenu

class MesauermentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pollutionPartName: UILabel!
    @IBOutlet weak var actualDensity: UILabel!
    @IBOutlet weak var actualDensityNumber: UILabel!
    @IBOutlet weak var whenMeasured: UILabel!
    @IBOutlet weak var whenMeasuredTime: UILabel!
    @IBOutlet weak var pollutionPercentage: UILabel!
    
    @IBOutlet weak var measurementsCollectionView: UICollectionView!
    var measurement:AirMeasurement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        let communicator = APICommunicator(URLAddress: "https://api.waqi.info/feed/cracow/?token=demo")
        measurement = AirMeasurement(apiCommunicator: communicator)
        measurement.fetchMeasurement()
        measurement.airQualityIndexes.append(AirQualityIndex(airQualityIndexName: "CO", airQualityIndexValue: 5.5))
        measurementsCollectionView.delegate = self
        measurementsCollectionView.dataSource = self
        
        pollutionPartName.text = measurement.airQualityIndexes[0].airQualityIndexName
        actualDensityNumber.text = String(measurement.airQualityIndexes[0].airQualityIndexValue)
        whenMeasuredTime.text = measurement.whenMeasured
        pollutionPercentage.text = String(measurement.airQualityIndexes[0].airQualityIndexValue) // change this to percent number
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showLeftMenu(_ sender: UIBarButtonItem) {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? ResideMenuViewController {
            rootViewController.presentLeftMenuViewController()
        }
    }

    @IBAction func showCities(_ sender: UIBarButtonItem) {
    }
    
    //UICollectionViewDataSourceMethods implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MeasureCollectionViewCell
        let airQualityIndex = measurement.airQualityIndexes[indexPath.row]
        
        cell.airPollutionPartName.text = airQualityIndex.airQualityIndexName
        cell.airPollutionPartUnitNumber.text = String(airQualityIndex.airQualityIndexValue)
        cell.airPollutionPartPercentageNumber.text = String(airQualityIndex.airQualityIndexValue) //change this to percent number
        cell.unitLabel.text = "μg/m3"
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = UIColor.lightGray.cgColor;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return measurement.airQualityIndexes.count
    }
}
