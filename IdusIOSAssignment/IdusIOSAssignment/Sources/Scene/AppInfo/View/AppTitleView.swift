//
//  AppTitleView.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/16.
//

import Foundation
import UIKit

final class AppTitleView: UIView {
    private let iconImageView: UIImageView = UIImageView()
    private let appNameLabel: UILabel = UILabel()
    
    private let iconImgaeViewHeight: CGFloat = 100
    private let iconImageViewCornerRadius: CGFloat = 24
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func update(model: AppTitleViewModelProviding) {
        iconImageView.image = UIImage(data: model.iconData)
        appNameLabel.text = model.name
    }
    
    private func commonInit() {
        self.addSubview(iconImageView)
        self.addSubview(appNameLabel)
        
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageViewCornerRadius
        
        configureLayouts()
    }
    
    private func configureLayouts() {
        let iconImageViewConstraints = [
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: iconImageView.layoutMargins.top),
            iconImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: iconImageView.layoutMargins.bottom),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: iconImageView.layoutMargins.left),
            iconImageView.heightAnchor.constraint(equalToConstant: iconImgaeViewHeight)
        ]
        let appNameLabelConstraints = [
            appNameLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: iconImageView.layoutMargins.right)
        ]
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(iconImageViewConstraints)
        self.addConstraints(appNameLabelConstraints)
    }
}
