//
//  ListMovieViewController.swift
//  MovieVIP
//
//  Created by Tifo Audi Alif Putra on 12/12/20.
//

import UIKit

protocol ListMovieDisplayLogic: AnyObject {
    func displayMovies(movie: [Movie])
    func displayErrorMessage(error: ErrorResponse)
}

class ListMovieViewController: UITableViewController {
    
    private var movies: [Movie] = []
    
    var interactor: ListMovieDataLogic?
    
    enum TableViewState {
        case empty
        case loading
        case error
        case populated
    }
    
    var state: TableViewState = .empty {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.fetchMovies()
    }
    
    private func setup() {
        let viewController = self
        let interactor = ListMovieInteractor()
        let presenter = ListMoviePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func setupView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(ListMovieCell.self, forCellReuseIdentifier: ListMovieCell.cellIdentifier)
        self.tableView.separatorStyle = .none
        
        self.view.backgroundColor = .white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .populated:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCell.cellIdentifier, for: indexPath) as! ListMovieCell
            cell.movie = movies[indexPath.row]
            return cell
        case .empty:
            // define cell for showing empty state
            return UITableViewCell()
        case .error:
            // define cell for showing error state
            return UITableViewCell()
        case .loading:
            // define cell for showing loading state
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

extension ListMovieViewController: ListMovieDisplayLogic {
    
    func displayMovies(movie: [Movie]) {
        self.movies = movie
        self.state = movie.isEmpty ? .empty : .populated
    }
    
    func displayErrorMessage(error: ErrorResponse) {
        self.state = .error
        print("error message \(error.rawValue)")
        // display error state view here
    }
}
