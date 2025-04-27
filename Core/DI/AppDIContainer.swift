//
//  AppDIContainer.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import Swinject

final class AppDIContainer {
    static let shared = AppDIContainer()
    let container = Container()

    private init() {
        registerDependencies()
    }

    private func registerDependencies() {
        // contoh: container.register(ArticleRepository.self) { _ in DefaultArticleRepository() }
    }
}
