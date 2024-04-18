import SwiftUI

struct ContentView: View {
    @State private var assets: [Asset] = []
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $search)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(filterAssets) { asset in
                    NavigationLink(destination: VStack {
                        Text("Name: \(asset.name)")
                        Text("Rank: \(asset.rank)")
                        Text("Price: \(asset.priceUsd)")
                        
                    }) {
                        CryptocurrencyTableViewCell(asset: asset)
                    }
                }
            }
            .onAppear {
                fetchAssets()
            }
        }
    }
    
    private var filterAssets: [Asset] {
        if search.isEmpty {
            return assets
        } else {
            return assets.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
    }
    
    private func fetchAssets() {
        AlamofireNetworkManager.shared.getAssets { fetchedAssets in
            if let fetchedAssets = fetchedAssets {
                self.assets = fetchedAssets
            } else {
                print("Failed to fetch assets")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
