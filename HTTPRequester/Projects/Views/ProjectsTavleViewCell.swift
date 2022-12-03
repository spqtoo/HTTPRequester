//
//  ProjectsTavleViewCell.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 29.10.2022.
//

import UIKit

final class ProjectsTableViewCell: UITableViewCell, IdentifiableProtocol {
    
    private let containerForView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleForCell: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17)
        title.textColor = R.color.textColor()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Aye proj"
        return title
    }()
    
    private let subtitleForCell: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont.systemFont(ofSize: 12)
        subtitle.textColor = R.color.detailText()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.text = "14"
        return subtitle
    }()
    
    private let imageForCell: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "folder"))
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerForView(container view: UIView) {
        view.backgroundColor = .clear
        
        view.addSubview(imageForCell)
        view.addSubview(titleForCell)
        view.addSubview(subtitleForCell)
        
        NSLayoutConstraint.activate([
            imageForCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            imageForCell.topAnchor.constraint(equalTo: view.topAnchor),
            imageForCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleForCell.leadingAnchor.constraint(equalTo: imageForCell.trailingAnchor, constant: 16),
            titleForCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            
            subtitleForCell.topAnchor.constraint(equalTo: titleForCell.bottomAnchor, constant: 8),
            subtitleForCell.leadingAnchor.constraint(equalTo: imageForCell.trailingAnchor, constant: 16),
            subtitleForCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)

        ])
    }
    
    private func configureCell() {
        configureContainerForView(container: containerForView)
        contentView.addSubview(containerForView)
        
        NSLayoutConstraint.activate([
            containerForView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerForView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerForView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerForView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setDataInProjectsCell(title: String, countRequests subtitle: Int) {
        titleForCell.text = title
        subtitleForCell.text = "\(subtitle)" + " requests"
    }
    

}
