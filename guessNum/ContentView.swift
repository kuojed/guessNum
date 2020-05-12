//
//  ContentView.swift
//  guessNum
//
//  Created by 郭冠杰 on 2020/5/2.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var message = "放膽去猜"
    @State var guessNum: Int?
    
    @State var upperBound = 100
    @State var lowerBound = 1
    @State var time = 6
    
    @State var state = true
    @State var guessResult = false
    
    @State private var showAlert = false
    
    @State var answer = Int.random(in: 1...100)
    
    var body: some View {
        
        
        ZStack(alignment: .bottom){
            
            
            VStack{
                
                Text("猜猜看大飛哥我有幾個小弟?")
                    .font(.system(size: 25))
                    .padding()
                
                
                HStack{
                    Text("範圍是")
                        .font(.system(size: 18))
                    
                    Text("\(lowerBound)~\(upperBound)")
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Text("還可以猜")
                        .font(.system(size: 18))
                    
                    Text("\(time)")
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.orange)
                    
                    Text("次")
                        .font(.system(size: 18))
                }
                
                TextField("", value: $guessNum, formatter: NumberFormatter()){
                    
                    
                    
                    
                    
                    if self.state {
                        
                        if (self.guessNum != nil) {
                            
                            if (self.guessNum! >= self.lowerBound) && (self.guessNum! <= self.upperBound) {
                                
                                self.time = self.time - 1
                                
                                if self.guessNum! > self.answer {
                                    
                                    self.upperBound = self.guessNum! - 1
                                    self.message = "猜少一點, 那是很久以前的事了.."
                                    self.guessResult = false
                                    
                                } else if self.guessNum! < self.answer {
                                    
                                    self.lowerBound = self.guessNum! + 1
                                    self.message = "猜多一點! 你是不是太小看我了?"
                                    self.guessResult = false
                                    
                                } else {
                                    
                                    self.message = "被你猜中了, 果然懂我"
                                    self.state = false
                                    self.guessResult = true
                                }
                                
                                if self.time == 0 && self.guessResult == false {
                                    
                                    self.message = "唉~ 我對你很失望, 正確答案是\(self.answer)"
                                    self.state = false
                                    self.guessResult = false
                                }
                                
                            }
                        }
                        
                    }
                    
                    
                }
                .font(.system(size: 50))
                .frame(width: 100, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 5))
                .multilineTextAlignment(.center)
                    
                    
                    
                .padding()
                
                
                Text(message)
                    .font(.system(size: 25))
                
                Image("thinking")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .offset(x: 30, y: 0)
                
            }
            
            
            Button(action: {
                
                self.guessNum = 0
                self.message = "放膽去猜"
                self.state = true
                self.upperBound = 100
                self.lowerBound = 1
                self.time = 6
                
                self.answer = Int.random(in: 1...100)
                
                self.showAlert = true
                
            }) {
                VStack{
                    Text("重玩")
                        .foregroundColor(.black)
                    Image(systemName: "arrow.uturn.left.square")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .background(Color.white)
                }
            }
            .offset(x: -150, y: 0)
            .alert(isPresented: $showAlert) { () -> Alert in
                
                if guessResult == true {
                    
                    let response = ["好, 我再陪你玩玩", "太好猜了, 我要提高難度了", "你再猜中我當你小弟"]
                    return Alert(title: Text(response.randomElement()!))
                    
                } else {
                    
                    let response = ["我再給你最後一次機會", "有這麼難猜嗎?", "再猜不中別怪我發飆", "你慢慢猜, 我時間多得是"]
                    
                    return Alert(title: Text(response.randomElement()!))
                    
                }
                
            }
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
