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
import MBCircularProgressBar

class MesauermentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var pollutionPartName: UILabel!
    @IBOutlet weak var actualDensity: UILabel!
    @IBOutlet weak var actualDensityNumber: UILabel!
    @IBOutlet weak var whenMeasured: UILabel!
    @IBOutlet weak var whenMeasuredTime: UILabel!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var measurementsCollectionView: UICollectionView!
    
    var measurement:AirMeasurement!
    var notificationShown = false
    var cityId = "8689"
    
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
    
    func setLabelsAtIndex(index: Int) {
        if(self.measurement != nil && self.measurement.airQualityIndexes.count > 0) {
            self.pollutionPartName.text = self.measurement.airQualityIndexes[index].airQualityIndexLongName
            self.actualDensityNumber.text = String(self.measurement.airQualityIndexes[index].airQualityIndexValue) + " μg/m\u{B3}"
            self.whenMeasuredTime.text = self.measurement.whenMeasured
            self.progressBar.value = CGFloat((self.measurement.airQualityIndexes[index].airQualityIndexValue / NORM[self.measurement.airQualityIndexes[index].airQualityIndexName]!) * 100)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        measurement.fetchMeasurements(city: cityId, completionHandlerSuccess: { dictionary in
            self.measurement.airQualityIndexes.removeAll()
            self.measurement.parseData(from: dictionary!)
            DispatchQueue.main.async {
                self.measurementsCollectionView.reloadData()
                self.setLabelsAtIndex(index: 0)
                self.title = self.measurement.city.components(separatedBy: ",")[0]
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UserDefaults.standard.setValue(self.cityId, forKey: "chosenCity")
                self.prepareNotification()
            }
        }, completionHandlerFailure: { error in
            DispatchQueue.main.async {
                let alertMessage = UIAlertController(title: "Błąd", message: "Wystąpił błąd podczas ładowania danych. Spróbuj ponownie później.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.measurement = AirMeasurement()
        cityId = "8689"
        if UserDefaults.standard.string(forKey: "chosenCity") != nil {
            cityId = UserDefaults.standard.string(forKey: "chosenCity")!
        }
        
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
    
    // MARK: UICollectionViewDataSourceMethods implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MeasureCollectionViewCell
        let airQualityIndex = measurement.airQualityIndexes[indexPath.row]
        
        cell.airPollutionPartName.text = airQualityIndex.airQualityIndexName
        cell.airPollutionPartUnitNumber.text = String(airQualityIndex.airQualityIndexValue)
        cell.airPollutionPartPercentageNumber.value = CGFloat((airQualityIndex.airQualityIndexValue / NORM[airQualityIndex.airQualityIndexName]!) * 100)
        cell.unitLabel.text = "μg/m\u{B3}"
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = (indexPath.row == 0) ? UIColor.cyan.cgColor : UIColor.lightGray.cgColor;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return measurement.airQualityIndexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: IndexPath(item: 0, section: 0))?.layer.borderColor = UIColor.lightGray.cgColor
        let cell = collectionView.cellForItem(at: indexPath) as! MeasureCollectionViewCell
        cell.layer.borderColor = UIColor.cyan.cgColor
        setLabelsAtIndex(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MeasureCollectionViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor;
    }
}
