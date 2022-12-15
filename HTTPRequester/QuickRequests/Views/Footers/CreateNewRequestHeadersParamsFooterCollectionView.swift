//
//  HeadersParamsFooterCollectionView.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 06.12.2022.
//

import UIKit

final class CreateNewRequestHeadersParamsFooterCollectionView: UICollectionReusableView, IdentifiableProtocol {
   
//    weak var addParamDelegate: ReloadedCollectionForAddParamOrHeaderProtocolDelegate?
    
    private let containerForViews: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageForLabelOfAddParam: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "link.badge.plus")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelOfAddParamOrHeader: UILabel = {
        let label = UILabel()
        label.text = "Добавить параметр"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc
    func addCellFromFooter(_ sender: UITapGestureRecognizer) {
//        print("try to unwrap")
//        guard let delegate = self.addParamDelegate else { fatalError() }
//        delegate.addCellForCollectionViewAfterAddParam(whatAdd: .queryParam)
        print("After Delegate Func")
    }
    
    private func configureContainerForView() {
        containerForViews.addSubview(imageForLabelOfAddParam)
        containerForViews.addSubview(labelOfAddParamOrHeader)
                
        NSLayoutConstraint.activate([
            imageForLabelOfAddParam.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 16),
            imageForLabelOfAddParam.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 4),
 
            labelOfAddParamOrHeader.topAnchor.constraint(equalTo: containerForViews.topAnchor, constant: 4),
            labelOfAddParamOrHeader.leadingAnchor.constraint(equalTo: containerForViews.leadingAnchor, constant: 48)
        ])
    }
    
    private func configureFooter() {
        addSubview(containerForViews)
        configureContainerForView()
        
        let tapOnFooter = UITapGestureRecognizer(target: self, action: #selector(addCellFromFooter(_:)))
        containerForViews.addGestureRecognizer(tapOnFooter)
        
        NSLayoutConstraint.activate([
            containerForViews.widthAnchor.constraint(equalTo: labelOfAddParamOrHeader.widthAnchor, multiplier: 1.5),
            containerForViews.heightAnchor.constraint(equalTo: imageForLabelOfAddParam.heightAnchor, multiplier: 1)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
