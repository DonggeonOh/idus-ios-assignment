//
//  SearchTableViewCell.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/13.
//

import Foundation
import UIKit

final class SearchTableViewCell: UITableViewCell {
    private var appIDLabel = UILabel()
    private var appNameLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayouts()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayouts()
    }
    
    func update(cellData: SearchViewModelData?) {
        appIDLabel.text = cellData?.id
        appNameLabel.text = cellData?.name
    }
    
    private func configureLayouts() {
        let appNameLabelConstraints = [
            appNameLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            appNameLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.layoutMarginsGuide.topAnchor),
            appNameLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor)
        ]
        let appIDLabelConstraints = [
            appIDLabel.leadingAnchor.constraint(greaterThanOrEqualTo: appNameLabel.layoutMarginsGuide.leadingAnchor, constant: appNameLabel.layoutMargins.right),
            appIDLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            appIDLabel.centerYAnchor.constraint(equalTo: appNameLabel.centerYAnchor)
        ]
        configureLayout(view: appNameLabel, constraints: appNameLabelConstraints)
        configureLayout(view: appIDLabel, constraints: appIDLabelConstraints)
    }
    
    private func configureLayout(view: UIView, constraints: [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(view)
        self.contentView.addConstraints(constraints)
    }
}
