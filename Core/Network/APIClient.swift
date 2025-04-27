//
//  APIClient.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import Foundation

class APIClient {

    // Base URL dari API
    private let baseURL = "https://api.spaceflightnewsapi.net/v4/"
    
    // Fungsi untuk membuat request umum
    private func makeRequest<T: Decodable>(_ urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Fungsi untuk mengambil artikel
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        makeRequest("articles", completion: completion)
    }

    // Fungsi untuk mengambil blog
    func fetchBlogs(completion: @escaping (Result<[Blog], Error>) -> Void) {
        makeRequest("blogs", completion: completion)
    }

    // Fungsi untuk mengambil laporan
    func fetchReports(completion: @escaping (Result<[Report], Error>) -> Void) {
        makeRequest("reports", completion: completion)
    }
}
