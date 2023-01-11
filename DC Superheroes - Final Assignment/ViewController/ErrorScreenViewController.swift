//
//  ErrorScreenViewController.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 05/01/23.
//

import UIKit

class ErrorScreenViewController: UIViewController {
    
    private let ErrorUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ErrorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error-image")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let ErrorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "An error occurred, and \nSuperman is departing from the world."
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func applyConstraints(){
        
        let ErrorUIViewConstraints = [
            ErrorUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ErrorUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ErrorUIView.topAnchor.constraint(equalTo: view.topAnchor),
            ErrorUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ErrorUIView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ErrorUIView.heightAnchor.constraint(equalTo: view.heightAnchor)]
        
        let ErrorImageViewConstraints = [
            ErrorImageView.centerXAnchor.constraint(equalTo: ErrorUIView.centerXAnchor),
            ErrorImageView.centerYAnchor.constraint(equalTo: ErrorUIView.centerYAnchor),
            ErrorImageView.widthAnchor.constraint(equalToConstant: 200),
            ErrorImageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let ErrorLabelConstraints = [
            ErrorLabel.topAnchor.constraint(equalTo: ErrorImageView.bottomAnchor, constant: 24),
            ErrorLabel.widthAnchor.constraint(equalTo: ErrorUIView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(ErrorUIViewConstraints)
        NSLayoutConstraint.activate(ErrorImageViewConstraints)
        NSLayoutConstraint.activate(ErrorLabelConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ErrorUIView)
        ErrorUIView.addSubview(ErrorImageView)
        ErrorUIView.addSubview(ErrorLabel)
        applyConstraints()
        
    }
    
}
