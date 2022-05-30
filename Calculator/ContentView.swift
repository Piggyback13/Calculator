import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case addition = "+"
    case substraction = "-"
    case multiplication = "*"
    case division = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .addition, .substraction, .multiplication, .division, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case addition, substraction, multiplication, division, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .substraction],
        [.one, .two, .three, .addition],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                //Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding()
                
                //Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton){
        switch button {
        case .addition, .substraction, .multiplication, .division, .equal:
            if button == .addition {
                self.currentOperation = .addition
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .substraction {
                self.currentOperation = .substraction
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .multiplication {
                self.currentOperation = .multiplication
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .division {
                self.currentOperation = .division
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
//                if (Double(self.value) % 1 == 0) {
//
//                }
                let currentValue = Double(self.value) ?? 0.0
                switch self.currentOperation {
                case .addition: self.value = "\(round(100 * (runningValue + currentValue)) / 100)"
                case .substraction: self.value = "\(round(100 * (runningValue - currentValue)) / 100)"
                case .multiplication: self.value = "\(round(100 * (runningValue * currentValue)) / 100)"
                case .division: self.value = "\(round(100 * (runningValue / currentValue)) / 100)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
//        case .decimal:
//            self.value =
        case .negative:
            self.runningNumber = Double(self.value) ?? 0.0
            self.value = "\(-runningNumber)"
        case .percent:
            self.runningNumber = Double(self.value) ?? 0.0
            self.value = "\(runningNumber / 100)"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
