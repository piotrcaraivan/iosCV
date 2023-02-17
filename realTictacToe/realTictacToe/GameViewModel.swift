//
//  GameViewModel.swift
//  realTictacToe
//
//  Created by Петр Караиван on 16.02.2023.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let clums: [GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible()),]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var  isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
        //human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
    moves[position] = Move(player: .human, boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
            
        isGameboardDisabled = true
        
        //computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let botPosition = determineComputerMovePosition(in: moves)
        moves[botPosition] = Move(player: .bot, boardIndex: botPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .bot, in: moves) {
                alertItem = AlertContext.botWin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let botMoves = moves.compactMap { $0 }.filter { $0.player == .bot}
        let botPosition = Set(botMoves.map { $0.boardIndex })
        
        for patterns in winPatterns {
            let winPositions = patterns.subtracting(botPosition)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human}
        let humanPosition = Set(humanMoves.map { $0.boardIndex })
        
        for patterns in winPatterns {
            let winPositions = patterns.subtracting(humanPosition)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        // If Ai can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
            
            
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
             movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player} // удаляет нули; делает снова ход игрока удаляет все ноли, а затем отфильтровывает все игрок
       
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true } // если 2, 4, 6  то - да, это подмножество верно, так что я выигрываю.

        return false
    }
    func checkForDraw(in moves: [Move?]) -> Bool { // компактаная карта чтобы удалить все нулевые
        return moves.compactMap { $0 }.count == 9 //если убрать все 0-и и счет будет равен 9-ти, то верну значения true, если не вернет значение 9, то false - это значит что ничьи не было
    }
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
}
