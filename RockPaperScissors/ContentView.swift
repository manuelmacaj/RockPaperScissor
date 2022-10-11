//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Manuel Macaj on 16/04/21.
//

import SwiftUI

struct ContentView: View {
    //MARK: -Proprieties
    
    private var rockPaperScissor = ["Rock", "Paper", "Scissors"]
    @State private var roundGame = 1
    @State private var showMessage = false
    @State private var whoWin = ""
    @State private var titleAlert = ""
    @State private var messageAlert = ""
    @State private var selectAction = Int.random(in: 0 ... 2)
    @State private var round = 1
    @State private var userWin = 0
    @State private var iaWin = 0
    
    //MARK: -Body
    var body: some View {
        
        NavigationView {
            
            //MARK: -ZStack
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color("RedColor"), Color("BlueColor"), Color("YellowColor")]), startPoint: .bottom, endPoint: .zero)
                    .edgesIgnoringSafeArea(.all)
                
                //MARK: -VStack
                VStack (alignment: .center, spacing: 10) {
                    
                    //MARK:- if & else
                    if(round == 10) {
                        LabelInfoText(text: whoWin)
                        Button(action: {
                            newGame()
                        }) {
                            Text("Start new game")
                                .font(.system(size:24, weight: .bold, design: .default))
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(9)
                                .foregroundColor(Color.white)
                        }
                    } else {
                        HStack {
                            LabelInfoText(text: "Round \(round)")
                            Spacer()
                            LabelInfoText(text: "User Win: \(userWin)")
                            Spacer()
                            LabelInfoText(text: "IA Win: \(iaWin)")
                            
                        }
                        .padding()
                        
                        Spacer()
                        
                        Text("Rock, Paper or Scissor?")
                            .font(.system(size:18, weight: .bold, design: .default))
                            .padding()
                        
                        //MARK:- HStack
                        HStack(spacing: 20) {
                            VStack {
                                Button(action: {
                                    rockPaperSissiorGame(with: rockPaperScissor[0])
                                })
                                {
                                    Text("🪨")
                                        .font(.system(size:100))
                                }
                                LabelInfoText(text: "Rock")
                            }
                            VStack {
                                Button(action: {
                                    rockPaperSissiorGame(with: rockPaperScissor[1])
                                })
                                {
                                    Text("📄")
                                        .font(.system(size:100))
                                }
                                LabelInfoText(text: "Paper")
                            }
                            VStack {
                                Button(action: {
                                    rockPaperSissiorGame(with: rockPaperScissor[2])
                                })
                                {
                                    Text("✂️")
                                        .font(.system(size:100))
                                    
                                }
                                LabelInfoText(text: "Scissors")
                            }
                            
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(Text("Rock, paper, scissor"))
            .alert(isPresented: $showMessage, content: {
                Alert(title: Text(titleAlert), message: Text(messageAlert), dismissButton: .default(Text("Ok")){
                    verifyRound()
                })
            })
        }
    }
    
    
    //MARK: -Rock paper game func
    func rockPaperSissiorGame(with userSelect: String) {
        let iaSelect = rockPaperScissor[selectAction]
        
        if userSelect.elementsEqual(iaSelect) {
            titleAlert = "Tie"
            messageAlert = ""
        }
        else {
            if userSelect == "Rock" {
                if iaSelect == "Paper" {
                    titleAlert = "You lose"
                    messageAlert = "The IA wins. Paper beats rock"
                    iaWin += 1
                } else if iaSelect == "Scissors" {
                    titleAlert = "You win"
                    messageAlert = "You win. Rock beats scissors"
                    userWin += 1
                }
            } else if userSelect == "Paper" {
                if iaSelect == "Scissors" {
                    titleAlert = "You lose"
                    messageAlert = "The IA wins. Scissors beats paper"
                    iaWin += 1
                } else if iaSelect == "Rock" {
                    titleAlert = "You win"
                    messageAlert = "You win. Paper beats rock"
                    userWin += 1
                }
            } else {
                if iaSelect == "Rock" {
                    titleAlert = "You lose"
                    messageAlert = "The IA wins. Scissors beats paper"
                    iaWin += 1
                } else if iaSelect == "Paper" {
                    titleAlert = "You win"
                    messageAlert = "You win. Scissor beats paper"
                    userWin += 1
                }
            }
        }
        round += 1
        showMessage = true
    }
    
    //MARK: -Verify round func
    func verifyRound() {
        if round == 10 {
            if userWin > iaWin {
                whoWin = "Congratulation, you win.\nStart a new game if you want"
            } else if userWin < iaWin{
                whoWin = "I'm alfraid, you lost.\nStart a new game if you want"
            } else {
                whoWin = "It's a tie, not bad.\nStart a new game if you want"
            }
        }
        else {
            selectAction = Int.random(in: 0 ... 2)
        }
    }
    
    //MARK: -New game func
    func newGame() {
        round = 0
        selectAction = Int.random(in: 0 ... 2)
        userWin = 0
        iaWin = 0
        whoWin = ""
    }
}

struct LabelInfoText: View {
    var text: String
    
    var body: some View {
        if (UIDevice.current.name == "iPhone 8" || UIDevice.current.name == "iPhone 7" || UIDevice.current.name == "iPhone 6s" || UIDevice.current.name == "iPhone SE 2") {
            Text(text)
                .font(.system(size: 16, weight: .bold, design: .default))
                .padding()
        }
        else {
            Text(text)
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
