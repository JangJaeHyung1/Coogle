//
//  DetailSecondHeaderView.swift
//  Coogle
//
//  Created by jh on 2022/11/27.
//
import UIKit

class DetailIngredientHeaderView: UIView {
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    let recipeNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.bold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "메인 재료"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
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
        recipeNameLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        recipeNameLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }


}
