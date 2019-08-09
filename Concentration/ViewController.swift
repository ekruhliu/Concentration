//
//  ViewController.swift
//  Concentration
//
//  Created by Evgeniy Krugliuk on 8/4/19.
//  Copyright © 2019 Yevhenii Kruhliuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2  // if u need only get u can not write get
    }                                       // but if u have get and set u must write it
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private(set) var scoreCount = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = chooseTheme()
        flipCountLabel.text = "Flips: 0"
        scoreCountLabel.text = "Score: 0"
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCounter(count: &flipCount)
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber, mutateScore: &scoreCount)
            updateViewFromModel()
        } else {
            print ("cant find choosen card")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private lazy var emojiChoices = chooseTheme()
    
    private func chooseTheme() -> [String] {
        let themesArray = [
            ["🦇", "👽", "💀", "😈", "🎃", "👻", "🧟‍♂️", "🧛🏻‍♂️", "🤖", "🤡"],
            ["🏃🏻‍♂️", "🏀", "🏉", "🎾", "🥊", "🏊🏻‍♂️", "🏆", "🏂", "🏋🏻‍♂️", "⛹🏿‍♂️"],
            ["🍏", "🧀", "🥐", "🍔", "🌭", "🍕", "🍟", "🥪", "🍩", "🌯"]
        ]
        return themesArray[themesArray.count.arc4random]
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
