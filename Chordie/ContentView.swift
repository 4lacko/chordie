//
//  ContentView.swift
//  Chordie
//
//  Created by Ayo Moreira on 5/20/23.
//

import SwiftUI

struct Question {
    let question: String
    let answer: String
}

struct ContentView: View {
    @State var currentQuestion: Question?
    @State var showAnswer = false
    
    var body: some View {
        VStack {
            if let question = currentQuestion {
                Text(question.question)
                    .font(.title)
                Button(action: {
                    self.showAnswer.toggle()
                }) {
                    Text(showAnswer ? question.answer : "Show Answer")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                Button(action: {
                    self.nextQuestion()
                }) {
                    Text("Next Question")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            } else {
                Text("Loading...")
                    .font(.title)
            }
        }
        .padding()
        .onAppear {
            self.nextQuestion()
        }
    }
    
    func nextQuestion() {
        self.showAnswer = false
        let keys = Array(intervalQuestions.keys)
        if let randomKey = keys.randomElement(),
           let randomQuestion = intervalQuestions[randomKey]?.randomElement() {
            self.currentQuestion = Question(question: randomQuestion.key, answer: randomQuestion.value)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
