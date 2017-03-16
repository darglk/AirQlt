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
import UserNotifications

class MesauermentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pollutionPartName: UILabel!
    @IBOutlet weak var actualDensity: UILabel!
    @IBOutlet weak var actualDensityNumber: UILabel!
    @IBOutlet weak var whenMeasured: UILabel!
    @IBOutlet weak var whenMeasuredTime: UILabel!
    @IBOutlet weak var pollutionPercentage: UILabel!
    
    @IBOutlet weak var measurementsCollectionView: UICollectionView!
    var measurement:AirMeasurement!
    var notificationShown = false
    
    @IBAction func stationCellTapped(segue: UIStoryboardSegue) {
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    func prepareNotification() {
        if notificationShown {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Pomiary"
        content.subtitle = whenMeasuredTime.text!
        content.body = "Sprawdź jak zmenia się powietrze w " + title!
        content.sound = UNNotificationSound.default()
            
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: "airqlt.measurements", content: content, trigger: trigger)
            
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        notificationShown = true
    }
    
    func fetchRecordsFromApi(city: String, completionHandler: ((String?) ->())?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request("https://api.waqi.info/feed/@\(city)/?token=\(API_KEY)").responseJSON { response in
            if let json = response.result.value {
                switch response.result {
                case .success:
                    let responseResult = json as! NSDictionary
                    self.measurement = AirMeasurement(withDictionary: responseResult)
                    completionHandler?("")
                case .failure(let error):
                    print(error)
                    completionHandler?("")
                }
            }
            DispatchQueue.main.async {
                self.measurementsCollectionView.reloadData()
                self.setLabelsAtIndex(index: 0)
                self.title = self.measurement.city.components(separatedBy: ",")[0]
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UserDefaults.standard.setValue(city, forKey: "chosenCity")
                self.prepareNotification()
            }
        }
    }
    
    func setLabelsAtIndex(index: Int) {
        self.pollutionPartName.text = self.measurement.airQualityIndexes[index].airQualityIndexLongName
        self.actualDensityNumber.text = String(self.measurement.airQualityIndexes[index].airQualityIndexValue) + " μg/m\u{B3}"
        self.whenMeasuredTime.text = self.measurement.whenMeasured
        self.pollutionPercentage.text = String((self.measurement.airQualityIndexes[index].airQualityIndexValue / NORM[self.measurement.airQualityIndexes[index].airQualityIndexName]!) * 100) + "%" // change this to be more brief
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.measurement = AirMeasurement()
        var cityId = "8689"
        if UserDefaults.standard.string(forKey: "chosenCity") != nil {
            cityId = UserDefaults.standard.string(forKey: "chosenCity")!
        }
        fetchRecordsFromApi(city: cityId, completionHandler: nil)
        
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
        cell.airPollutionPartPercentageNumber.text = String((airQualityIndex.airQualityIndexValue / NORM[airQualityIndex.airQualityIndexName]!) * 100) + "%" // change this to be more brief
        cell.unitLabel.text = "μg/m\u{B3}"
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
