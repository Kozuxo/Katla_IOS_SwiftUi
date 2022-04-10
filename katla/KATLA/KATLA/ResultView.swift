
import SwiftUI

struct ResultView: View {
    @Binding var NotificationEndGame:Bool
    @Binding var checkResultColor: String
    @Binding var kalah: Int
    @Binding var word: Double
    @State var hasil = [Color]()
    @State var ShowResult = 0
    func WarnaAwal(){
        hasil = [Color]()
        for index in checkResultColor.indices{
            if checkResultColor[index] == "0"{
                hasil.append(Color.black)
            }
            else if checkResultColor[index] == "1"{
                hasil.append(Color.green)
            }
            else{
                hasil.append(Color.yellow)
            }
        }
        ShowResult = 1
    }
    var body: some View {
        ZStack {
            Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            VStack {
        if kalah == 1{
            Image("youwin")
            
            Button(action: {
                WarnaAwal()
            })
            {
           Image("showresult")
            }
            if ShowResult == 1{
                let columns = Array(repeating: GridItem(), count: Int(word))
                LazyVGrid(columns: columns){
                    ForEach(0..<hasil.count){i in
                        Rectangle().foregroundColor(hasil[i])
                            .frame(height: 50)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(5)
                    }
                }
            }
        }
        else if kalah == 2{
            Image("youlose")
            
            Button(action: {
                WarnaAwal()
            }){
                Image("showresult")
            
            }
            if ShowResult == 1{
                let columns = Array(repeating: GridItem(), count: Int(word))
                LazyVGrid(columns: columns){
                    ForEach(0..<hasil.count){i in
                        Rectangle().foregroundColor(hasil[i])
                            .frame(height: 50)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(5)
                    }
                }
            }
        }
                Button(action: {
                    NotificationEndGame = false
                    kalah = 0
                }){
                    Image("back")
           
        }
                
                
        }
        }
    }
}
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(NotificationEndGame: .constant(true), checkResultColor: .constant(""), kalah: .constant(1),word: .constant(4))
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

