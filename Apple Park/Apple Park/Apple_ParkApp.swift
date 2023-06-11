import SwiftUI
import SwiftData
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
                            Image(systemName: "sparkle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .symbolEffect(.pulse.byLayer)
                            Text("Apple Park Companion")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Text("Explore the Park")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding(.bottom, 30)
                            Button {
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
