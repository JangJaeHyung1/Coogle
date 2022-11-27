//
//  IngredientsTableViewCell.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//
import UIKit
import RxSwift
import RxCocoa

class IngredientsTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    static let cellId = "IngredientsTableViewCell"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeNameTf: BaseTf = {
        let txf = BaseTf()
        txf.placeholder = "예시) 소세지"
        return txf
    }()
    
    let IngredientsTf: BaseTf = {
        let txf = BaseTf()
        txf.placeholder = "200 g"
        return txf
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeBtn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        IngredientsTf.text = nil
        recipeNameTf.text = nil
        disposeBag = DisposeBag()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        //        cellView.setShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(cellView)
        cellView.addSubview(recipeNameTf)
        cellView.addSubview(IngredientsTf)
        cellView.addSubview(closeBtn)
        setConstraints()
    }
    
    private func setConstraints() {
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0).isActive = true
        
        recipeNameTf.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20).isActive = true
        recipeNameTf.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16).isActive = true
        recipeNameTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        recipeNameTf.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0).isActive = true
        
        IngredientsTf.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20).isActive = true
        IngredientsTf.leadingAnchor.constraint(equalTo: recipeNameTf.trailingAnchor, constant: 10).isActive = true
        IngredientsTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        IngredientsTf.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0).isActive = true
        IngredientsTf.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        closeBtn.leadingAnchor.constraint(equalTo: IngredientsTf.trailingAnchor, constant: 10).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: IngredientsTf.centerYAnchor).isActive = true
        
        
    }
}
