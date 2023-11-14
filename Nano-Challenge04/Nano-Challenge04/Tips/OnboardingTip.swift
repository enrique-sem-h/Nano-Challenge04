import TipKit

struct OnboardingTip: Tip{
    // defining the title in a custom way
    var title: Text{
        Text("Encha seu") +
        Text(" copo ")
            .foregroundStyle(.blue) +
        Text("para cumprir a meta")
    }
    
    // defining the tip message
    var message: Text? = Text("Cada clique adiciona ") + Text("250ml").bold() + Text(" de agua")
    
    // defining its image
    var image: Image? = Image(.copo100)
    
    // defining tip options
    var options: [TipOption] {
        [
            Tips.MaxDisplayCount(2)
        ]
    }
}

struct OnboardingStyle: TipViewStyle{
    func makeBody(configuration: Configuration) -> some View { // creating a view for the tip
        VStack{
            if let image = configuration.image{ // unwrapping the image for use in the custom tip style
                image
                    .scaledToFit()
            }
            if let title = configuration.title{ // unwrapping the title for use in the custom tip style
                title
                    .font(.headline)
            }
            if let message = configuration.message{ // unwrapping the message for use in the custom tip style
                message
            }
        } // defiing custom properties, such as frame, background, image position...
        .frame(maxWidth: .infinity)
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
