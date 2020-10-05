//
//  ViewController.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 09.01.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import UIKit

class ViewController: ConfigurationsOfGameViewController {
    
    @IBOutlet weak var stepperOutlet: UIStepper!
    var numberOfPlayers: Int = 5 {
        didSet {
            print("number of players:", numberOfPlayers)
        }
    }
    var numberOfMafia: Int = 1
    var numberOfManiac: Int = 0
    var numberOfWhore: Int = 0
    var allCharacters: [CharacterType] {
        MafiaPlayersSetter.shared.setChars(numberOfPlayers, numberOfManiac > 0, numberOfWhore > 0)
        return MafiaPlayersSetter.shared.allCharacters
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleValueLabel.text = String(numberOfPlayers)
        mafiaValueLabel.text = String(numberOfMafia)
    }
    
    
    override func peopleStepperDidChange(_ sender: UIStepper) {
        super.peopleStepperDidChange(sender)
        numberOfPlayers = Int(sender.value) 
        numberOfMafia = Int(sender.value / 3)
        GameManager.gameManager.numberOfPlayers = numberOfPlayers + numberOfMafia + numberOfWhore + numberOfManiac
        peopleValueLabel.text = String(numberOfPlayers)
        mafiaValueLabel.text = String(numberOfMafia)
    }
    @IBAction override func dealCardsButtonDidTap(_ sender: UIButton) {
        GameManager.gameManager.characters = allCharacters
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardChooseViewController") as? CardChooseViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newVC = segue.destination as? CharactersViewController else { return }
        newVC.characters = allCharacters
        newVC.delegate = self
    }
}
extension ViewController: CharactersSelectionDelegate {
    func selectedChars(chars: [CharacterType]) {
        numberOfManiac = chars.contains(.maniac) ? 1 : 0
        numberOfWhore = chars.contains(.whore) ? 1 : 0
        peopleValueLabel.text = String(chars.count)
        guard chars.count != allCharacters.count else { return }
        if chars.count > allCharacters.count{
        chars.forEach() {
            switch $0 {
            case .maniac:
                numberOfManiac = 1
                numberOfPlayers = numberOfPlayers + numberOfManiac
                return
            case .whore:
                numberOfWhore = 1
                numberOfPlayers = numberOfPlayers + numberOfWhore
                return
            default:
                return
            }
        }
        } else {
            if !chars.contains(.maniac) {
                numberOfPlayers -= 1
            }
            if !chars.contains(.whore) {
                numberOfPlayers -= 1
            }
        }
    }
}

class MafiaPlayersSetter {
    var allCharacters: [CharacterType] = []{
        didSet{
            print(allCharacters.count)
        }
    }
    static let shared = MafiaPlayersSetter()
    private init () {}
    func setChars(_ numberOfPlayers: Int, _ isManiac: Bool, _ isWhore: Bool) {
        allCharacters = []
        allCharacters.append(.doctor)
        allCharacters.append(.sheriff)
        let maniac = isManiac ? 0 : 1
        let whore = isWhore ? 0 : 1
        let mafiaCount = (numberOfPlayers - maniac - whore) / 3
        for _ in 0..<mafiaCount {
            allCharacters.append(.mafia)
        }
        if isWhore {
            allCharacters.append(.whore)
        }
        if isManiac {
            allCharacters.append(.maniac)
        }
        let citizens = numberOfPlayers - (allCharacters.count)
        for _ in 0..<citizens{
            allCharacters.append(.citizen)
        }
    }
}
