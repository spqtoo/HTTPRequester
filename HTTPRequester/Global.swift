//
//  Global.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 11.11.2022.
//

import UIKit

protocol IdentifiableProtocol {

    // MARK: - Properties

    static var identifier: String { get }
}

extension IdentifiableProtocol {

    // MARK: - Properties

    static var identifier: String {
        return String(describing: self)
    }

    static func create(for collection: UICollectionView, indexPath: IndexPath) -> Self {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Self
        return cell
    }

    static func create(for table: UITableView, indexPath: IndexPath) -> Self {
        let cell = table.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Self
        return cell
    }
}

enum StateRequest: Int {
    case base
    case detailed
    
    var countSections: Int {
        switch self {
        case .base:
            return 4
        case .detailed:
            return 5
        }
    }
}
