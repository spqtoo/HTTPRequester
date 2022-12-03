//
//  CreateNewQuickRequestViewController.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 13.11.2022.
//

import UIKit

protocol SwitchStateRequestForContextMenuProtocolDelegate: AnyObject {
    func setupStateRequest(stateRequest value: StateRequest)
    func countSectionReload()
}

protocol ReloadedCollectionForAddParamOrHeaderProtocolDelegate: AnyObject {
    func addCellForCollectionViewAfterAddParam()
}


final class CreateNewQuickRequestViewController: UIViewController,
                                                    SwitchStateRequestForContextMenuProtocolDelegate,
                                                    ReloadedCollectionForAddParamOrHeaderProtocolDelegate {
    
    func addCellForCollectionViewAfterAddParam() {
        createRequestCollectionView.performBatchUpdates({
            let indexPath = IndexPath(row: massiveArray.count, section: 1)
            massiveArray.append(1) //add your object to data source first
            createRequestCollectionView.insertItems(at: [indexPath])
        }, completion: {  [weak self] _ in
            self?.createRequestCollectionView.reloadData()
            self?.view.setNeedsLayout()
            self?.view.layoutIfNeeded()
            print("Success reload data")
        })
    }
    
    func countSectionReload() { createRequestCollectionView.reloadData() }
       
    func setupStateRequest(stateRequest value: StateRequest) { self.stateRequest = value }
    
    private var stateRequest: StateRequest = .base
    
    private var massiveArray: [Int] = [4]
    
    
    private lazy var createRequestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 42, right: 0)
        layout.estimatedItemSize = CGSize(width: view.frame.size.width,
                                          height: 50)
        
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletctionView.register(CreateNewRequestCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CreateNewRequestCollectionViewCell.identifier)
        colletctionView.register(CreateNewRequestStartHeaderCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: CreateNewRequestStartHeaderCollectionView.identifier)
        colletctionView.register(CreateNewRequestAnotherHeadersCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: CreateNewRequestAnotherHeadersCollectionView.identifier)
        colletctionView.register(CreateNewRequestFooterCollectionView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: CreateNewRequestFooterCollectionView.identifier)
        colletctionView.delegate = self
        colletctionView.dataSource = self
        colletctionView.backgroundColor = .clear
        colletctionView.translatesAutoresizingMaskIntoConstraints = false
        return colletctionView
    }()
    
//    @objc func addCellFunc(_ sender: UITapGestureRecognizer) {
////        createRequestCollectionView.performBatchUpdates({
////            let indexPath = IndexPath(row: massiveArray.count, section: 0)
////            massiveArray.append(1) //add your object to data source first
////            createRequestCollectionView.insertItems(at: [indexPath])
////        }, completion: nil)
//        print("AYE")
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(collectionView: createRequestCollectionView)
//        view.resignFirstResponder()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massiveArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch stateRequest {
        case .base:
            return 3
        case .detailed:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateNewRequestCollectionViewCell.identifier,
                                                            for: indexPath)
                as? CreateNewRequestCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                               withReuseIdentifier: CreateNewRequestFooterCollectionView.identifier,
                                                                               for: indexPath)
                    as? CreateNewRequestFooterCollectionView else { return UICollectionReusableView() }
            
//            footer.addGest÷ureRecognizer(tapOnFooter)
            return footer
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
                                                                                          withReuseIdentifier: CreateNewRequestAnotherHeadersCollectionView.identifier,
                                                                                          for: indexPath)
                        as? CreateNewRequestAnotherHeadersCollectionView else { return UICollectionReusableView() }
                return defaultHeader
            }
        }
    }
    
    
}

extension CreateNewQuickRequestViewController: UICollectionViewDelegateFlowLayout{
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
        return CGSize(width: view.frame.size.width, height: 60)
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

