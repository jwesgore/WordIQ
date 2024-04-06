import SwiftUI

struct GameOver: View {
    @ObservedObject var model: GameOverVM
    
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack {
            
            // Title
            Text(model.titleText)
                .padding()
            
            // Body
            Text(model.bodyText)
                .padding()
            
            // Button
            Button {
                model.buttonPressed()
                model.close()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(.blue)
                    
                    Text(model.buttonText)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
                
            }
        }
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        model.close()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    .tint(.black)
                }
                Spacer()
            }
            .padding()
        }
        .shadow(radius: cornerRadius)
        .padding(30)
        .offset(x: 0, y: model.offset)
    }
}

#Preview {
    GameOver(model:GameOverVM(titleText: "Game Over", bodyText: "fsdaklfbhsdfb sdafbsdao fsda uasdb fasdfsadjfb asdf ", buttonText: "Play Again"))
}
