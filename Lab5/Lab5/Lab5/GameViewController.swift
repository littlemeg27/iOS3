//
//  GameViewController.swift
//  Lab5
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import UIKit
import MultipeerConnectivity

class GameViewController: UIViewController
{
    
    @IBOutlet weak var choiceStackView: UIStackView!
    @IBOutlet weak var opponentChoiceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var gameManager: GameManager!
    var multipeerManager: MultipeerConnectionManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        gameManager = GameManager()
        multipeerManager = MultipeerConnectionManager(delegate: self)
        multipeerManager.startAdvertising()
    }
    
    func setupUI()
    {
        // Setup buttons for choices, making them adaptive for different screen sizes
    }
    
    @IBAction func choiceButtonTapped(_ sender: UIButton)
    {
        if gameManager.canChoose() {
            let choice = Choice(rawValue: sender.tag)!
            gameManager.makeChoice(choice)
            multipeerManager.sendChoice(choice)
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any)
    {
        gameManager.startRound()
        multipeerManager.sendStartRound()
        gameManager.playerReady() 
        if gameManager.canChoose()
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3)
            {
                self.revealChoices()
            }
        }
    }
    
    func revealChoices()
    {
        if let myChoice = gameManager.playerChoice, let opponentChoice = gameManager.opponentChoice
        {
            let result = gameManager.determineWinner(myChoice, opponentChoice)
            updateUIWithResult(result, myChoice, opponentChoice)
            multipeerManager.sendResult(result)
        }
    }
    
    func updateUIWithResult(_ result: GameResult, _ myChoice: Choice, _ opponentChoice: Choice)
    {
        opponentChoiceLabel.text = "Opponent: \(opponentChoice)"
        resultLabel.text = result.message()
        scoreLabel.text = "W: \(gameManager.wins), L: \(gameManager.losses), T: \(gameManager.ties)"
    }
}

extension GameViewController: MultipeerConnectionManagerDelegate
{
    func didReceiveChoice(_ choice: Choice)
    {
        gameManager.setOpponentChoice(choice)
    }
    
    func didReceiveStartRound()
    {
        gameManager.startRound()
    }
    
    func didReceiveResult(_ result: GameResult)
    {
        // Update UI based on received result if necessary
    }
}
