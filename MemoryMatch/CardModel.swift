//
//  CardModel.swift
//  MemoryMatch
//
//  Created by Lucas Dahl on 11/5/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

class CardModel {
    
    // Get the cards for the game
    func getCards() -> [Card] {
        
        // Declare an arrary to store generated cards
        var generatedCardsArray = [Card]()
        
        // Randomly generate pairs of cards, can be changed to make the game harder.
        // TODO: make the 8 a var so it can be changed for difficulty
        for _ in 1...8 {
            
            // Two cards will be need for each pair, that is why only two cards are generated
            
            // Starts at zero, so you must do one number less and add one to get the first card
            let randomNumber = arc4random_uniform(13) + 1
            
            // Log the number
            print(randomNumber)
            
            // Create a card
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            // appened the card to the array
            generatedCardsArray.append(cardOne)
            
            // Create the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            // Appened the second card
            generatedCardsArray.append(cardTwo)
            
            // OPTIONAL: Make it so we only have unique pairs of the cards
            
        }
        
        // TODO: Randomize the array
        
        // Return the array
        return generatedCardsArray
        
    }
    
} // End class
