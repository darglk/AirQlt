//
//  MeasureCollectionViewCell.swift
//  AirQlt
//
//  Created by Dariusz Kulig on 10.03.2017.
//  Copyright © 2017 Dariusz Kulig. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class MeasureCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var airPollutionPartName: UILabel!
    @IBOutlet weak var airPollutionPartPercentageNumber: MBCircularProgressBarView!
    @IBOutlet weak var airPollutionPartUnitNumber: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
}
