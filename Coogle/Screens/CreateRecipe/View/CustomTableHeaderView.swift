//
//  CustomTableHeaderView.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//

import UIKit

class CustomTableHeaderView: UIView {
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let recipeNameLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "어떤 재료가 필요한가요?"
        return lbl
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        addSubview(contentView)
        contentView.addSubview(recipeNameLbl)
        
        setConstraints()
    }

    private func setConstraints() {
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        recipeNameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        recipeNameLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        recipeNameLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }


}
