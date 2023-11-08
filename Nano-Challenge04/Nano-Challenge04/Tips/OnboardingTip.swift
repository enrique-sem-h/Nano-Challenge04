import TipKit

struct OnboardingTip: Tip{
    var title: Text{
        Text("Encha seu") +
        Text(" copo ")
            .foregroundStyle(.blue) +
        Text("para cumprir a meta")
    }
    
    var message: Text? = Text("Cada clique adiciona ") + Text("250ml").bold() + Text(" de agua")
    
    var image: Image? = Image(.copo100)
    
    var options: [TipOption] {
        [
            Tips.MaxDisplayCount(2)
        ]
    }
}

struct OnboardingStyle: TipViewStyle{
    func makeBody(configuration: Configuration) -> some View {
        VStack{
            if let image = configuration.image{
                image
                    .scaledToFit()
            }
            if let title = configuration.title{
                title
                    .font(.headline)
            }
            if let message = configuration.message{
                message
            }
        }.frame(maxWidth: .infinity)
            .backgroundStyle(.background)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "multiply")
                    .font(.title2)
                    .alignmentGuide(.top) { $0[.top] - 5 }
                    .alignmentGuide(.trailing) { $0[.trailing] + 5 }
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        configuration.tip.invalidate(reason: .tipClosed)
                    }
            }
            .padding()
    }
    
}
