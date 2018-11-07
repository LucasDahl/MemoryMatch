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
        
        // Declare an array to store numbers that have already been generated
        var generatedNumbersArray = [Int]()
        
        // Declare an arrary to store generated cards
        var generatedCardsArray = [Card]()
        
        /* Randomly generate pairs of cards, can be changed to make the game harder.
           TODO: make the 8 a var so it can be changed for difficulty
           Starts at zero, so you must do one number less and add one to get the first card */
        
        
        while generatedNumbersArray.count < 8 {
            
            let randomNumber = arc4random_uniform(13) + 1
            
            // This will only execute if the number has not been generated already
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                // Two cards will be need for each pair, that is why only two cards are generated
                
                // Store the number into the generatedNumber array
                generatedNumbersArray.append(Int(randomNumber))
                
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
                
            }

        }
        
        // Randomize the cards array
        for i in 0...generatedCardsArray.count - 1 {
            
            // Find a radnom index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            // Swap the two card
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
            
        }
        
        
        // Return the array
        return generatedCardsArray
        
    }
    
} // End class
