//
//  ViewController.swift
//  Concentration
//
//  Created by Evgeniy Krugliuk on 8/4/19.
//  Copyright © 2019 Yevhenii Kruhliuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var scoreCount = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBAction func newGameButton(_ sender: UIButton) {
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
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCounter(count: &flipCount)
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber, mutateScore: &scoreCount)
            updateViewFromModel()
        } else {
            print ("cant find choosen card")
        }
    }
    
    func updateViewFromModel() {
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
    
    lazy var emojiChoices = chooseTheme()
    
    func chooseTheme() -> [String] {
        let themesArray = [
            ["🦇", "👽", "💀", "😈", "🎃", "👻", "🧟‍♂️", "🧛🏻‍♂️", "🤖", "🤡"],
            ["🏃🏻‍♂️", "🏀", "🏉", "🎾", "🥊", "🏊🏻‍♂️", "🏆", "🏂", "🏋🏻‍♂️", "⛹🏿‍♂️"],
            ["🍏", "🧀", "🥐", "🍔", "🌭", "🍕", "🍟", "🥪", "🍩", "🌯"]
        ]
        let randomIndex = Int(arc4random_uniform(UInt32(themesArray.count)))
        return themesArray[randomIndex]
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
