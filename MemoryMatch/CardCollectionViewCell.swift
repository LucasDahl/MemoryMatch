//
//  CardCollectionViewCell.swift
//  MemoryMatch
//
//  Created by Lucas Dahl on 11/5/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    // Properties
    var card:Card?
    
    // This set the card in each cell
    func setCard(_ card: Card) {
        
        // Kepp track of the card that gets passed in
        self.card = card
        
        // Set properites for the card
        frontImageView.image = UIImage(named: card.imageName)
        
        
    }
    
    // Flips the card
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    // Flips the card back
    func flipBack() {
        
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
    
}
