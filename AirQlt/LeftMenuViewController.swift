//
//  LeftMenuViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit

class LeftMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let bgImage = UIImage(named: "background_left_sidebar")
        let bgImageView = UIImageView(image: bgImage)
        self.tableView.backgroundView = bgImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? ResideMenuViewController
        
        if indexPath.row == 0 {
            let measurementViewController = storyboard?.instantiateViewController(withIdentifier: "contentViewController")
            rootViewController?.contentViewController = measurementViewController
            rootViewController?.hideViewController()
            
        } else if indexPath.row == 1 {
            let settingsViewController = storyboard?.instantiateViewController(withIdentifier: "navigationSet")
            rootViewController?.contentViewController = settingsViewController
            rootViewController?.hideViewController()
        } else if indexPath.row == 2 {
            let aboutViewController = storyboard?.instantiateViewController(withIdentifier: "aboutNavigation")
            rootViewController?.contentViewController = aboutViewController
            rootViewController?.hideViewController()
        }
    }
}
