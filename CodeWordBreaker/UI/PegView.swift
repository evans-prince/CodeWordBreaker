//
//  PegView.swift
//  CodeBreaker
//
//  Created by PRINCE  on 2/17/26.
//

import SwiftUI

struct PegView: View {
    // MARK: Data In
    let peg: Peg
    let matchStatus: Match?
    
    // MARK: - Body
    
    let pegShape = Circle()
    
    var body: some View {
        draw(peg)
            .overlay {
                if peg == Code.missingPeg {
                    pegShape
                        .strokeBorder(Color.gray)
                }
            }
            .overlay{
                Text(peg)
                    .font(.system(size: 1200))
                    .minimumScaleFactor(9/1200)
            }
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
    }
    
    @ViewBuilder
    func draw(_ peg: String) -> some View {
        switch(matchStatus) {
        case .exact:
            pegShape.fill(Color.green)
        case .inexact:
            pegShape.fill(Color.yellow)
        case .nomatch:
            pegShape.fill(Color.red)
        default:
            pegShape.stroke()
        }
        
    }
}

#Preview {
    PegView(peg: "A", matchStatus: .exact)
        .padding()
}
