//
//  HomeViewModel.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import Foundation

//class HomeViewModel {
//    
//    // Ambil informasi user (misal: nama atau token)
//    func getUserInfo() -> String {
//        // Misalnya kita ambil dari token
//        guard let accessToken = TokenManager.shared.getAccessToken() else {
//            return "No User Info"
//        }
//        return "Access Token: \(accessToken)"
//    }
//}

class HomeViewModel {
    private let apiClient = APIClient()
    var articles: [Article] = []
    var blogs: [Blog] = []
    var reports: [Report] = []

    func fetchArticles(completion: @escaping () -> Void) {
        apiClient.fetchArticles { result in
            switch result {
            case .success(let articlesData):
                self.articles = articlesData
            case .failure(let error):
                print("Error fetching articles: \(error)")
            }
            completion()
        }
    }

    func fetchBlogs(completion: @escaping () -> Void) {
        apiClient.fetchBlogs { result in
            switch result {
            case .success(let blogsData):
                self.blogs = blogsData
            case .failure(let error):
                print("Error fetching blogs: \(error)")
            }
            completion()
        }
    }

    func fetchReports(completion: @escaping () -> Void) {
        apiClient.fetchReports { result in
            switch result {
            case .success(let reportsData):
                self.reports = reportsData
            case .failure(let error):
                print("Error fetching reports: \(error)")
            }
            completion()
        }
    }
}
