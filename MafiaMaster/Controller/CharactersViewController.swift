//
//  CharactersViewController.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 10.01.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import UIKit

protocol CharactersSelectionDelegate {
    func selectedChars(chars: [CharacterType])
}

class CharactersViewController: UIViewController {
    @IBOutlet var maniacSwitch: UISwitch!
    @IBOutlet var whoreSwitch: UISwitch!
    @IBOutlet var inscriptionOfManiacLabel: UILabel!
    @IBOutlet var inscriptionOfWhoreLabel: UILabel!
    
    var characters: [CharacterType] = []
    var numberOfMafia: Int {
        var numberOfMafia = 0
        characters.forEach() { if $0 == .mafia {
            numberOfMafia += 1
            }
        }
        return numberOfMafia
    }
    var numberOfAbleAdditionalChars: Bool {
        return characters.count <= 8
    }
    var isWhoreSelected: Bool = false
    var isManiacSelected: Bool = false
    var delegate: CharactersSelectionDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        isWhoreSelected = characters.contains(.whore)
        whoreSwitch.isOn = isWhoreSelected
        isManiacSelected = characters.contains(.maniac)
        maniacSwitch.isOn = isManiacSelected
        
        if numberOfAbleAdditionalChars == !isWhoreSelected && !isManiacSelected {
            maniacSwitch.isEnabled = false
            whoreSwitch.isEnabled = false
        }
    }
    @IBAction func maniacSwitchDidChange(_ sender: UISwitch) {
        isManiacSelected = sender.isOn
        if sender.isOn {
            if !characters.contains(.maniac) {
                characters.append(.maniac)
            }
        } else {
            characters.removeAll(){$0 == .maniac}
        }
    }
    @IBAction func whoreSwitchDidChange(_ sender: UISwitch) {
        isWhoreSelected = sender.isOn
        if sender.isOn {
            if !characters.contains(.whore) {
                characters.append(.whore)
            }
        } else {
            characters.removeAll(){$0 == .whore}
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.selectedChars(chars: characters)
    }
}


