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
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int, mutateScore score: inout Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                }
                score -= 1
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
    }
    
    func flipCounter(count flipCount: inout Int) {
        flipCount += 1
    }
    
    //  MARK: Create and suffle array of cards
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]        }
        cards.shuffle()
    }
}
