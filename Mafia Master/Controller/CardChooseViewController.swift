//
//  CardChooseViewController.swift
//  Mafia Master
//
//  Created by Dmitry Anatolievich on 10.01.2020.
//  Copyright © 2020 Rock'N'Rolla. All rights reserved.
//

import UIKit

class CardChooseViewController: UIViewController {
    
    @IBOutlet var cardChooseCollectionView: UICollectionView!
    let cellIdentifier = "CardCollectionViewCell"
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var allCharacters: [CharacterType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.allCharacters = GameManager.gameManager.characters.randomMix()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    private func setupCollectionView() {
        cardChooseCollectionView.delegate = self
        cardChooseCollectionView.dataSource = self
    }
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 1
            let lineSpacing:CGFloat = 0
            let interItemSpacing: CGFloat = 0
            let width = (cardChooseCollectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = cardChooseCollectionView.frame.height
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            cardChooseCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}
extension CardChooseViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        let cellHeigth = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeigth)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.isPagingEnabled = true
        return allCharacters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CardCollectionViewCell
        cell.type = allCharacters[indexPath.row]
        cell.numberOfPlayerLabel.text = String(indexPath.row + 1)
        return cell
    }
}
enum CharacterType {
    case citizen
    case mafia
    case maniac
    case whore
    case sheriff
    case doctor
    
    func frontImages() -> UIImage{
        switch self {
        case .citizen:
            return UIImage(named: "citizen") ?? UIImage()
        case .sheriff:
            return UIImage(named: "sheriff") ?? UIImage()
        case .doctor:
            return UIImage(named: "doctor") ?? UIImage()
        case .mafia:
            return UIImage(named: "mafia") ?? UIImage()
        case .maniac:
            return UIImage(named: "maniac") ?? UIImage()
        case .whore:
            return UIImage(named: "whore") ?? UIImage()
        }
    }
}



