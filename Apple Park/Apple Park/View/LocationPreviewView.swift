import SwiftUI
import SwiftData
import MapKit

struct LocationPreviewView: View {
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var isSaveButtonDisabled = false
    @State private var saveButtonText = "Save"
    @Environment(\.modelContext) private var context
    @Query(sort: \SavedLocationSDModel.name, order: .forward, animation: .spring) var savedLocations: [SavedLocationSDModel]
    @Binding var position : MapCameraPosition
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    if let imageName = location.imageNames.first {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                            .onTapGesture {
                            vm.sheetLocation = location
                        }
                        Spacer()
                    }
                }
                    .padding(5)
                    .background(.ultraThickMaterial)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title2)
                        .bold()
                }
            }

            Button {
                vm.sheetLocation = location
                withAnimation(){
                    position = .region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075)))
                }
            } label: {
                Text("Know More")
                    .font(.headline)
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
            }
                .buttonStyle(.borderedProminent)

            HStack {
                Button {
                    vm.nextButtonPressed()
                    withAnimation(){
                        position = .region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075)))
                    }
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(height: 35)
                        .frame(maxWidth: .infinity)
                }
                    .buttonStyle(.bordered)
            }
        }
            .frame(maxWidth: .infinity)
            .padding(.all)
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
            .clipped()
            .cornerRadius(10)
    }


}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
