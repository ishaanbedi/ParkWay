import SwiftUI
import MapKit
import SwiftData
struct LocationDetailView: View {
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var isSaveButtonDisabled = false
    @State private var saveButtonText = "Save as favorite"
    @State private var showingAlert = false
    @State private var note = ""
    @Environment(\.modelContext) private var context
    @Query(sort: \SavedLocationSDModel.name, order: .forward, animation: .spring) var savedLocations: [SavedLocationSDModel]
    @State private var position: MapCameraPosition = .automatic
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TabView {
                    ForEach(location.imageNames, id: \.self) {
                        Image($0)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width)
                            .clipped()
                    }
                }
                    .frame(height: 500)
                    .tabViewStyle(PageTabViewStyle())
                    .ignoresSafeArea(.all)

                VStack(alignment: .center) {
                    Text(location.name)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)

                Divider()
                    .padding(.horizontal)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(location.descriptionText)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .padding(.all)

                Map(position: $position) {
                    Annotation("", coordinate: location.coordinates) {
                        LocationMapAnnotationView()
                            .shadow(radius: 10)
                    }
                }
                    .onAppear {
//                    position = .region(locationRegionLocal)
                    position = .camera(
                        MapCamera(centerCoordinate: location.coordinates, distance: 980, heading: 242, pitch: 60))
                }

                    .allowsHitTesting(false)
                    .aspectRatio(2, contentMode: .fit)
                    .cornerRadius(30)
                    .padding(.all)

                HStack {

                    Button {
//                        for i in 0...savedLocations.count - 1 {
//                            context.delete(savedLocations[i])
//                        }
//                        saveButtonAction()
                        showingAlert.toggle()
                    } label: {
                        Text("Save as Favorite Location")
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                        .padding(.all)
                        .alert("Add a note", isPresented: $showingAlert) {
                        TextField("Great place...:", text: $note)
                        Button("Submit") {
                            saveButtonAction()
                        }
                    } message: {
                        Text("How do you feel about \(location.name)")
                    }

                }
                    .padding(.all)
            }
        }
            .background(.ultraThinMaterial)
            .ignoresSafeArea(.all)
            .overlay(alignment: .topTrailing) {
            Button {
                vm.sheetLocation = nil
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(.all)
                    .foregroundColor(.primary)
                    .background(.thinMaterial)
                    .cornerRadius(100)
                    .shadow(radius: 10)
                    .padding(.all)
            }
        }
    }

    private func saveButtonAction() {
        let locationToSave = SavedLocationSDModel(name: location.name, descriptionText: location.descriptionText, imageNames: location.imageNames, notes: note)
        for i in savedLocations {
            if (i.name == locationToSave.name) {
                return
            }
        }
        context.insert(locationToSave)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
