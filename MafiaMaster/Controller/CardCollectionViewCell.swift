//
//  CardCollectionViewCell.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 06.02.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import UIKit
class CardCollectionViewCell: UICollectionViewCell {
    
    enum CardState {
        case normal
        case turned
        }
    @IBOutlet weak var numberOfPlayerLabel: UILabel!
    @IBOutlet weak var cardButton: UIButton!
    var isOpen = false
    var type: CharacterType?
    var backImage: UIImage = UIImage(named: "backOfCard") ?? UIImage()
    var timer: Timer?
    var cardState: CardState = .normal
    @IBAction func flipCard(_ sender: Any) {
        if cardState == .normal {
            UIView.transition(with: cardButton,
                              duration: 0.7,
                              options: [.transitionFlipFromLeft],
                              animations: {
                                self.cardButton.setImage(self.type?.frontImages(), for: .normal)
                                 
                          }){ (_) in
                              self.cardState = .turned
                              self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false){ timer in
                              self.setTimer()}
            }
        }
    }
    func setTimer() {
        UIView.transition(with: self.cardButton,
                          duration: 0.7,
                          options: [.transitionFlipFromRight],
                          animations: {self.cardButton.setImage(self.backImage, for: .normal)}, completion: nil)
        self.cardState = .normal
        self.timerInvalidate()
    }
   override func prepareForReuse() {
      super.prepareForReuse()
       self.cardButton.setImage(self.backImage, for: .normal)
       self.cardState = .normal
       timerInvalidate()
       self.timer = nil
   }
    func timerInvalidate() {
        timer?.invalidate()
    }
}
