//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by PRINCE  on 2/15/26.
//

import Foundation

typealias Peg = String

struct CodeBreaker {
    var masterCode:  Code
    var guess: Code
    var attempts: [Code] = []
    var pegChoices: [Peg]
    var pegCount: Int
    
    
    init (pegCount: Int = 4) {
        pegChoices = "QWERTYUIOPASDFGHJKLZXCVBNM".map { String($0) }
        self.pegCount = pegCount
        
        masterCode = Code(pegCount: pegCount, kind: .master(isHidden: true))
        guess = Code(pegCount: pegCount, kind: .guess)
        masterCode.randomize(from: self.pegChoices)
        print(masterCode)
    }
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    // append guess to atempts[] if not attempted previously
    mutating func attemptGuess(){
        // guards to check if guess have no pegs or previously guessed
        if attempts.contains(where: {$0.pegs == guess.pegs}) { return }
        if guess.pegs.contains(Code.missingPeg) {return}
        
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
        
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
    
    mutating func restartGame(with newWord: String? = "HELLO"){
        pegCount = newWord?.count ?? 5
        
        masterCode = Code(pegCount: pegCount, kind: .master(isHidden: true))
        masterCode.word = newWord ?? "HELLO"
        guess = Code(pegCount: pegCount, kind: .guess)
        attempts.removeAll()
    }
    
}



