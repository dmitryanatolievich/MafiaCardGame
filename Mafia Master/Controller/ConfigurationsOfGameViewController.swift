//
//  ConfigurationsOfCells.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 09.01.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import UIKit

class ConfigurationsOfGameViewController: UIViewController {
    
    @IBOutlet var inscriptionOfPeopleLabel: UILabel!
    @IBOutlet var inscriptionOfMafiaLabel: UILabel!
    @IBOutlet var peopleValueLabel: UILabel!
    @IBOutlet var mafiaValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func peopleStepperDidChange(_ sender: UIStepper) {
    }
    @IBAction func dealCardsButtonDidTap(_ sender: UIButton) {
    }
    @IBAction func maniacSwitchDidChange(_ sender: UISwitch) {
    }
}
