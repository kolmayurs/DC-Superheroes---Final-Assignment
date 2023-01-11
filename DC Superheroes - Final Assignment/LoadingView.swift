//
//  LoadingView.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 06/01/23.
//

import UIKit

class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
