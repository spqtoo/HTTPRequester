//
//  QuickRequestTableViewHeader.swift
//  HTTPRequester
//
//  Created by Степан Соловьёв on 11.11.2022.
//

import UIKit

final class QuickRequestTableViewCreateRequestCell: UITableViewCell, IdentifiableProtocol {
    
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
        title.text = "Create new HTTP request"
        return title
    }()
    
    private let imageForCell: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "plus.diamond"))
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func configureContainerForView(container view: UIView) {
        view.backgroundColor = .clear
        view.addSubview(imageForCell)
        view.addSubview(titleForCell)
        
        NSLayoutConstraint.activate([
            imageForCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            imageForCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageForCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageForCell.heightAnchor.constraint(equalToConstant: 45),
            imageForCell.widthAnchor.constraint(equalToConstant: 45),
            
            titleForCell.leadingAnchor.constraint(equalTo: imageForCell.leadingAnchor, constant: 64),
            titleForCell.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleForCell.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)

        ])
        
    }
    
    private func configureHeader() {
        configureContainerForView(container: containerForView)
        contentView.addSubview(containerForView)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            containerForView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerForView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerForView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerForView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerForView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
