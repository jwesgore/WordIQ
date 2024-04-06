import SwiftUI

struct GameOver: View {
    
    @ObservedObject var model: GameOverVM
    let nextView: (ActiveView) -> Void
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
       
        ZStack {
            VStack{
                Button( action: {
                    nextView(ActiveView.wordgame)
                }, label: {
                    Text("Play Again")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.05)
                        .background(.blue)
                        .foregroundStyle(Color("TextColor"))
                        .clipShape(.rect(cornerRadius: 16.0))
                })
                
                Button( action: {
                    
                }, label: {
                    Text("Main Menu")
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: ScreenSize().height! * 0.05)
                        .foregroundStyle(Color("TextColor"))
                })
            }
            .frame(width:ScreenSize().width! * 0.9)
        }
    }
    
    
    
    
//    var body: some View {
//        VStack {
//            
//            // Title
//            Text(model.titleText)
//                .padding()
//            
//            // Body
//            Text(model.bodyText)
//                .padding()
//            
//            // Button
//            Button {
//                model.buttonPressed()
//                model.close()
//            } label: {
//                ZStack{
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .foregroundColor(.blue)
//                    
//                    Text(model.buttonText)
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                .padding()
//                
//            }
//        }
//        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
//        .padding()
//        .background(.white)
//        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
//        .overlay {
//            VStack {
//                HStack {
//                    Spacer()
//                    Button {
//                        model.close()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .font(.title2)
//                            .fontWeight(.medium)
//                    }
//                    .tint(.black)
//                }
//                Spacer()
//            }
//            .padding()
//        }
//        .shadow(radius: cornerRadius)
//        .padding(30)
//        .offset(x: 0, y: model.offset)
//    }
}

//extension UIWindow {
//    static var current: UIWindow? {
//        for scene in UIApplication.shared.connectedScenes {
//            guard let windowScene = scene as? UIWindowScene else { continue }
//            for window in windowScene.windows {
//                if window.isKeyWindow { return window }
//            }
//        }
//        return nil
//    }
//}
//
//
//extension UIScreen {
//    static var current: UIScreen? {
//        UIWindow.current?.screen
//    }
//}

#Preview {
    GameOver(model:GameOverVM(titleText: "Game Over", bodyText: "fsdaklfbhsdfb sdafbsdao fsda uasdb fasdfsadjfb asdf ", buttonText: "Play Again"), nextView: {_ in })
}
