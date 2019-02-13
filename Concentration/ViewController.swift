//
//  ViewController.swift
//  Concentration
//
//  Created by Abdalla Elsaman on 8/31/18.
//  Copyright © 2018 Dumb13. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Consenteration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    private var emojiChoises = ["🐶", "🐼", "🐸", "🐵", "🐔", "🐙", "🦀", "🐲",
                        "⚽️", "🏀", "🏈", "🎾", "🎱", "🏓", "⛸", "🥊",
                        "😀", "😅", "😂", "😍", "😜", "🤬", "🤥", "😈",
                        "🍏", "🍎", "🍐", "🍊", "🍇", "🍉", "🍤", "🍕",
                        "🚗", "🚌", "🚓", "🏎", "🚀", "🛰", "🚅", "🗿",
                        "💟", "☮️", "✝️", "☪️", "🕉", "☸️", "✡️", "⚛️"]
    private var emoji = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0..<emojiChoises.count {
            emoji[index] = emojiChoises[index]
        }
        // adding rounded courners
        for index in 0..<cardButtons.count {
            cardButtons[index].layer.cornerRadius = 5
        }
        newGameButton.layer.cornerRadius = 12
        
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func touchCard(_ sender: UIButton) {
        sender.shake()
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        //sender.flash()
        sender.pulsate()
        game.newGame()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateFlipCountLabel()
        scoreLabel.text = "score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func updateFlipCountLabel () {
        let attributes : [NSAttributedStringKey : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    

    
    private func emoji (for card: Card) -> String {
//        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
//            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
//        }
        return emoji[(card.identifier-1) + game.gameMode*8] ?? "?"
    }
   
}

//"🐶🐼🐸🐵🐔🐙🦀🐲", "⚽️🏀🏈🎾🎱🏓⛸🥊",
//"😀😅😂😍😜🤬🤥😈", "🍏🍎🍐🍊🍇🍉🍤🍕", "🚗🚌🚓🏎🚀🛰🚅🗿", "💟☮️✝️☪️🕉☸️✡️⚛️"
