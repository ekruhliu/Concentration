//
//  Concenration.swift
//  Concentration
//
//  Created by Evgeniy Krugliuk on 8/4/19.
//  Copyright © 2019 Yevhenii Kruhliuk. All rights reserved.
//

import Foundation

class Concentration
{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyOneFaceUpCard: Int?
    
    func chooseCard(at index: Int, mutateScore score: inout Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                }
                score -= 1
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
    
    func flipCounter(count flipCount: inout Int) {
        flipCount += 1
    }
    
    //  MARK: Create and suffle array of cards
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]        }
        cards.shuffle()
    }
}
