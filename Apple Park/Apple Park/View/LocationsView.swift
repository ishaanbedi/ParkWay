import SwiftUI
import MapKit
import SwiftData
struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var showDetails: Bool = false
    @State private var showSavedSheet = false
    @Environment(\.modelContext) private var context
    @State private var searchResult : [MKMapItem] = []
    @State private var selectedResult : MKMapItem?
    @State var position : MapCameraPosition = .automatic
    @State private var visible : MKCoordinateRegion?
    
    @Query(sort: \SavedLocationSDModel.name, order: .forward, animation: .spring) var savedLocations: [SavedLocationSDModel]
    
    var body: some View {
        ZStack {
            Map(position: $position,selection:$selectedResult){
                ForEach(vm.locations){ location in
                    Annotation(location.name,coordinate: location.coordinates,anchor: .bottom){
                        LocationMapAnnotationView()
                        
                    }
                    .annotationTitles(.visible)
                }
                ForEach(searchResult,id:\.self){ result in
                    Marker(item:result)
                }
            }
            .onMapCameraChange { context in
                visible = context.region
            }
            .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea(.all)
            VStack {
                VStack {
                    HStack{
                        Button {
                        } label: {
                            Text("\(vm.mapLocation.name)")
                                .foregroundColor(.primary)
                                .font(.title2)
                                .bold()
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .overlay(alignment: .leading) {
                                    Image(systemName: vm.showLocationsList ? "xmark" : "line.3.horizontal")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.all)
                                        .rotationEffect(Angle(degrees: vm.showLocationsList ? 90 : 0))
                                }
                                .onTapGesture {
                                    toggleList()
                                }
                                .overlay(alignment: .trailing) {
                                    Image(systemName: "heart.fill")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.all)
                                }
                                .onTapGesture {
                                    withAnimation {
                                        showSavedSheet.toggle()
                                    }
                                }
                        }
                        Button{
                            if let visible = visible {
                                search(location: visible)
                            }
                        }
                    label:{
                        Image(systemName: "magnifyingglass")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding([.trailing,.bottom,.top])
                    }

                    }
                        if (vm.showLocationsList) {
                            LocationsListView()
                        }
                    
                }
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding(.all)
                .frame(maxWidth: 700)
                Spacer()
                ZStack {
                    ForEach(vm.locations) { locationGot in
                        if vm.mapLocation == locationGot {
                            LocationPreviewView(location: locationGot,position:$position)
                                .shadow(color: .black.opacity(0.3), radius: 10)
                                .padding(.all)
                                .frame(maxWidth: 700)
                                .frame(maxWidth: .infinity)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
        .sheet(isPresented: $showSavedSheet) {
            VStack {
                if savedLocations.count == 0 {
                    Text("You don't have any saved places yet!")
                } else {
                    NavigationStack {
                        List {
                            ForEach(Array(Set(savedLocations)), id: \.self) { item in
                                NavigationLink(item.name) {
                                    Group {
                                        ScrollView {
                                            VStack(alignment: .leading) {
                                                TabView {
                                                    ForEach(item.imageNames, id: \.self) {
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
                                                    Text(item.name)
                                                        .font(.largeTitle)
                                                        .fontWeight(.black)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.all)
                                                
                                                Divider()
                                                    .padding(.horizontal)
                                                
                                                VStack(alignment: .leading) {
                                                    VStack(alignment: .leading) {
                                                        Text(item.descriptionText)
                                                            .font(.subheadline)
                                                            .foregroundColor(.secondary)
                                                    }
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                }
                                                .padding(.all)
                                            }
                                        }
                                        .background(.ultraThinMaterial)
                                        .ignoresSafeArea(.all)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Saved Places")
                    }
                }
            }
        }
    }
    func toggleList() {
        withAnimation(.easeInOut) {
            vm.showLocationsList = !vm.showLocationsList
        }
    }
    func search(location visible:MKCoordinateRegion){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Apple Store"
        request.resultTypes = .pointOfInterest
        request.region = visible
        Task{
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResult = response?.mapItems ?? []
        }
    }

}
