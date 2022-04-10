

import SwiftUI
import AVFoundation
import Foundation

struct NumberData: Identifiable{
    let id = UUID()
    var value: String
    var color = Color.gray
}

struct ContentView: View {
    
    @State var word: Double = 4
    @State var check = [NumberData]()
    @State var checkResultColor: String = ""
    @State var OnScreenKeyboard = [[String]]()
    @State var OnScreenKeyboardColor = [[Color]]()
    @State var StartValue = 0
    @State var InputCounter = 0
    @State var CurrentLetter = 0
    @State var GuessLetter: String = ""
    @State var NotificationValue = false
    @State var NotificationText = ""
    @State var menang: Int = 0
    @State var HealthBar: Int = 5
    @State private var NotificationEndGame = false
    @State var kalah: Int = 0
    

    
     func ReadFile(word: Int){
        if (word == 4){
            if let asset = NSDataAsset(name: "four"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                GuessLetter = String(array[num])
            }
        }
        else if (word == 5){
            if let asset = NSDataAsset(name: "five"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                GuessLetter = String(array[num])
            }
        }
        else if (word == 6){
            if let asset = NSDataAsset(name: "six"),
               let content = String(data: asset.data, encoding: .utf8){
                let array = content.split(separator: "\n")
                let num = Int.random(in: 0...(array.count - 1))
                GuessLetter = String(array[num])
            }
        }
    }
 
    func InitialNumbers(){
        check = []
        checkResultColor = ""
        for _ in 1...Int(word)*HealthBar{
            let number = ""
            check.append(NumberData(value: number))
        }
    }
    
    func UpdateNumbers(){
        check = []
        checkResultColor = ""
        for _ in 1...Int(word)*HealthBar{
            let number = ""
            check.append(NumberData(value: number))
        }
    }
    
    func InitialKeyboard(){
        OnScreenKeyboard = []
        OnScreenKeyboardColor = []
        InputCounter = 0
        CurrentLetter = 0
        kalah = 0
        OnScreenKeyboard.append(["Q","W","E","R","T","Y","U","I","O","P"])
        OnScreenKeyboardColor.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
        OnScreenKeyboard.append(["A","S","D","F","G","H","J","K","L"])
        
        OnScreenKeyboardColor.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
        OnScreenKeyboard.append(["ENTER","Z","X","C","V","B","N","M","<"])
        
        OnScreenKeyboardColor.append([Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray,Color.gray])
    }
            
    func UpdateGuess(guess: Int){
        HealthBar = guess
    }
    func WriteChar(w:String)->(){
        AudioServicesPlaySystemSound(1104)
        if CurrentLetter % Int(word) != (Int(word) - 1){
            check[CurrentLetter].value = w
            CurrentLetter += 1
        }
        else{
            check[CurrentLetter].value = w
        }
    }
            
    func EnterJudge(){
        if CurrentLetter % Int(word) == (Int(word) - 1) && check[CurrentLetter].value != ""{
            InputCounter += 1
            CurrentLetter += 1
            var correct: Int = 0
            for i in CurrentLetter-Int(word)..<CurrentLetter{
                var co: Int = 0
                for index in GuessLetter.indices{
                    if check[i].value == String(GuessLetter[index]){
                        check[i].color = .yellow
                        if i % Int(word) == co{
                            check[i].color = .green
                            correct += 1
                            break
                        }
                    }
                    co += 1
                    if co == Int(word) && check[i].color == .gray{
                        check[i].color = .blue
                    }
                }
                for j in 0..<OnScreenKeyboardColor.count{
                    for k in 0..<OnScreenKeyboardColor[j].count{
                        if OnScreenKeyboard[j][k] == check[i].value{
                            if OnScreenKeyboardColor[j][k] != .green && OnScreenKeyboardColor[j][k] != .blue{
                                OnScreenKeyboardColor[j][k] = check[i].color
                            }
                        }
                    }
                }
            }
            if correct == Int(word){

                for i in 0..<Int(word)*HealthBar{
                    if check[i].color == Color.yellow{
                        checkResultColor += "2"
                    }
                    else if check[i].color == Color.green{
                        checkResultColor += "1"
                    }
                    else {
                        checkResultColor += "0"
                    }
                }
                kalah = 1
                menang += 1
            }
            else if InputCounter == HealthBar{
                for i in 0..<Int(word)*HealthBar{
                    if check[i].color == Color.yellow{
                        checkResultColor += "2"
                    }
                    else if check[i].color == Color.green{
                        checkResultColor += "1"
                    }
                    else {
                        checkResultColor += "0"
                    }
                }
                kalah = 2
            }
            else{
                var exp:Int = 0
                for i in CurrentLetter-Int(word)..<CurrentLetter{
                    if check[i].color == .blue{
                        exp += 1
                    }
                }
                if exp == Int(word){
                    NotificationValue = true
                    NotificationText = "Not In Word List!"
                }
            }
        }
        else{
            NotificationValue = true
            NotificationText = "Not Enough Letters!"
        }
    }
            
