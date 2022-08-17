//
//  AppInformationStackView.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/17.
//

import Foundation
import UIKit

final class AppInformationStackView: UIStackView {
    private class AppInformationView: UIView {
        private let titleLabel = UILabel()
        private let descriptionLabel = UILabel()
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        func update(model: AppInformationViewModelProviding) {
            titleLabel.text = model.title
            descriptionLabel.text = model.description
        }
        
        private func commonInit() {
            let titleLabelConstraints = [
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ]
            let descriptionLabelConstraints = [
                descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor),
                descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(titleLabel)
            self.addSubview(descriptionLabel)
            self.addConstraints(titleLabelConstraints)
            self.addConstraints(descriptionLabelConstraints)
        }
    }
    
    func update(models: [AppInformationViewModelProviding]) {
        for model in models {
            let appInfoView = AppInformationView()
            
            appInfoView.update(model: model)
            
            self.addArrangedSubview(appInfoView)
        }
    }
}
