import SwiftUI
import MapKit

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @Binding var position : MapCameraPosition
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                    withAnimation(){
                        position = .region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.0075, longitudeDelta: 0.0075)))
                    }
                } label: {
                    HStack {
                        if let imageName = location.imageNames.first {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .cornerRadius(20)
                        }
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}

//struct LocationsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationsListView()
//            .environmentObject(LocationsViewModel())
//    }
//}
