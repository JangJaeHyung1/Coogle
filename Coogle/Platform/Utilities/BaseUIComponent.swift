//
//  BaseTf.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//

import UIKit

class BaseTf: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = BaseColor.border.cgColor
        self.font = BaseFont.normal
        self.textColor = BaseColor.main
        self.addCharacterSpacing()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.smartDashesType = .no
        self.smartQuotesType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
    }
}

class BaseLbl: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 1
        self.textColor = BaseColor.sub
        self.font = BaseFont.subBold
        self.lineBreakMode = .byWordWrapping
        self.isUserInteractionEnabled = true
        self.addCharacterSpacing()
    }
}

class BaseTv: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = BaseColor.border.cgColor
        self.font = BaseFont.normal
        self.textColor = BaseColor.placeholder
        self.addCharacterSpacing()
        self.backgroundColor = .clear
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.smartDashesType = .no
        self.smartQuotesType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

class NextBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = BaseFont.bold
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsImageWhenHighlighted = false
        self.backgroundColor = BaseColor.btnColor
        self.layer.cornerRadius = 4
    }
}
