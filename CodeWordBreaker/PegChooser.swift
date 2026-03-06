//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by PRINCE  on 2/17/26.
//

import SwiftUI

struct PegChooser: View {
    
    let topRow: String = "QWERTYUIOP"
    let middleRow: String = "ASDFGHJKL"
    let bottomRow: String = "ZXCVBNM"

    
    //MARK: Data Out Function
    let onChoose: ((Peg) -> Void)?
    
    //MARK: - Body
    
    
    var body: some View {
        VStack{
            view(for: topRow)
            view(for: middleRow)
            view(for: bottomRow)
            
        }
        .aspectRatio(10/3, contentMode: .fit)
    }
    
    func view (for row: String) -> some View {
        HStack(){
            ForEach( row.map { String($0) } , id: \.self){ peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg, matchStatus: nil)
                }
            }
        }
    }
}

//#Preview {
//    PegChooser()
//}
