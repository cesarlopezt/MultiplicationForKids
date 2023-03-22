//
//  ContentView.swift
//  MultiplicationForKids
//
//  Created by Cesar Lopez on 3/19/23.
//

import SwiftUI



struct RandomColorBoxText: View {
    var content: Int
    let colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.purple, Color.cyan, Color.brown, Color.indigo, Color.white, Color.mint, Color.orange, Color.pink]

    var body: some View {
        Text(content, format: .number)
            .bold()
            .font(.largeTitle)
            .frame(width: 60, height: 60)
            .background(colors.randomElement()!)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct TestView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentQuestion = 1
    @State private var score = 0
    @State private var multiplicand = Int.random(in: 2...12)
    @State private var answer: Int? = nil
    
    @State private var showAlert = false

    var multiplicationTable: Int
    var numberOfQuestions: Int

    var body: some View {
        ZStack {
            Image("backgroundColorGrass").frame(width: 20, height: 20)
            VStack {
                HStack {
                    VStack {
                        Text("Question No.")
                        Text("\(currentQuestion)/\(numberOfQuestions)").bold()
                    }
                    Spacer()
                    VStack {
                        Text("Score")
                        Text(score, format: .number).bold()
                    }
                }
                Spacer()
                HStack {
                    RandomColorBoxText(content: multiplicand)
                    Text("x")
                        .font(.title2)
                    RandomColorBoxText(content: multiplicationTable)
                    Text("=")
                        .font(.title2)
                }
                
                TextField("Equals", value: $answer, format: .number)
                    .keyboardType(.numberPad)
                    .font(.largeTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150, height: 50)
                Spacer()
                
                Button("Evaluate") {
                    evaluate()
                }
                .frame(width: 200, height: 60)
                .bold()
                .foregroundColor(.black)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(30)
        }.alert("Good Job", isPresented: $showAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your score was \(score)/\(numberOfQuestions).")
        }
    }
    
    func evaluate() {
        let result = multiplicand * multiplicationTable
        if (result == answer) {
            score += 1
        }

        if (currentQuestion >= numberOfQuestions) {
            showAlert = true
        } else {
            nextQuestion()
            currentQuestion += 1
        }
    }
    
    func nextQuestion() {
        answer = nil
        multiplicand = Int.random(in: 2...12)
    }
}

struct ContentView: View {
    @State private var multiplicationTable = 6
    @State private var numberOfQuestions = 10
    
    var numberOfQuestionOptions = [5, 10, 15]

    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundColorForest").frame(width: 20, height: 20)
                VStack {
                    Text("Multiplication table to practice")
                        .bold()
                        .padding(5)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Picker("Multiplication table", selection: $multiplicationTable) {
                        ForEach(2...12, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.wheel)
                    Spacer()
                    Text("Number of questions")
                        .bold()
                        .padding(5)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Picker("Number of questions", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionOptions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                    Spacer()
                    NavigationLink(destination: TestView(
                        multiplicationTable: multiplicationTable,
                        numberOfQuestions: numberOfQuestions)
                    ) {
                        Text("Start Test")
                            .frame(width: 200, height: 60)
                            .bold()
                            .foregroundColor(.black)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                }
                .padding(35)
                .navigationTitle("Learn multiplication")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
