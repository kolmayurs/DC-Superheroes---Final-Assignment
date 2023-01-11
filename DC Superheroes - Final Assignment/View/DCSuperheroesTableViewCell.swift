//
//  DCTableViewCell.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 02/01/23.
//

import UIKit

class DCSuperheroesTableViewCell: UITableViewCell {
    
    static let identifier = "DCSuperheroesTableViewCell"
    
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        else {
            return false
        }
    }
    
    private let DCSuperheroesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let DCSuperheroesTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let DCSuperheroesLikesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func applyConstraints(){
        
        let DCSuperheroesImageViewConstraints = [
            DCSuperheroesImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            DCSuperheroesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            DCSuperheroesImageView.widthAnchor.constraint(equalToConstant: 160),
            DCSuperheroesImageView.heightAnchor.constraint(equalToConstant: 240),
        ]
        
        let DCSuperheroesTitleLabelConstraints = [
            DCSuperheroesTitleLabel.leadingAnchor.constraint(equalTo: DCSuperheroesImageView.trailingAnchor, constant: 24),
            DCSuperheroesTitleLabel.topAnchor.constraint(equalTo: DCSuperheroesImageView.centerYAnchor, constant: -24)
        ]
        
        let DCSuperheroesLikesLabelConstraints = [
            DCSuperheroesLikesLabel.leadingAnchor.constraint(equalTo: DCSuperheroesImageView.trailingAnchor, constant: 24),
            DCSuperheroesLikesLabel.topAnchor.constraint(equalTo: DCSuperheroesTitleLabel.topAnchor, constant: 24)
        ]
        
        NSLayoutConstraint.activate(DCSuperheroesImageViewConstraints)
        NSLayoutConstraint.activate(DCSuperheroesTitleLabelConstraints)
        NSLayoutConstraint.activate(DCSuperheroesLikesLabelConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(DCSuperheroesImageView)
        contentView.addSubview(DCSuperheroesTitleLabel)
        contentView.addSubview(DCSuperheroesLikesLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        contentView.layer.borderColor = isDarkMode ? UIColor.white.cgColor : UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        applyConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        DCSuperheroesTitleLabel.text = nil
        DCSuperheroesLikesLabel.text = nil
        DCSuperheroesImageView.image = nil
        contentView.layer.borderColor = nil
    }
    
    func configure(with viewModel: DCSuperheroesTableViewModal){
        DCSuperheroesTitleLabel.text = viewModel.title
        DCSuperheroesLikesLabel.text = viewModel.likes
        
        let defaultImage = isDarkMode ? UIImage(named: "defaultWhiteImage") : UIImage(named: "defaultBlackImage")
        
        if let data = viewModel.imageData{
            DCSuperheroesImageView.image = UIImage(data: data) ?? defaultImage
        }
        else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.DCSuperheroesImageView.image = UIImage(data: data) ?? defaultImage
                }
            }.resume()
        }
        
    }
    
}
