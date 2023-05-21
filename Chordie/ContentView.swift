//
//  ContentView.swift
//  Chordie
//
//  Created by Ayo Moreira on 5/20/23.
//

import SwiftUI

var iq = intervalQuestions

var getQuestion = iq["C"]?.keys.randomElement()
var getAnswer = iq["C"]?["D is the 2 of"]! // access answer


struct ContentView: View {
    @State private var showAnswer = false;
    
    
    struct FlashCard: View {
        var body: some View {
            Text(getQuestion!)
                .font(.title)
        }
    }
    
    var body: some View {
        Button {
            checkAnswer()
        } label: {
            FlashCard()
        }
        .frame(width: 200, height: 200)
        .foregroundColor(.black)
        .background(Color.mint)
        .alert("Answer", isPresented: $showAnswer) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Test")
        }
        
    }
    
    func checkAnswer() {
        showAnswer = true
    }
    
    func askQuestion() {}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
