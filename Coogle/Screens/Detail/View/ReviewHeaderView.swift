//
//  ReviewHeaderView.swift
//  Coogle
//
//  Created by jh on 2022/11/27.
//

import UIKit

class ReviewHeaderView: UIView {
    let reviewNumLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.btnColor
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "20개"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()

    private let reviewGuideLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.detailTitle
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "의 리뷰가 있습니다"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(reviewNumLbl)
        addSubview(reviewGuideLbl)
        
        setConstraints()
    }
    
    private func setConstraints() {
        reviewNumLbl.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        reviewNumLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        reviewNumLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        reviewGuideLbl.leadingAnchor.constraint(equalTo: reviewNumLbl.trailingAnchor).isActive = true
        reviewGuideLbl.topAnchor.constraint(equalTo: reviewNumLbl.topAnchor).isActive = true
        reviewGuideLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        reviewNumLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }

}
