//
//  ViewController.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 02/01/23.
//

import UIKit
import ViewAnimator
import ANActivityIndicator

class DCSuperheroesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.separatorColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DCSuperheroesTableViewCell.self, forCellReuseIdentifier: DCSuperheroesTableViewCell.identifier)
        return table
    }()
    
    private var superHeroes = [SuperHeroes]()
    private var viewModals = [DCSuperheroesTableViewModal]()
    
    private func applyConstraintsToTableView(){
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DC COMICS"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        applyConstraintsToTableView()
        ANActivityIndicatorPresenter.shared.showIndicator(message: "Loading...",animationType: .lineScale)
        
        APICaller.shared.getDCSuperHeroesData{ [weak self] result in
            switch result{
            case .success(let superHeroes):
                self?.superHeroes = superHeroes
                self?.viewModals = superHeroes.compactMap({
                    DCSuperheroesTableViewModal(title: $0.title, likes: "Likes: \($0.likeCount ?? 0)", imageURL: URL(string: $0.imageUrl ?? ""))
                })
                DispatchQueue.main.async {
                    ANActivityIndicatorPresenter.shared.hideIndicator()
                    self?.tableView.reloadData()
                    let animation = AnimationType.from(direction: .bottom, offset: 500)
                    UIView.animate(views: (self?.tableView.visibleCells)!, animations: [animation], delay: 0.2, duration: 1)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    ANActivityIndicatorPresenter.shared.hideIndicator()
                    let ErrorScreenViewController = ErrorScreenViewController()
                    ErrorScreenViewController.modalPresentationStyle = .overFullScreen
                    self?.present(ErrorScreenViewController, animated: true, completion: nil)
                }
                print(error)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.tableView.reloadData()
    }
    
}

extension DCSuperheroesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DCSuperheroesTableViewCell.identifier, for: indexPath) as? DCSuperheroesTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 304
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextScreen = DCSuperHeroesDetailsViewController(with: viewModals[indexPath.row])
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