    func BackSpace(){
        if CurrentLetter % Int(word) != 0{
            check[CurrentLetter].value = ""
            CurrentLetter -= 1
        }
        else{
            check[CurrentLetter].value = ""
        }
    }
    
    var body: some View {
        
        ZStack{
            Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            
            
        VStack(spacing:10){
            
            VStack(spacing:0){
                Image("katla")
                    .resizable()
                    .frame(width: 120, height: 90)
                Image("indowordle")
                    .resizable()
                    .frame(width: 180, height: 60)
            }
  
            HStack(spacing:0){
                Button(action: {
                InitialNumbers()
                InitialKeyboard()
                ReadFile(word: Int(word))
                StartValue = 1
                }) {
                    Image("start")
                        .resizable()
                        .frame(width: 120, height: 60)
                        .padding()
                }
                
              Image("winstreak")
                    .resizable()
                    .frame(width: 120, height: 60)
                Text("\(menang)")
                    .font(.system(size:20))
                    .foregroundColor(.white)
            }
            HStack(spacing:0){
                Image("letter")
                    .resizable()
                    .frame(width: 80, height: 40)
                Text("\(Int(word))")
                    .font(.system(size:20))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Slider(value: $word, in: 4...6, step: 1)
                    .accentColor(Color.white)
                    .frame(width: 200.0)
                    .onChange(of: word, perform: {
                        value in UpdateNumbers()
                    } )
            }
        
    
            ZStack{
                let columns = Array(repeating: GridItem(), count: Int(word))
                LazyVGrid(columns: columns){
                    ForEach(check){number in
                        ZStack{
                            Rectangle().foregroundColor(number.color)
                                .frame(width: 45, height: 45)
                                .padding(2)
                                .background(Color.white)
                                .cornerRadius(5)
                            Text("\(number.value)")
                        }
                    }
                }
                .alert(NotificationText, isPresented: $NotificationValue, actions: {
                    Button("Try Again!"){
                    }
                })
                if kalah == 1{
                    Button(action: {
                        NotificationEndGame = true
                    }){
                        HStack {
                            Image("correct")
                                    .resizable()
                                    .frame(width: 320, height: 120)
                        }
                    }
                    .font(.largeTitle)
                    .fullScreenCover(isPresented: $NotificationEndGame, content:{ResultView(NotificationEndGame: $NotificationEndGame,checkResultColor:$checkResultColor,kalah:$kalah,word:$word)})
                }
                else if kalah == 2{
                    Button(action: {
                        NotificationEndGame = true
                    }){
                        HStack{
                            Image("wrong")
                                .resizable()
                                .frame(width: 300, height: 160)
                        }
                    }
                    .font(.largeTitle)
                    .fullScreenCover(isPresented: $NotificationEndGame, content:{ResultView(NotificationEndGame: $NotificationEndGame,checkResultColor:$checkResultColor,kalah:$kalah,word:$word)})
                }
            }
            HStack{
                           Button("Add"){
                               if HealthBar < 6{
                                   HealthBar += 1
                                   InitialNumbers()
                                   InitialKeyboard()
                                   ReadFile(word: Int(word))
                                   StartValue = 1
                               }
                           }.background(Color.gray)
                               .cornerRadius(5)
                           .foregroundColor(Color.white)
                           Button("Decrease"){
                               if HealthBar > 3{
                                   HealthBar -= 1
                                   InitialNumbers()
                                   InitialKeyboard()
                                   ReadFile(word: Int(word))
                                   StartValue = 1
                               }
                           }.background(Color.gray)
                               .cornerRadius(5)
                           .foregroundColor(Color.white)
                           Button("Cheat"){
                               var co = 0
                               for index in GuessLetter.indices{
                                   if co == CurrentLetter{
                                       WriteChar(w: String(GuessLetter[index]))
                                       break
                                   }
                                   co += 1
                               }
                           }.background(Color.gray)
                               .cornerRadius(5)
                           .foregroundColor(Color.white)
                       }
            if StartValue == 1{
                VStack{
                    ForEach(0..<3){i in
                        HStack{
                            ForEach(0..<OnScreenKeyboard[i].count){ j in
                                if (i == 2 && j == 0 || i == 2 && j == 8){
                                    ZStack{
                                        Rectangle().frame(width: 52, height: 30)
                                            .foregroundColor(.gray)
                                            .cornerRadius(10)
                                            .onTapGesture{
                                                if(i==2 && j == 0){
                                                    EnterJudge()
                                                }
                                                else{
                                                    BackSpace()
                                                }
                                            }
                                        Text(OnScreenKeyboard[i][j])
                                    }
                                }
                                else{
                                    ZStack{
                                        Rectangle().frame(width: 30, height: 30)
                                            .foregroundColor(OnScreenKeyboardColor[i][j])
                                            .onTapGesture{ WriteChar(w:OnScreenKeyboard[i][j])}
                                            .cornerRadius(10)
                                        Text(OnScreenKeyboard[i][j])
                                    
                                    }
                                }
                            }
                        }
                    }
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



