import Alamofire
import Foundation

class AlamofireNetworkManager {
    
    static let shared = AlamofireNetworkManager()

    func getAssets(completion: @escaping ([Asset]?) -> Void) {
        let url = URL(string: "https://api.coincap.io/v2/assets/")!

        AF.request(url).response { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let assetsResponse = try decoder.decode(AssetsResponse.self, from: data)
                    completion(assetsResponse.data)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data")
                completion(nil)
            }
        }
    }
}

struct AssetsResponse: Codable {
    var data: [Asset]
}

struct Asset: Codable, Identifiable {
    let id: String
    let name: String
    let rank: String
    let priceUsd: String
}
