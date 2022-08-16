//
//  ScreenImageView.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/16.
//

import Foundation
import UIKit

final class ScreenImageView: UIScrollView {
    private let stackView: UIStackView = UIStackView()
    
    private let imageViewCornerRadius: CGFloat = 32
    private let stackViewSpacing: CGFloat = 10
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func update(model: ScreenImageViewModelProviding) {
        for imageData in model.screenImages {
            let image = UIImage(data: imageData)
            let imageView = UIImageView(image: image)
            
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = imageViewCornerRadius
            
            stackView.addArrangedSubview(imageView)
            invalidateIntrinsicContentSize()
        }
    }
    
    private func commonInit() {
        self.addSubview(stackView)
        
        stackView.spacing = stackViewSpacing
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollViewContstaints = [
            self.frameLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            self.frameLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            self.contentLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ]
        
        self.addConstraints(scrollViewContstaints)
    }
}
