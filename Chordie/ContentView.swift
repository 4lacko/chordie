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

enum QuizMode {
    case interval, chord, tension, limit
}

struct ContentView: View {
    @State var currentQuestion: Question?
    @State var showAnswer = false
    @State var mode: QuizMode = .tension
    
    var body: some View {
        NavigationStack {
            VStack {
                if let question = currentQuestion {
                    Text(question.question)
                        .font(.title)
                    Button(action: {
                        self.showAnswer.toggle()
                    }) {
                        Text(showAnswer ? question.answer : "Show Answer")
                            .frame(width: 135, height: 135)
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
                            .frame(width: 135, height: 135/2)
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
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            mode = .interval
                            nextQuestion()
                        }) {
                            Text("Intervals")
                        }
                        Button(action: {
                            mode = .chord
                            nextQuestion()
                        }) {
                            Text("Chords")
                        }
                        Button(action: {
                            mode = .tension
                            nextQuestion()
                        }) {
                            Text("Tensions")
                        }
                        Button(action: {
                            mode = .limit
                            nextQuestion()
                        }) {
                            Text("Interval Limits")
                        }
                    }
                }
            }
            .onAppear {
                self.nextQuestion()
            }
            
        }
    }
    
    func loadQuestions(questions: [String : [String : String]]) {
        let keys = Array(questions.keys)
        if let randomKey = keys.randomElement(),
           let randomQuestion = questions[randomKey]?.randomElement() {
            self.currentQuestion = Question(question: randomQuestion.key, answer: randomQuestion.value)
        }
    }
    
    func loadQuestionSetTwo(questions: [String : String]) {
        let keys = Array(questions.keys)
        if let randomKey = keys.randomElement(),
           let randomQuestion = questions[randomKey] {
            self.currentQuestion = Question(question: randomKey, answer: randomQuestion)
        }
    }
    
    func nextQuestion() {
        self.showAnswer = false
        switch mode {
        case.interval:
            loadQuestions(questions: intervalQuestions)
        case.chord:
            loadQuestions(questions: chordQuestions)
        case.tension:
            loadQuestionSetTwo(questions: tensionQuestions)
        case.limit:
            loadQuestionSetTwo(questions: lowIntervalLimitQuestions)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
