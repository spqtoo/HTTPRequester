//
//  CreateNewRequestStartHeaderCollectionView.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 13.11.2022.
//

import UIKit

final class CreateNewRequestStartHeaderCollectionView: UICollectionReusableView, IdentifiableProtocol {
    
    weak var switchStateDelegate: SwitchStateRequestForContextMenuProtocolDelegate?
    
    private let containerForViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageStateForRequest: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "terminal")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let labelNameOfRequest: UILabel = {
        let label = UILabel()
        label.text = "Untitled Request"
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageDetailedForRequest: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "ellipsis.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textFieldForURL: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = R.color.controllers_bg()
        textField.placeholder = "https://"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = R.color.detailText()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .default
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private func configureContainerForView() {
        containerForViews.addSubview(imageStateForRequest)
        containerForViews.addSubview(labelNameOfRequest)
        containerForViews.addSubview(imageDetailedForRequest)
        containerForViews.addSubview(textFieldForURL)
        
        textFieldForURL.delegate = self
//        textFieldForURL.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            
            imageStateForRequest.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 16),
            imageStateForRequest.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 4),
//            imageStateForRequest.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: -15),
            imageStateForRequest.heightAnchor.constraint(equalToConstant: 40),
            imageStateForRequest.widthAnchor.constraint(equalToConstant: 40),
            
            labelNameOfRequest.centerXAnchor.constraint(equalTo: containerForViews.centerXAnchor),
            labelNameOfRequest.centerYAnchor.constraint(equalTo: containerForViews.centerYAnchor, constant: -30),
//            labelNameOfRequest.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 70),

            
            imageDetailedForRequest.trailingAnchor.constraint(equalTo: containerForViews.trailingAnchor, constant: -16),
            imageDetailedForRequest.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 12),
//            imageDetailForRequest.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: 0),
            imageDetailedForRequest.heightAnchor.constraint(equalToConstant: 25),
            imageDetailedForRequest.widthAnchor.constraint(equalToConstant: 25),
            
            textFieldForURL.bottomAnchor.constraint(equalTo: containerForViews.bottomAnchor, constant: -16),
            textFieldForURL.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 8),
            textFieldForURL.trailingAnchor.constraint(equalTo: containerForViews.trailingAnchor, constant: -8),
//            textFieldForURL.topAnchor.constraint(equalTo: imageStateForRequest.bottomAnchor),
            textFieldForURL.heightAnchor.constraint(equalToConstant: 38)

        ])
    }
    
    private func configureHeader() {
        addSubview(containerForViews)
        configureContainerForView()
        
        let interaction = UIContextMenuInteraction(delegate: self)
        imageStateForRequest.addInteraction(interaction)
        
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

extension CreateNewRequestStartHeaderCollectionView: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                              previewProvider: nil,
                                              actionProvider: { [weak self]
                    suggestedActions in
            let getAction =
            UIAction(title: NSLocalizedString("GET", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "ladybug.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .base)
                self?.switchStateDelegate?.countSectionReload()
//                print(CreateNewQuickRequestViewController.stateRequest)
            }
            
            let postAction =
            UIAction(title: NSLocalizedString("POST", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "tortoise.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .detailed)
                self?.switchStateDelegate?.countSectionReload()
            }
            
            let putAction =
            UIAction(title: NSLocalizedString("PUT", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "hare.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .detailed)
                self?.switchStateDelegate?.countSectionReload()
            }
            
            let putchAction =
            UIAction(title: NSLocalizedString("PATCH", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "leaf.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .detailed)
                self?.switchStateDelegate?.countSectionReload()
            }
            
            let deleteAction =
            UIAction(title: NSLocalizedString("DELETE", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "ant.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .base)
                self?.switchStateDelegate?.countSectionReload()
            }
            
            let headAction =
            UIAction(title: NSLocalizedString("HEAD", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "pawprint.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .base)
                self?.switchStateDelegate?.countSectionReload()
            }
            
            let optionsAction =
            UIAction(title: NSLocalizedString("OPTIONS", comment: ""),
                     image: nil) { [weak self] action in
                self?.imageStateForRequest.image = UIImage(systemName: "flame.fill")
                self?.switchStateDelegate?.setupStateRequest(stateRequest: .detailed)
                self?.switchStateDelegate?.countSectionReload()
            }
                                                
                return UIMenu(title: "", children: [getAction, postAction, putAction, putchAction, deleteAction, headAction, optionsAction])
            })
    }
    
}

extension CreateNewRequestStartHeaderCollectionView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
