//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Jigar on 1/15/24.
//

import SwiftUI

enum CalcButton : String {
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
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    //landscape
    case open = "("
    case close = ")"
    case mc = "mc"
    case mplus = "m+"
    case mminus = "m-"
    case mr = "mr"
   
    
    case second = "2nd"
    case  pow2 = "x^2"
    case pow3 = "x^3"
    case powy = "x^y"
    case powx = "e^x"
    case pow10 = "10^x"
    
    case farsion = "1/x"
    case sqrt = "sqrt(x)"
    case sqrt3 = "sqrt3(x)"
    case sqrty = "sqrty(x)"
    case ln = "ln"
    case log = "log10"
    
    case fac = "x!"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case e = "e"
    case ee = "EE"
    
    case rad = "Rad"
    case sinh = "sinh"
    case cosh = "cosh"
    case tanh = "tanh"
    case pi = "pi"
    case rand = "Rand"
    
    var buttonColor : Color {
        switch self {
        case .add,.subtract,.multiply,.divide,.equal:
            return .orange
        case .clear,.negative,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green:55/255.0 , blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add,subtract,multiply,divide,none
}


struct ContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var isLandscape : Bool {
        (verticalSizeClass == .compact ) || (verticalSizeClass == .regular && horizontalSizeClass == .regular)
    }
    
   // let arrButtons: [[CalcButton]] = [[]]
    
    var buttons: [[CalcButton]] {
        if isLandscape {
            return [
                [.open,.close,.mc,.mplus,.mminus,.mr,.clear,.negative,.percent,.divide],
                [.second,.pow2,.pow3,.powy,.powx,.pow10,.seven,.eight,.nine,.multiply],
                [.farsion,.sqrt,.sqrt3,.sqrty,.ln,.log,.four,.five,.six,.subtract],
                [.fac,.sin,.cos,.tan,.e,.ee,.one,.two,.three,.add],
                [.rad,.sinh,.cosh,.tanh,.pi,.rand,.zero,.decimal,.equal]
                
            ]
        } else {
            return [
                [.clear,.negative,.percent,.divide],
                [.seven,.eight,.nine,.multiply],
                [.four,.five,.six,.subtract],
                [.one,.two,.three,.add],
                [.zero,.decimal,.equal]
                
            ]
        }
    }
     
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation : Operation = .none
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Text(value)
                        .bold()
                        .frame(maxWidth: .infinity,maxHeight:100,alignment:.trailing)
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                        
                }.padding()
                
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row,id: \.self) { item in
                                Button(action: {
                                    didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                        .background(
                                            
                                            item.buttonColor
                                        
                                        )
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item)/2)
                                    
                                })
                                
                            }
                        }.padding(.bottom,3)
                        
                    }
                
                
                    
            }
            
        }
        
    }
    
    func didTap(button : CalcButton) {
        
        switch button {
        case .add,.subtract,.divide,.multiply,.equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }   else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let current = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue+current)"
                case .subtract:
                    self.value = "\(runningValue-current)"
                case .multiply:
                    self.value = "\(runningValue*current)"
                case .divide:
                    self.value = "\(runningValue/current)"
               
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
           
        case .clear :
            self.value = "0"
            break
        case .decimal,.negative,.percent :
            break
        default :
            let number = button.rawValue
            if self.value == "0"{
                value = number
            } else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item : CalcButton) -> CGFloat {
        if isLandscape {
            
            if(item == .zero) {
                
                return ((UIScreen.main.bounds.width-(10*12))/10)*2
            }
            
            return (UIScreen.main.bounds.width-(11*12))/10
        } else {
            if(item == .zero) {
                return ((UIScreen.main.bounds.width-(4*12))/4)*2
            }
            return (UIScreen.main.bounds.width-(5*12))/4
        }
        
    }
    
    func buttonHeight() -> CGFloat {
        if isLandscape {
            return (UIScreen.main.bounds.width-(11*12))/10
        } else {
            return (UIScreen.main.bounds.width-(5*12))/4
        }
    }
    
    
}

#Preview {
    ContentView()
}
