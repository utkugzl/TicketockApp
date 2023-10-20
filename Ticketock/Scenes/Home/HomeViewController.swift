//
//  HomeViewController.swift
//  Ticketock
//
//  Created by Utku Güzel on 2.10.2023.
//

import UIKit

enum Sections: Int {
    case trendingMovies = 0
    case topRatedMovies = 1
    case popularMovies = 2
}

final class HomeViewController: UIViewController {
    
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()
    
    let sectionTitles = ["Trending Movies","Top Rated Movies","Popular Movies"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // git test
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionViewTableViewCell.identifier, for: indexPath) as? HomeCollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            NetworkService.shared.getMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.topRatedMovies.rawValue:
            NetworkService.shared.getTopRatedMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.popularMovies.rawValue:
                NetworkService.shared.getPopularMovies { result in
                    switch result {
                    case .success(let movies):
                        cell.configure(with: movies.results)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

        default:
            return UITableViewCell()
        }
            
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.textColor = .red
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 10, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    
    

    
}



// MARK: - Configure UI

extension HomeViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        homeTableView.frame = view.bounds
        prepareTableView()

    }
    
    private func prepareTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(HomeCollectionViewTableViewCell.self, forCellReuseIdentifier: HomeCollectionViewTableViewCell.identifier)
    }
}

