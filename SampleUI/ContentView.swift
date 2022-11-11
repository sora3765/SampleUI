//
//  ContentView.swift
//  SampleUI
//
//  Created by ip3s on 2022/09/07.
//

import SwiftUI

struct ContentView: View {
    @State var cells: [Bool?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    @State var xIsNext: Bool = true
    @State var text: String? = nil
    
    let colCount = 3
    
    func handleClick(index: Int){
        if cells[index] == nil && text == nil {
            cells[index] = xIsNext
            if calculateWinner() != nil {
                text = "おめでとう！\(xIsNext ? "x" : "o")くん"
            } else {
                xIsNext.toggle()
            }
        }
    }
    
    func calculateWinner() -> Bool? {
        func isNotNil(val1: Bool?, val2: Bool?, val3: Bool?) -> Bool {
            return val1 != nil && val2 != nil && val3 != nil
        }
        
        
        func isEqualVal(val1: Bool?, val2: Bool?, val3: Bool?) -> Bool {
            // x
            if val1! && val2! && val3! {
                return true
            }
            // o
            if !(val1!) && !(val2!) && !(val3!) {
                return true
            }
            return false
        }
        
        //横揃い
        if isNotNil(val1: cells[0], val2: cells[1], val3: cells[2]) {
            if isEqualVal(val1: cells[0], val2: cells[1], val3: cells[2]) {
                return xIsNext
            }
        }
        if isNotNil(val1: cells[3], val2: cells[4], val3: cells[5]) {
            if isEqualVal(val1: cells[3], val2: cells[4], val3: cells[5]) {
                return xIsNext
            }
        }
        if isNotNil(val1: cells[6], val2: cells[7], val3: cells[8]) {
            if isEqualVal(val1: cells[6], val2: cells[7], val3: cells[8]) {
                return xIsNext
            }
        }
        
        //縦揃い
        if isNotNil(val1: cells[0], val2: cells[3], val3: cells[6]) {
            if isEqualVal(val1: cells[0], val2: cells[3], val3: cells[6]) {
                return xIsNext
            }
        }
        if isNotNil(val1: cells[1], val2: cells[4], val3: cells[7]) {
            if isEqualVal(val1: cells[1], val2: cells[4], val3: cells[7]) {
                return xIsNext
            }
        }
        
        if isNotNil(val1: cells[2], val2: cells[5], val3: cells[8]) {
            if isEqualVal(val1: cells[2], val2: cells[5], val3: cells[8]) {
                return xIsNext
            }
        }
        
        //斜め揃い
        if isNotNil(val1: cells[0], val2: cells[4], val3: cells[8]) {
            if isEqualVal(val1: cells[0], val2: cells[4], val3: cells[8]) {
                return xIsNext
            }
        }
        if isNotNil(val1: cells[2], val2: cells[4], val3: cells[6]) {
            if isEqualVal(val1: cells[2], val2: cells[4], val3: cells[6]) {
                return xIsNext
            }
        }
        return nil // 勝負がついていない
    }
    
    func reset(){
        cells = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
        xIsNext = true
        text = nil
    }
    
    
    var body: some View {
        VStack {
            Text(text ?? " ")
            VStack(spacing:1){
                ForEach(0..<colCount){i in
                    HStack(spacing: 1){
                        ForEach(0..<cells.count / colCount){j in
                            
                            //式　？　式がTrueの時の値：Falseの時の値
                            Button(action: {
                                self.handleClick(index: (i * colCount)+j)
                            }, label: {
                                Text(cells[(i*colCount)+j] == nil ? "" : cells[(i*colCount)+j]! ? "x" : "o" )
                                    .font(.system(size: 32))
                                    .frame(width: 80, height: 80, alignment: .center)
                            })
                            .foregroundColor(cells[(i*colCount)+j] == nil ? .black : cells[(i*colCount)+j]! ? .blue : .red )
                            .frame(width: 80, height: 80, alignment: .center)
                            .padding()
                            .background(Color.white)
                            .disabled(text != nil)
                        }
                    }
                    
                }
                
            }
            
            
            
            .background(Color.black)
            Button(action: {
                reset()
            }, label: {
                Text("Reset")
            })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}


