//
//  DescriptionView.swift
//  IdusIOSAssignment
//
//  Created by Oh Donggeon on 2022/08/16.
//

import Foundation
import UIKit

final class DescriptionView: UIView {
    private let textView = UITextView()
    private let moreButton = UIButton(type: .system)
    
    private let maximumNumberOfLines = 3
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func update(model: DescriptionViewModelProviding) {
        textView.text = model.description
    }
    
    private func commonInit() {
        self.addSubview(textView)
        self.addSubview(moreButton)
        
        configureTextView()
        configureMoreButton()
        configureConstraints()
    }
    
    private func configureTextView() {
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    private func configureMoreButton() {
        moreButton.setTitle(LocalString.showMore, for: .normal)
        moreButton.setTitle(LocalString.showLess, for: .selected)
        moreButton.setTitleColor(.systemBlue, for: .normal)
        moreButton.setTitleColor(.systemBlue, for: .selected)
        moreButton.tintColor = .clear
        
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        
        moreButton.addTarget(self, action: #selector(moreButtonTouched), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        let textViewConstraints = [
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        let moreButtonConstraints = [
            moreButton.topAnchor.constraint(equalTo: textView.bottomAnchor),
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.layoutMargins.right),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.layoutMargins.bottom)
        ]
        
        self.addConstraints(textViewConstraints)
        self.addConstraints(moreButtonConstraints)
    }
    
    @objc private func moreButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let maximumNumberOfLines = sender.isSelected ? .zero : maximumNumberOfLines
        
        textView.textContainer.maximumNumberOfLines = maximumNumberOfLines
        textView.invalidateIntrinsicContentSize()
    }
}
