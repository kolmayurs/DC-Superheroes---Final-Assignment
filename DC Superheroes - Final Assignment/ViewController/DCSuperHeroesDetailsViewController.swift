//
//  DCSuperHeroesDetailsViewController.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 06/01/23.
//

import UIKit

class DCSuperHeroesDetailsViewController: UIViewController {
    
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }
    
    private let DCSuperHeroesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "defaultBlackImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let DCSuperHeroesTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let DCSuperHeroesLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints(){
        
        let DCSuperHeroesImageViewConstraints = [
            DCSuperHeroesImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            DCSuperHeroesImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            DCSuperHeroesImageView.topAnchor.constraint(equalTo: view.topAnchor),
            DCSuperHeroesImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            DCSuperHeroesImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            DCSuperHeroesImageView.heightAnchor.constraint(equalTo: view.heightAnchor)]
        
        let DCSuperHeroesTitleLabelConstraints = [
            DCSuperHeroesTitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            DCSuperHeroesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            DCSuperHeroesTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor)]
        let DCSuperHeroesLikesLabelConstraints = [
            DCSuperHeroesLikesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            DCSuperHeroesLikesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            DCSuperHeroesLikesLabel.widthAnchor.constraint(equalTo: view.widthAnchor)]
        NSLayoutConstraint.activate(DCSuperHeroesImageViewConstraints)
        NSLayoutConstraint.activate(DCSuperHeroesTitleLabelConstraints)
        NSLayoutConstraint.activate(DCSuperHeroesLikesLabelConstraints)
        
    }
    
    init(with viewModel: DCSuperheroesTableViewModal){
        super.init(nibName: nil, bundle: nil)
        DCSuperHeroesTitleLabel.text = viewModel.title
        DCSuperHeroesLikesLabel.text = viewModel.likes
        
        let defaultImage = isDarkMode ? UIImage(named: "defaultWhiteImage") : UIImage(named: "defaultBlackImage")
        
        if let data = viewModel.imageData{
            DCSuperHeroesImageView.image = UIImage(data: data) ?? defaultImage
        }
        else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.DCSuperHeroesImageView.image = UIImage(data: data) ?? defaultImage
                }
            }.resume()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DCSuperHeroesImageView)
        addGradient()
        view.addSubview(DCSuperHeroesTitleLabel)
        view.addSubview(DCSuperHeroesLikesLabel)
        applyConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DCSuperHeroesImageView.frame = view.bounds
    }
    
    
}
