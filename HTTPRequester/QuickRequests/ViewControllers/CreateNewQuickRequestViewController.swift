//
//  CreateNewQuickRequestViewController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 13.11.2022.
//

import UIKit

protocol GetTextForKeyAndValueFromCellProtocolDelegate: AnyObject {
    func getKeyFromTextField(keyTextField: String) -> String
    func getValueFromTextField(valueTextField: String) -> String
    
//    var keyValueData: (String, String) { get set }
}

protocol SwitchStateRequestForContextMenuProtocolDelegate: AnyObject {
    func setupStateRequest(stateRequest value: StateRequest)
    func countSectionReload()
}

protocol ReloadedCollectionForAddParamOrHeaderProtocolDelegate: AnyObject {
    func addCellForCollectionViewAfterAddParam()
}


final class CreateNewQuickRequestViewController: UIViewController {
    
    weak var getTextFromCellDelegate: GetTextForKeyAndValueFromCellProtocolDelegate?
    
    private var stateRequest: StateRequest = .base
    
    private var textFromKeyValueField = [String:String]()
    
    private let modelQueryParam = QueryParamCollectionViewCellModel()
    
    private var queryParams = [String: String]()
    
    private lazy var createRequestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 42, right: 0)
        layout.estimatedItemSize = CGSize(width: view.frame.size.width,
                                          height: 50)
        
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //Cells
        colletctionView.register(CreateNewRequestCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CreateNewRequestCollectionViewCell.identifier)
        colletctionView.register(UICollectionViewCell.self,
                                 forCellWithReuseIdentifier: "cell")
        
        //Headers
        colletctionView.register(CreateNewRequestStartHeaderCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: CreateNewRequestStartHeaderCollectionView.identifier)
        colletctionView.register(CreateNewRequestQueryParamsHeaderCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: CreateNewRequestQueryParamsHeaderCollectionView.identifier)
        
        //Footers
        colletctionView.register(CreateNewRequestQueryParamsFooterCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: CreateNewRequestQueryParamsFooterCollectionView.identifier)
        colletctionView.register(CreateNewRequestHeadersParamsFooterCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: CreateNewRequestHeadersParamsFooterCollectionView.identifier)
        colletctionView.register(UICollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: "footer")
        colletctionView.delegate = self
        colletctionView.dataSource = self
        colletctionView.backgroundColor = .clear
        colletctionView.translatesAutoresizingMaskIntoConstraints = false
        return colletctionView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView(collectionView: createRequestCollectionView)
        queryParams = modelQueryParam.getQueryParamForCell()
        
    }
    
    private func configureView(collectionView: UICollectionView) {
        view.backgroundColor = R.color.controllers_bg()
        
        view.addSubview(collectionView)

        
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
}

extension CreateNewQuickRequestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return queryParams.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return stateRequest.countSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateNewRequestCollectionViewCell.identifier,
                                                                for: indexPath)
                    as? CreateNewRequestCollectionViewCell else { return UICollectionViewCell() }
            print(textFromKeyValueField.keys)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            switch indexPath.section {
            case 0:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                             withReuseIdentifier: "footer",
                                                                             for: indexPath)
                return footer
            case 1:
                guard let queryParamsFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                   withReuseIdentifier: CreateNewRequestQueryParamsFooterCollectionView.identifier,
                                                                                   for: indexPath)
                        as? CreateNewRequestQueryParamsFooterCollectionView else { return UICollectionReusableView() }
                queryParamsFooter.addParamVCDelegate = self
    //            footer.addGest÷ureRecognizer(tapOnFooter)
                return queryParamsFooter
            default:
                guard let headersParamsFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                   withReuseIdentifier: CreateNewRequestHeadersParamsFooterCollectionView.identifier,
                                                                                   for: indexPath)
                        as? CreateNewRequestHeadersParamsFooterCollectionView else { return UICollectionReusableView() }
//                headersParamsFooter.addParamDelegate = self
                return headersParamsFooter
            }
        } else {
            switch indexPath.section {
            case 0:
                guard let startHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                        withReuseIdentifier: CreateNewRequestStartHeaderCollectionView.identifier,
                                                                                        for: indexPath)
                        as? CreateNewRequestStartHeaderCollectionView else { return UICollectionReusableView() }
                startHeader.switchStateDelegate = self
                return startHeader
            default:
                guard let defaultHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                          withReuseIdentifier: CreateNewRequestQueryParamsHeaderCollectionView.identifier,
                                                                                          for: indexPath)
                        as? CreateNewRequestQueryParamsHeaderCollectionView else { return UICollectionReusableView() }
                return defaultHeader
            }
        }
    }
}

extension CreateNewQuickRequestViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: view.frame.size.width, height: 105)
        default:
            return CGSize(width: view.frame.size.width, height: 40)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: view.frame.size.width, height: 0)
        default:
            return CGSize(width: view.frame.size.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.size.width, height: 0)
        default:
            return CGSize(width: view.frame.size.width, height: 0)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
//    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

}

extension CreateNewQuickRequestViewController: SwitchStateRequestForContextMenuProtocolDelegate,
                                               ReloadedCollectionForAddParamOrHeaderProtocolDelegate,
                                               GetTextForKeyAndValueFromCellProtocolDelegate {
    
    func getKeyFromTextField(keyTextField: String) -> String {
        return keyTextField
    }
    
    func getValueFromTextField(valueTextField: String) -> String {
        return valueTextField
    }
    
//    var keyValueData: (String, String) {
//        get {
//
//        }
//        set {
//            self.keyValueData = (getKeyFromTextField(keyTextField: <#T##String#>), getValueFromTextField(valueTextField: <#T##String#>))
//        }
//    }
    
    func countSectionReload() { createRequestCollectionView.reloadData() }
       
    func setupStateRequest(stateRequest value: StateRequest) { self.stateRequest = value }
    
    func addCellForCollectionViewAfterAddParam() {
        
//        guard let delegateCell = self.getTextFromCellDelegate else { fatalError() }
//        queryParams.updateValue(delegateCell.getValueFromTextField(), forKey: delegateCell.getKeyFromTextField())
        print(textFromKeyValueField.keys, ": aye", textFromKeyValueField.values)
        createRequestCollectionView.performBatchUpdates({ [weak self] in
//            CATransaction.begin()
//            CATransaction.setDisableActions(true)
            
//            queryExtParams = queryParams
//            queryExtParams.updateValue(ValueOfQueryParam(value: "58390029"), forKey: KeyOfQueryParam(key: "head")) //add your object to data source first
//            let indexPath = IndexPath(item: queryParams.count - 1, section: 1)
//            self?.createRequestCollectionView.insertItems(at: [indexPath])
            self?.createRequestCollectionView.reloadData()
//            CATransaction.commit()
        }, completion: nil)
    }
}
enum WhatAddToRequestEnum {
    case queryParam
    case detailedParam
    case header
}
