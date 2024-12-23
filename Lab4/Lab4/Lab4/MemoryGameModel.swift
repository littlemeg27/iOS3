//
//  MemoryGameModel.swift
//  Lab4
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import Foundation

class MemoryGameModel: ObservableObject
{
    @Published var tiles: [MemoryTile] = []
    @Published var timeElapsed: Double = 0.0
    @Published var isGameStarted = false
    @Published var isGameFinished = false
    var gridSize: (width: Int, height: Int) = (4, 5)

    private var firstSelected: MemoryTile?
    
    private var timer: Timer?
        
    func invalidateTimer()
    {
        timer?.invalidate()
    }
    
    func startGame()
    {
        let imageNames = ["casino dice", "casino horse shoe", "casino party on", "casino token", "chess black pawn", "chess white horse", "construction asphalt", "construction bricks", "construction column", "construction earth", "construction helmet", "drawing colors", "drawing eraser", "drawing eyedropper", "drawing large brush", "drawing pen", "dressup brows", "dressup brush", "dressup ear", "dressup earrings", "dressup eye", "dressup feminine shoe", "dressup lips", "dressup lipstick", "dressup ring", "dressup skirt", "dressup wash", "elements fire", "emoticons broken heart", "emoticons confused", "emoticons crush", "emoticons crying out loud", "emoticons crying", "emoticons glasses", "emoticons good", "emoticons happy", "emoticons laughing out", "emoticons little kiss", "emoticons good", "farm tree", "food banana", "food corn", "food garlic", "food grape", "food lemon", "food mushroom", "food pork thig", "food pumpkin", "magic bone", "magic bulb flask", "magic cauldron", "magic cylinder flask", "magic empty rounded flask", "magic empty square flask", "magic grave", "magic ripped eye", "magic staff", "magic triangle flask", "magic wizard hat", "magicempty bulb flask", "military chainsaw", "military helmet", "military knife", "military machine gun", "military piercing ammo", "military pistol", "military strategy", "minerals blue stone", "minerals blue", "minerals coal", "minerals green stone", "minerals pure gold", "minerals red stone", "minerals rock"]
        
        let pairs = imageNames + imageNames
        tiles = pairs.shuffled().map { MemoryTile(imageName: $0) }
        isGameStarted = true
        timeElapsed = 0.0
        startTimer()
    }
    
    func selectTile(at index: Int)
    {
        guard !tiles[index].isMatched, !tiles[index].isFaceUp else { return }
        
        tiles[index].isFaceUp = true
        if let first = firstSelected
        {
            if first.imageName == tiles[index].imageName
            {
                tiles[index].isMatched = true
                tiles[tiles.firstIndex(where: {$0.id == first.id })!].isMatched = true
                checkForWin()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                {
                    self.tiles[index].isFaceUp = false
                    self.tiles[self.tiles.firstIndex(where: { $0.id == first.id })!].isFaceUp = false
                }
            }
            firstSelected = nil
        }
        else
        {
            firstSelected = tiles[index]
        }
    }
    
    func resetGame()
    {
        tiles.removeAll()
        isGameFinished = false
        isGameStarted = false
        timer?.invalidate()
    }
    
    private func startTimer()
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
        {
            _ in
            self.timeElapsed += 0.1
        }
    }
    
    private func checkForWin()
    {
        if tiles.allSatisfy({ $0.isMatched })
        {
            isGameFinished = true
            timer?.invalidate()
        }
    }
}

