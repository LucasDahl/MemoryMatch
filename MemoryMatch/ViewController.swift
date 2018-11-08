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
    @IBOutlet weak var timerLabel: UILabel!
    
    // Properties
    var model = CardModel()
    var cardArray = [Card]()
    var firstFlippedCardIndex:IndexPath?
    var timer:Timer?
    var milliseconds:Float = 10 * 1000 // 10 seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call getCards method of the card model
        cardArray = model.getCards()
        
        // Set the delegate and datasource for the viewcontroller
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        // This allows the timer to work while scrolling
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Set cell size
        let layout = UICollectionViewFlowLayout()
        
        // Makes sure there is space between cards and columns
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        // Get width
        let width = self.collectionView.frame.size.width
        let itemWidth = (width - (10 * 3)) / 4
        
        // Get height
        let itemHeight = itemWidth * 1.4177
        
        // Set the size
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // Sets the size of collection view
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        // Plays the shuffle sound when the view is loaded
        SoundManager.playSound(.shuffle)
        
    }
    
    // MARK: - Timer Methods
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        // Convert to seconds
        let seconds = String(format: "%.2f", milliseconds / 1000)
        
        // Set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // When the timer has reached 0
        if milliseconds <= 0 {
            
            // Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // Check if there are any cards unmatched
            checkGameEnded()
            
        }
        
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
        
        // Check if there is any time left
        if milliseconds <= 0 {
            return
        }
        
        // Get the cell the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            // Flip the card
            cell.flip()
            
            // Play the flip sound
            SoundManager.playSound(.flip)
    
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
            
            // Play matching sound
            SoundManager.playSound(.match)
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Check if there are any cards left unmatched
            checkGameEnded()
            
        } else {
            
            // It's not a match
            
            // Play sound when it isnt a match
            SoundManager.playSound(.nomatch)
            
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
        
    } // End check for Matches
    
    
    func checkGameEnded() {
        
        // Determine if there are any cards unmatched
        var isWon = true
        
        // loop through cards array if any cards are unmatched
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
            
        }
        
        // Messaging variables
        var title = ""
        var message = ""
        
        // If not, the user has won, stop the timer
        if isWon == true {
            
            if milliseconds > 0 {
                
                // Ends the timer if the player has won
                timer?.invalidate()
                
            }
            
            title = "Congratulations!!"
            message = "You've won!!"
            
        } else {
            
            // If there are unmatched cards, check if there's anytime left
            
            // Thee is still time left
            if milliseconds > 0 {
                return
            }
            
            title = "Game OVer..."
            message = "You've lost..."
            
        }
        
        // Show won/lost messaging
        showAlert(title, message)
       
        
    }// End checkGameEnded
    
    func showAlert(_ title:String, _ message:String) {
        
        // Creates the alert message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Creats an action for the alert message
        let alertAction = UIAlertAction(title: "Play Again", style: .default) { (action) in
            
            // Restart the game - Make the same VC reload
            self.newGame()
            
        }
        
        let mainMenuAction = UIAlertAction(title: "Main Menu", style: .default) { (action) in
            
            // Brings you back to the main menu
            let mainMenu = self.storyboard?.instantiateViewController(withIdentifier: "mainMenu") as! MainMenu
            self.present(mainMenu, animated: true, completion: nil)
            
            
        }
        
        // Adds the action to the alert
        alert.addAction(alertAction)
        alert.addAction(mainMenuAction)
        
        // Presents the alert
        present(alert, animated: true, completion: nil)
    
    }
    
    // This is a function to start a new game
    func newGame() {
        
        collectionView.reloadData()
        timerLabel.textColor = UIColor.black
        cardArray = model.getCards()
        milliseconds += 10 * 1000
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    
}// End class

