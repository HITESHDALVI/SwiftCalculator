//
//  ContentView.swift
//  SwiftCalculator
//
//  Created by Hitesh Dalvi on 29/01/24.
//

import SwiftUI
enum CalBtn : String {
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
    case multiply = "*"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percentage = "%"
    case negative = "-/+"
    var buttonColor: Color{
        switch self {
        case.add, .subtract, .multiply, .divide, .equal :
            return .orange
        case .clear, .negative, .percentage:
            return Color(.lightGray)
        default:
            return Color(UIColor(red:55/255.0,green :55/255.0,blue:55/255.0,alpha:1 ))
        }
    }
}
enum Operation{
    case add, subtract, multiply, divide, none
}
struct ContentView: View {
    @State var value = "0"
    
    @State var curentOperation :Operation = .none
    
    @State var runningNumber = 0
    
    let buttons : [[CalBtn]]=[
        [.clear, .negative, .percentage, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                    .foregroundStyle(.white)}
                .padding()
                ForEach(buttons,id: \.self){ row in
                    HStack(spacing:12){
                        ForEach(row, id : \.self){ item in
                            Button(action: {self.didTab(button: item)}, label:{
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item:item),
                                        height: self.buttonHeigth(item:item))
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                            
                        }
                    }.padding(.bottom, 3)
                }
            }
        }
    }
    func didTab(button:CalBtn){
        switch button {
        case .add, .subtract, .multiply, .equal, .divide:
            if button == .add {
                self.curentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }else if button == .subtract {
                self.curentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0

            }else if button == .multiply {
                self.curentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0

            }else if button == .divide {
                self.curentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0

            }else if button == .equal {
                 let runningValue = self.runningNumber
               let currentValue = Int(self.value) ?? 0
                switch self.curentOperation
                {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
             
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percentage:
            if button == .percentage{
                let runningValue = Int(self.value) ?? 0
                self.value = "\(runningValue / 100)"
            }else if button == .decimal{
                let runningValue = Int(self.value) ?? 0
                self.value = "\(runningValue)."
            }
            break
        default:let number = button.rawValue
            if self.value == "0"{
                value = number
            }else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    func buttonWidth(item:CalBtn)->CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12))/4)*2
        }
        return(UIScreen.main.bounds.width - (5*12))/4
    }
    func buttonHeigth(item:CalBtn)->CGFloat{
        return(UIScreen.main.bounds.width - (5*12))/4
    }

}
//
//#Preview {
//    ContentView()
//}

struct ContentView_Previews : PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
