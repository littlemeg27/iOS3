//
//  MemoryGameViewController.swift
//  Lab4
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import UIKit

class MemoryGameViewController: UIViewController
{
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var gridView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var playAgainButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    
    private var game = MemoryGameModel()
    
    private var isGameStarted = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI()
    {
        view.backgroundColor = .white
        timerLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.numberOfLines = 0
        playAgainButton.setTitle("Play Again", for: .normal)
        playAgainButton.setTitleColor(.blue, for: .normal)
        playAgainButton.addTarget(self, action: #selector(playAgainTapped), for: .touchUpInside)
        playAgainButton.isHidden = true // Initially hidden

        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        playButton.setTitleColor(.white, for: .normal)
        playButton.backgroundColor = .blue
        playButton.layer.cornerRadius = 10
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateView()
    {
        timerLabel.text = String(format: "Time: %.1f", game.timeElapsed)
        messageLabel.text = game.isGameFinished ? "Congratulations!" : ""
        playAgainButton.isHidden = !game.isGameFinished
        playButton.isHidden = game.isGameStarted
    }
    
    @IBAction private func startGame(_ sender: UIButton)
    {
        isGameStarted = true
        game.startGame()
        populateGridView()
        updateView()
        print("Game Started!")
    }
    
    @objc private func playAgainTapped()
    {
        isGameStarted = false
        game.resetGame()
        populateGridView()
        updateView()
    }
    
    private func populateGridView()
    {
        for view in gridView.subviews
        {
            view.removeFromSuperview()
        }
        
        for (index, tile) in game.tiles.enumerated()
        {
            let card = CardView(frame: CGRect.zero)
            card.tile = tile
            gridView.addSubview(card)
            
            card.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func showGameOver()
    {        
        let alert = UIAlertController(title: "Congratulations!", message: "Game Over!\nTime: \(String(format: "%.1f", game.timeElapsed)) seconds", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { [weak self] _ in
            self?.resetGame()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func resetGame()
    {
        game.resetGame()
        populateGridView()
        updateView()
    }
    
    private func checkForGameEnd()
    {
        if game.isGameFinished
        {
            showGameOver()
        }
    }
}
