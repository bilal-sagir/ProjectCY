//
//
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 6.05.2022.
//
import Foundation

protocol NetworkServiceProtocol {
    func get<T: Decodable>(from endpoint: Int, completion: @escaping (T?, NetworkError?) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case custom(String?)
    case decoding(String?)
    case noData
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = Endpoints.RandomUserdotme.BaseUrl

    func get<T: Decodable>(from endpoint: Int, completion: @escaping (T?, NetworkError?) -> Void) {
        guard let url = URL(string: baseURL + "\(endpoint)") else {
            completion(nil, NetworkError.invalidURL)
            return
        }

        createDataTask(from: url, completion: completion).resume()
    }

    private func createDataTask<T: Decodable>(from url: URL, completion: @escaping (T?, NetworkError?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else {
                completion(nil, NetworkError.custom(error?.localizedDescription))
                return
            }

            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, NetworkError.decoding(error.localizedDescription))
            }
        }
    }
}
