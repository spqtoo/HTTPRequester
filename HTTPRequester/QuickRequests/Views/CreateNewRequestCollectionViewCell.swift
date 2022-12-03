//
//  CreateNewRequestCollectionViewCell.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 28.11.2022.
//

import UIKit

final class CreateNewRequestCollectionViewCell: UICollectionViewCell, IdentifiableProtocol {
    
    
    private let containerForViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageStateForRequest: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let textFieldForKey: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = R.color.controllers_bg()
        textField.placeholder = "Key"
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = R.color.detailText()
        textField.borderStyle = .none
        textField.returnKeyType = .default
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.becomeFirstResponder()
        return textField
    }()
    
    private let textFieldForValue: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = R.color.controllers_bg()
        textField.placeholder = "Value"
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = R.color.detailText()
        textField.borderStyle = .none
        textField.returnKeyType = .default
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private func configureContainerForView() {
        containerForViews.addSubview(imageStateForRequest)
        containerForViews.addSubview(textFieldForKey)
        containerForViews.addSubview(textFieldForValue)
        
//        textFieldForURL.delegate = self
//        textFieldForURL.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            
            imageStateForRequest.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 16),
            imageStateForRequest.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 4),
//            imageStateForRequest.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: -15),
            imageStateForRequest.heightAnchor.constraint(equalToConstant: 25),
            imageStateForRequest.widthAnchor.constraint(equalToConstant: 25),
            
            textFieldForKey.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: 0),
            textFieldForKey.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 0),
            textFieldForKey.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 48),
//            textFieldForURL.topAnchor.constraint(equalTo: imageStateForRequest.bottomAnchor),
            textFieldForKey.heightAnchor.constraint(equalToConstant: 38),
            textFieldForKey.widthAnchor.constraint(equalToConstant: 135),

            
            textFieldForValue.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: 0),
            textFieldForValue.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 0),
            textFieldForValue.trailingAnchor.constraint(equalTo: containerForViews.trailingAnchor, constant: -16),
//            textFieldForValue.leadingAnchor.constraint(equalTo: textFieldForKey.trailingAnchor, constant: 6),
//            textFieldForURL.topAnchor.constraint(equalTo: imageStateForRequest.bottomAnchor),
            textFieldForValue.heightAnchor.constraint(equalToConstant: 38),
            textFieldForValue.widthAnchor.constraint(equalTo: textFieldForKey.widthAnchor, multiplier: 1.38)
        ])
    }
    
    private func configureCell(){
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
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
