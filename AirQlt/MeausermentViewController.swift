//
//  ViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import RESideMenu
import Alamofire

class MesauermentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pollutionPartName: UILabel!
    @IBOutlet weak var actualDensity: UILabel!
    @IBOutlet weak var actualDensityNumber: UILabel!
    @IBOutlet weak var whenMeasured: UILabel!
    @IBOutlet weak var whenMeasuredTime: UILabel!
    @IBOutlet weak var pollutionPercentage: UILabel!
    
    @IBOutlet weak var measurementsCollectionView: UICollectionView!
    var measurement:AirMeasurement!
    
    func fetchRecordsFromApi(city: String) {
        Alamofire.request("https://api.waqi.info/feed/\(city)/?token=\(API_KEY)").responseJSON { response in
            if let json = response.result.value {
                switch response.result {
                case .success:
                    let responseResult = json as! NSDictionary
                    self.measurement = AirMeasurement(withDictionary: responseResult)
                case .failure(let error):
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.measurementsCollectionView.reloadData()
                self.setLabelsAtIndex(index: 0)
                self.title = self.measurement.city
            }
        }
    }
    
    func setLabelsAtIndex(index: Int) {
        self.pollutionPartName.text = self.measurement.airQualityIndexes[index].airQualityIndexName
        self.actualDensityNumber.text = String(self.measurement.airQualityIndexes[index].airQualityIndexValue)
        self.whenMeasuredTime.text = self.measurement.whenMeasured
        self.pollutionPercentage.text = String(self.measurement.airQualityIndexes[index].airQualityIndexValue) // change this to percent number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.measurement = AirMeasurement()
        fetchRecordsFromApi(city: "krakow")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        measurementsCollectionView.delegate = self
        measurementsCollectionView.dataSource = self
        
        
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
        cell.layer.borderColor = (indexPath.row == 0) ? UIColor.green.cgColor : UIColor.lightGray.cgColor;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return measurement.airQualityIndexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: IndexPath(item: 0, section: 0))?.layer.borderColor = UIColor.lightGray.cgColor
        let cell = collectionView.cellForItem(at: indexPath) as! MeasureCollectionViewCell
        cell.layer.borderColor = UIColor.green.cgColor
        setLabelsAtIndex(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MeasureCollectionViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor;
    }
}
