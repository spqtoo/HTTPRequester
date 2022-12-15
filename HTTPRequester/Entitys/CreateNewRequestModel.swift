//
//  CreateNewRequestModel.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 07.12.2022.
//

import Foundation

struct KeyOfQueryParam: Hashable {
    let key: String
}

struct ValueOfQueryParam {
    let value: String
}

final class QueryParamCollectionViewCellModel {
    func getQueryParamForCell() -> [String : String] {
        return [
            "chair": "144",
            "id": "15839508902"
        ]
    }
}
