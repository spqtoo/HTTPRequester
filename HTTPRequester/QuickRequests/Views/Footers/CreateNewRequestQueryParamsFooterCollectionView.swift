//
//  CreateNewRequestFooterCollectionView.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 28.11.2022.
//

import UIKit

final class CreateNewRequestQueryParamsFooterCollectionView: UICollectionReusableView, IdentifiableProtocol {
    
    weak var addParamVCDelegate: ReloadedCollectionForAddParamOrHeaderProtocolDelegate?
    
//    weak var getTextFromCellDelegate: GetTextForKeyAndValueFromCellProtocolDelegate?
    
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
        guard let delegateVC = self.addParamVCDelegate else { fatalError() }
//        guard let delegateCell = self.getTextFromCellDelegate else { fatalError() }
        delegateVC.addCellForCollectionViewAfterAddParam()
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

//protocol A_Protocol: AnyObject {
//
//    func example(_ value: String)
//}
//
//class A: UIViewController, A_Protocol {
//
//    var value: String = "a_value"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemGreen
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let controller = B()
//        controller.delegate = self
//        present(controller, animated: true)
//    }
//
//    func example(_ value: String) {
//        self.value = value
//        print("example", value)
//    }
//}
//
//class SomeVC: UIViewController, A_Protocol {
//
//    var value: String = "some_value"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemPurple
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let controller = B()
//        controller.delegate = self
//        present(controller, animated: true)
//    }
//
//    func example(_ value: String) {
//        self.value = value
//        print("example", value)
//    }
//}
//
//class B: UIViewController {
//
//    weak var delegate: A_Protocol?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemYellow
//        delegate?.example("b_value")
//    }
//}
