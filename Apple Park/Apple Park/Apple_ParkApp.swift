import SwiftUI

@main
struct WondersApp: App {
    @State private var vm = LocationsViewModel()
    @State private var showWelcomeScreen: Bool = true

    var body: some Scene {
        WindowGroup {
            if showWelcomeScreen {
                VStack {
                    ZStack {
                        VStack {
                            HandWiggleFillAnimation()
                                .frame(width: 100, height: 100)

                            HStack(spacing: 10) {
                                DelayedText(text: "Apple", delay: 0.5)
                                DelayedText(text: "Park", delay: 1.0)
                                DelayedText(text: "Companion", delay: 1.5)
                            }
                                .font(.title)
                                .fontWeight(.bold)
                                .modifier(GradientOffsetModifier(animation: .linear(duration: 4.0)))
                                .foregroundColor(.black)
                                .padding(.bottom, 10)

                            DelayedText(text: "Explore the Park", delay: 2.0)
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding(.bottom, 30)

                            DelayedButton(delay: 2.5) {
                                withAnimation {
                                    showWelcomeScreen.toggle()
                                }
                            } label: {
                                Label("Let's Go", systemImage: "")
                                    .frame(height: 35)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(10)
                            }
                                .buttonStyle(.borderedProminent)
                                .padding(.all)
                        }
                    }
                        .edgesIgnoringSafeArea(.all)
                }
            } else {
                withAnimation {
                    LocationsView()
                        .modelContainer(for: [SavedLocationSDModel.self])
                        .environmentObject(vm)
                }
            }
        }
    }
}

struct GradientOffsetModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    let animation: Animation

    func body(content: Content) -> some View {
        content.overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                        .red, .orange, .yellow, .green, .blue, .purple, .red
                    ]),
                startPoint: .leading,
                endPoint: .trailing
            )
                .mask(content)
                .offset(x: offset)
                .animation(animation.repeatForever(), value: offset) // Add repeatForever animation
        )
            .onAppear {
            withAnimation(animation) {
                self.offset = 1
            }
        }
    }
}

struct HandWiggleFillAnimation: View {
    @State private var rotationAngle = 0.0

    var body: some View {
        VStack {
            Image(systemName: "hand.wave.fill")
                .font(.system(size: 100))
                .foregroundColor(Color(red: 242 / 255, green: 207 / 255, blue: 201 / 255))
                .rotationEffect(.degrees(rotationAngle))
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
        }
            .onAppear {
            rotationAngle = 15.0
        }
    }
}

struct DelayedText: View {
    let text: String
    let delay: Double

    @State private var isShowing = false

    var body: some View {
        Text(text)
            .opacity(isShowing ? 1 : 0)
            .animation(.easeInOut(duration: 2.0)) // Increase duration for slower fade-in
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    self.isShowing = true
                }
            }
        }
    }
}

struct DelayedButton<Label>: View where Label: View {
    let delay: Double
    let action: () -> Void
    let label: () -> Label

    @State private var isShowing = false

    var body: some View {
        Button(action: action) {
            label()
        }
            .opacity(isShowing ? 1 : 0)
            .animation(.easeInOut(duration: 2.0)) // Increase duration for slower fade-in
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    self.isShowing = true
                }
            }
        }
    }
}
