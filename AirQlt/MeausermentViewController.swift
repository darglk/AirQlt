//
//  ViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import RESideMenu

class MesauermentViewController: UIViewController {

    @IBOutlet weak var pollutionPartName: UILabel!
    @IBOutlet weak var actualDensity: UILabel!
    @IBOutlet weak var actualDensityNumber: UILabel!
    @IBOutlet weak var whenMeasured: UILabel!
    @IBOutlet weak var whenMeasuredTime: UILabel!
    @IBOutlet weak var pollutionPercentage: UILabel!
    
    @IBOutlet weak var measurementsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        // Do any additional setup after loading the view, typically from a nib.
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
}

extension MesauermentViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
}
