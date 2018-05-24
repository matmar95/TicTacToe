//
//  gameBrain.swift
//  TicTacToe
//
//  Created by Matteo Marchesini.
//  Copyright © 2017 Matteo Marchesini. All rights reserved.
//

import Foundation

//Model brain of the game
struct gameBrain {
    
    //array of all winner combinations
    private let combinationsForWin = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    private var player: String?
    private var valueCombination: String?
    private var number: Int? = nil
    
    //func called from the game for each action of button
    mutating func checkMove(gameState: [Int]) {
        for combination in combinationsForWin {
            if gameState[combination[0]] != 0 && gameState[combination[1]] == gameState[combination[0]] && gameState[combination[1]] == gameState[combination[2]]{
                valueCombination = String(combination.map(String.init).reduce("", +))
                if gameState[combination[0]] == 1 {
                    player = "1"
                    break
                }else{
                    player = "2"
                    break
                }
            }
        }
        
        if player == nil{
            var count = 1
            for i in gameState{
                count = count*i
            }
            if count != 0 {
                player = "X"
            }
        }
    }
    
    //reset the brain
    mutating func reset(){
            player = nil
    }
    
    //public var for get the private var player
    var winner: String?{
        get{
            return player
        }
    }
    //winner combination
    var lineNumber: String?{
        get{
            return valueCombination
        }
    }

}
