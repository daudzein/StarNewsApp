//
//  HomeViewController.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setup Greeting
        setupGreeting()
        
        // Setup ScrollView and StackView
        setupScrollView()
        
        // Fetch Data
        fetchData()
    }

    private func setupGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        var greeting = "Good Morning"
        
        if hour >= 12 && hour < 17 {
            greeting = "Good Afternoon"
        } else if hour >= 17 {
            greeting = "Good Evening"
        }
        
        let greetingLabel = UILabel()
        greetingLabel.text = greeting
        greetingLabel.font = .systemFont(ofSize: 24)
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        viewModel.fetchArticles {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        viewModel.fetchBlogs {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        viewModel.fetchReports {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.populateSections()
        }
    }

    private func populateSections() {
        addSection(title: "Articles", items: viewModel.articles)
        addSection(title: "Blogs", items: viewModel.blogs)
        addSection(title: "Reports", items: viewModel.reports)
    }

    private func addSection(title: String, items: [Any]) {
        let sectionTitle = UILabel()
        sectionTitle.text = title
        sectionTitle.font = .boldSystemFont(ofSize: 20)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let seeMoreButton = UIButton(type: .system)
        seeMoreButton.setTitle("See More", for: .normal)
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 8
        sectionStack.translatesAutoresizingMaskIntoConstraints = false
        
        for item in items {
            if let article = item as? Article {
                let itemView = createItemView(title: article.title, imageUrl: article.imageUrl)
                sectionStack.addArrangedSubview(itemView)
            }
        }

        stackView.addArrangedSubview(sectionTitle)
        stackView.addArrangedSubview(sectionStack)
        stackView.addArrangedSubview(seeMoreButton)
    }

    private func createItemView(title: String, imageUrl: String) -> UIView {
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.loadImage(from: imageUrl)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
}

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

