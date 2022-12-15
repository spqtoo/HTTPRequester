//
//  ProjectsModel.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 29.10.2022.
//

import Foundation

final class ProjectsViewControllerModel {
    func getProjects() -> [ProjectStruct] {
        return [
        ProjectStruct(titleProject: "Shit", countRequests: 5),
        ProjectStruct(titleProject: "kaka", countRequests: 15),
        ProjectStruct(titleProject: "aye", countRequests: 55)
        ]
    }
}

struct ProjectStruct {
    
    let titleProject: String
    let countRequests: Int
    
}
