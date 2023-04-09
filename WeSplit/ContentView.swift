//
//  ContentView.swift
//  WeSplit
//
//  Created by Mykola Zakluka on 08.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
        
    private var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        
        return checkAmount / 100 * tipSelection
    }
    
    private var totalAmount: Double {
        checkAmount + tipValue
    }
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        return totalAmount / peopleCount
    }
    
    private var currency:  FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            if $0 % 5 == 0 {
                                Text($0, format: .percent)
                                
                            }
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: currency)
                } header: {
                    Text("The total bill (tip included)")
                }
                
                Section {
                    Text(totalPerPerson, format: currency)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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
