//
//  ContentView.swift
//  BillingRate
//
//  Created by Mohammad Azam on 1/4/23.
//

import SwiftUI

enum BillingOptions: String, CaseIterable {
    case weekly
    case monthly
    case yearly
}

extension BillingOptions: Identifiable {
    
    var id: String {
        rawValue
    }
    
    var displayName: String {
        switch self {
            case .weekly:
                return "Weekly"
            case .monthly:
                return "Monthly"
            case .yearly:
                return "Yearly"
        }
    }
}

struct ContentView: View {
    
    @State private var billRate: String = ""
    @FocusState private var billRateFocused: Bool
    @State private var hoursWorked: Double = 40
    
    private var weeklyRate: Double {
        (Double(billRate) ?? 0.0) * hoursWorked
    }
    
    private var numberOfWeeks: Int {
        let calendar = Calendar.current
        guard let weeks = calendar.range(of: .weekOfMonth, in: .month, for: Date())?.count else { return 0 }
        return weeks
    }
    
    private var monthlyRate: Double {
        return (Double(billRate) ?? 0.0) * hoursWorked * Double(numberOfWeeks)
    }
    
    private var yearlyRate: Double {
        (Double(billRate) ?? 0.0) * hoursWorked * 52
    }
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    Text(Locale.current.currencySymbol ?? "$")
                        .font(.system(size: 50))
                        .padding(.top, 20)
                    TextField("", text: $billRate, prompt: Text("Enter hourly rate").foregroundColor(.gray))
                        .keyboardType(.numberPad)
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .focused($billRateFocused)
                        .minimumScaleFactor(0.3)
                        .background(.black)
                    .padding(.top, 20)
                }
                
                Slider(value: $hoursWorked, in: 0...100, step: 5)
                Text(String(format: "Hours worked: %.0f", hoursWorked))
                    .padding()
                    .font(.body)
                    .opacity(0.6)
                  
                
                Spacer()
                
                ForEach(BillingOptions.allCases) { option in
                    switch option {
                        case .weekly:
                            RateView(title: "Weekly", rate: weeklyRate)
                        case .monthly:
                            RateView(title: "Monthly", rate: monthlyRate)
                        case .yearly:
                            RateView(title: "Yearly", rate: yearlyRate)
                    }
                    Divider()
                }
                
                Spacer()
                VStack(alignment: .center) {
                    Text("Number of weeks: \(numberOfWeeks)")
                    Text("Weeks per year: \(52)")
                }.opacity(0.4)
                    .font(.caption)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .background(.black)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // loose focus on TextField
                        billRateFocused = false
                    } label: {
                        Text("Done")
                    }.disabled(billRate.isEmpty)

                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}
