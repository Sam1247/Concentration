//
//  Consenteration.swift
//  Concentration
//
//  Created by Abdalla Elsaman on 9/6/18.
//  Copyright © 2018 Dumb13. All rights reserved.
//

import Foundation

class Consenteration
{
    private(set) var cards = [Card]()
    
    var flipCount = 76
    
    var gameMode = 0
    
    var score = 0
    
    var misMatchID:[Int: Bool] = [1: false, 2: false,3: false,
                                  4: false, 5: false, 6:false,
                                  7: false, 8: false]
    
    private var comparingWithCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Consentration.chooseCard at \(index): chosen index not in the card")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = comparingWithCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if misMatchID[cards[matchIndex].identifier] == true{
                        score -= 1
                        if misMatchID[cards[index].identifier] == true{
                            score -= 1
                        }
                    }
                    else {
                        misMatchID[cards[matchIndex].identifier] = true
                        misMatchID[cards[index].identifier] = true
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no card or 2 are face up
                comparingWithCard = index
            }
        }
    }
    
    func newGame () {
        score = 0
        flipCount = 0
        cards.shuffle()
        gameMode = Int(arc4random_uniform(UInt32(6)))
        print(gameMode)
        // update cards for new game
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
        for index in 1...8 {
            misMatchID[index] = false
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Consentration.init at \(index): you must have a least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        // make width = 80 point s
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
