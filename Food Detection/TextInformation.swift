//
//  TextInformation.swift
//  Food Detection
//
//  Created by Eduardo Fornari on 12/04/18.
//  Copyright © 2018 Eduardo Fornari. All rights reserved.
//

import UIKit

class TextInformation: UIView {

    private var information = UILabel()

    private var heightConstraint: NSLayoutConstraint!

    private var cornerRadius: CGFloat = 5

    public var text: String = "" {
        didSet {
            self.heightConstraint.isActive = true
            if self.text != "" {
                self.heightConstraint.isActive = false
                self.information.text = self.text
            }
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.layer.cornerRadius = self.cornerRadius

        // Blur

        let prominentBlur = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurView = UIVisualEffectView(effect: prominentBlur)
        blurView.layer.cornerRadius = self.cornerRadius
        blurView.clipsToBounds = true

        self.addSubview(blurView)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true

        // Information

        self.addSubview(self.information)

        self.information.textAlignment = .center
        self.information.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.information.numberOfLines = 0
        self.information.translatesAutoresizingMaskIntoConstraints = false
        self.information.topAnchor.constraint(equalTo: self.topAnchor,
                                              constant: 5).isActive = true
        self.information.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                constant: -5).isActive = true
        self.information.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                 constant: -5).isActive = true

        self.information.leftAnchor.constraint(equalTo: self.leftAnchor,
                                               constant: 5).isActive = true

        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        self.heightConstraint.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Clear

    public func clear() {
        self.text = ""
    }

}
