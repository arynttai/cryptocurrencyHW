import SwiftUI

struct CryptocurrencyTableViewCell: View {
    let asset: Asset
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(asset.name)
                .font(.headline)
            Text("Rank: \(asset.rank)")
            Text("Price: \(asset.priceUsd)")
        }
        .padding()
    }
}
