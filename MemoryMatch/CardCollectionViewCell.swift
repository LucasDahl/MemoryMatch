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
        
        // Keep track of the card that gets passed in
        self.card = card
        
        // Check if the cards has been matched in order to deal will cell reuse
        if card.isMatched == true {
            
            // If the card has been matched, then make the image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            // Doesnt run the code below, which makes sure the cell won't reflip it's self when scrolling
            return
            
        } else {
            
            // If the cards havent been matched, make sure the imageview is visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        // Set properites for the card
        frontImageView.image = UIImage(named: card.imageName)
        
        // Determine if the card is in a flipped up state or flipped down state
        if card.isFlipped == true {
            
            // Mkae sure the front imageview is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        } else  {
            
            // Make sure the backimageview is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    // Flips the card
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    // Flips the card back
    func flipBack() {
        
        // Adds a small delay so the user can see the match
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func remove() {
        
        // Removes both imageViews from being visible
        backImageView.alpha = 0
        // Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
        
    }
    
}// End class
