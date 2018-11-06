//
//  ViewController.swift
//  MemoryMatch
//
//  Created by Lucas Dahl on 11/5/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Properties
    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call getCards method of the card model
        cardArray = model.getCards()
        
        // Set the delegate and datasource for the viewcontroller
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Gets a cardCollectionViewCell by either making or resuing one
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for the cell
        cell.setCard(card)
        
        return cell
    }

    // This is called when the user selects a cell in the collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            // Flip the card
            cell.flip()
    
            // Set the status of the car
            card.isFlipped = true
            
            // Determine if it's the first card or second card that's flipped over
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
                
            } else {
                
                // This is the seecond card being flipped
                
                // Perfoem matching logic
                checkForMatches(indexPath)
                
            }// End else
            
        }// End If
        
    } // End didSelectItemAt
    
    // MARK: - Game Logic Method
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        // Get the cells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        // Get the cards for the two cards that were revealed
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        } else {
            
            // It's not a match
            
            // Set the status of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        // Tell the collectionView to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            
        }
        
        // Reset card index so it can be flipped back
        firstFlippedCardIndex = nil
        
    } // End checkFor Matches
    
}// End class

