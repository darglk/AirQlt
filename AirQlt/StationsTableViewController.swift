//
//  StationsTableViewController.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 14.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import RESideMenu

class StationsTableViewController: UITableViewController {

    var chosenStation:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STATIONS.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = STATIONS[indexPath.row][1]
        
        return cell
    }
    
    func printSth() -> String{
        return STATIONS[chosenStation.row][0]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedStation" {
            let destinationVc = segue.destination as! MesauermentViewController
            chosenStation = self.tableView.indexPathForSelectedRow
            destinationVc.fetchRecordsFromApi(city: STATIONS[chosenStation.row][0], completionHandler: nil)
        }
        
    }
}
