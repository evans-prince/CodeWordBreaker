//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by PRINCE  on 2/11/26.
//

import SwiftUI

struct CodeBreakerView: View {
    //MARK: Data In
    @Environment(\.words) var words
    //MARK: Data Owned by me
    @State private var game = CodeBreaker(pegCount: 5)
    @State private var checker = UITextChecker()
    
    @State private var selection: Int = 0
    
    //MARK: - Body
    
    
    var body: some View {
        VStack{
            view(for: game.masterCode)
            ScrollView{
                if !game.isOver {
                    view(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view (for: game.attempts[index])
                }
            }
            PegChooser() { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.pegCount
            }
            restartButton
        }
        .padding()
        .onChange(of: words.count, initial: true) {
            if game.attempts.count == 0 { // don't disrupt a game in progress
                if words.count == 0 { // no words yet
                    game.masterCode.word = "AWAIT"
                } else {
                    game.masterCode.word = words.random(length: 5) ?? "ERROR"
                }
            }
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            withAnimation{
                let randomLength = Int.random(in: 3...6)
                let randomWord = words.random(length: randomLength) ?? "ERROR"
                game.restartGame(with: randomWord)
                selection = 0
            }
        }
        .font(.system(size: 30))
        .minimumScaleFactor(0.1)
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation{
                if checker.isAWord(game.guess.word.lowercased() ) {
                    game.attemptGuess()
                }
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    func view(for code : Code) -> some View {
        HStack{
            CodeView(code: code, selection: $selection)
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1, contentMode: .fit)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
    struct GuessButton {
        static let mimimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = mimimumFontSize / maximumFontSize

    }
    
}



#Preview {
    CodeBreakerView()
}
