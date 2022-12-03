//
//  ProjectsModel.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 29.10.2022.
//

import Foundation

final class ProjectsViewControllerModel {
    func getProjects() -> [Project] {
        return [
        Project(titleProject: "Shit", countRequests: 5),
        Project(titleProject: "kaka", countRequests: 15),
        Project(titleProject: "aye", countRequests: 55)
        ]
    }
}


