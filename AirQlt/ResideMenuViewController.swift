//
//  ResideMenuViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import RESideMenu

class ResideMenuViewController: RESideMenu {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        self.contentViewController = storyboard?.instantiateViewController(withIdentifier: "contentViewController")
        self.leftMenuViewController = storyboard?.instantiateViewController(withIdentifier: "leftMenuViewController")
        self.backgroundImage = UIImage(named: "background_left_sidebar")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
