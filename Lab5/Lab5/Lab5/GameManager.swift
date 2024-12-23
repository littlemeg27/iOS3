//
//  GameManager.swift
//  Lab5
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import Foundation

enum Choice: Int, CustomStringConvertible
{
    case rock, paper, scissors
    
    var description: String
    {
        switch self
        {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }
}

enum GameResult: Int, CaseIterable
{
    case win, lose, tie
    
    func message() -> String
    {
        switch self
        {
        case .win: return "You Win!"
        case .lose: return "You Lose!"
        case .tie: return "It's a Tie!"
        }
    }
}

class GameManager
{
    var playerChoice: Choice?
    var opponentChoice: Choice?
    var wins = 0, losses = 0, ties = 0
    private var bothPlayersReady = false
    
    func canChoose() -> Bool
    {
        return bothPlayersReady && playerChoice == nil && opponentChoice == nil
    }
    
    func makeChoice(_ choice: Choice)
    {
        playerChoice = choice
    }
    
    func setOpponentChoice(_ choice: Choice)
    {
        opponentChoice = choice
    }
    
    func startRound()
    {
        bothPlayersReady = false
        playerChoice = nil
        opponentChoice = nil
    }
    
    func playerReady()
    {
        bothPlayersReady.toggle()
    }
    
    func determineWinner(_ myChoice: Choice, _ opponentChoice: Choice) -> GameResult
    {
        if myChoice == opponentChoice
        {
            ties += 1
            return .tie
        }
        
        switch (myChoice, opponentChoice)
        {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            wins += 1
            return .win
        default:
            losses += 1
            return .lose
        }
    }
}
