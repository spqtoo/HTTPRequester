//
//  CreateNewRequestAnotherHeadersCollectionView.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 21.11.2022.
//

import UIKit

final class CreateNewRequestQueryParamsHeaderCollectionView: UICollectionReusableView, IdentifiableProtocol {
   
    private let containerForViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let labelNameOfSection: UILabel = {
        let label = UILabel()
        label.text = "Section №"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageDetailedForSection: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.color.detailText()
        return view
    }()
    
    private func configureContainerForView() {
        containerForViews.addSubview(labelNameOfSection)
        containerForViews.addSubview(imageDetailedForSection)
        containerForViews.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            
            labelNameOfSection.centerYAnchor.constraint(equalTo: containerForViews.centerYAnchor),
//            labelNameOfSection.centerYAnchor.constraint(equalTo: containerForViews.centerYAnchor, constant: -30),
            labelNameOfSection.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 16),

            
            imageDetailedForSection.trailingAnchor.constraint(equalTo: containerForViews.trailingAnchor, constant: -16),
//            imageDetailedForSection.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 0),
//            imageDetailForRequest.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: 0),
            imageDetailedForSection.centerYAnchor.constraint(equalTo: containerForViews.centerYAnchor),
            imageDetailedForSection.heightAnchor.constraint(equalToConstant: 25),
            imageDetailedForSection.widthAnchor.constraint(equalToConstant: 25),
            
            borderView.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: 0),
            borderView.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 16),
            borderView.trailingAnchor.constraint(equalTo: containerForViews.trailingAnchor, constant: -16),
            borderView.heightAnchor.constraint(equalToConstant: 0.5)

        ])
    }
    
    private func configureHeader() {
        addSubview(containerForViews)
        configureContainerForView()
        
        NSLayoutConstraint.activate([
            containerForViews.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerForViews.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerForViews.topAnchor.constraint(equalTo: self.topAnchor),
            containerForViews.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
