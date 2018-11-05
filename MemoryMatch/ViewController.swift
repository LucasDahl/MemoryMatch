//
//  ViewController.swift
//  MemoryMatch
//
//  Created by Lucas Dahl on 11/5/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Properties
    var model = CardModel()
    var cardArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call getCards method of the card model
        cardArray = model.getCards()
        
    }


}

