//
//  NaviBackUIView.swift
//  Coogle
//
//  Created by jh on 2022/08/14.
//

import UIKit

class NaviBackUIView: UIView {
    let safeLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    private let naviView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "backIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "searchIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        btn.isHidden = true
        return btn
    }()
    
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = BaseColor.difficultyBg
        view.layer.cornerRadius = 4
        view.isHidden = true
        return view
    }()
    
    private let searchImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "search_icon_tf")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let searchTxf: UITextField = {
        let txf = UITextField()
        txf.placeholder = "검색어를 입력해주세요"
        txf.font = BaseFont.tf
        txf.textColor = .black
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.leftViewMode = .always
        txf.autocapitalizationType = .none
        txf.autocorrectionType = .no
        txf.smartDashesType = .no
        txf.smartQuotesType = .no
        txf.smartInsertDeleteType = .no
        txf.spellCheckingType = .no
        return txf
    }()
    
    let searchDeleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search_close"), for: .normal)
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.menuTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = ""
        lbl.isUserInteractionEnabled = true
        lbl.textAlignment = .center
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
        addSubview(safeLayoutView)
        addSubview(naviView)
        naviView.addSubview(backBtn)
        naviView.addSubview(titleLbl)
        naviView.addSubview(searchBtn)
        addSubview(searchView)
        searchView.addSubview(searchImg)
        searchView.addSubview(searchTxf)
        searchView.addSubview(searchDeleteBtn)
        setConstraints()
    }
    
    private func setConstraints() {
        safeLayoutView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        safeLayoutView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        safeLayoutView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        safeLayoutView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true

        naviView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        backBtn.leadingAnchor.constraint(equalTo: naviView.leadingAnchor, constant: 16).isActive = true
        backBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        searchBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor)
            .isActive = true
        searchBtn.trailingAnchor.constraint(equalTo: naviView.trailingAnchor, constant: -16).isActive = true
        
        titleLbl.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: naviView.centerXAnchor).isActive = true
        
        searchView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        searchView.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10).isActive = true
        searchView.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        searchImg.widthAnchor.constraint(equalToConstant: 24).isActive = true
        searchImg.heightAnchor.constraint(equalToConstant: 24).isActive = true
        searchImg.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 4).isActive = true
        searchImg.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        searchDeleteBtn.widthAnchor.constraint(equalToConstant: 34).isActive = true
        searchDeleteBtn.heightAnchor.constraint(equalToConstant: 34).isActive = true
        searchDeleteBtn.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -4).isActive = true
        searchDeleteBtn.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        searchTxf.leadingAnchor.constraint(equalTo: searchImg.trailingAnchor, constant: 4).isActive = true
        searchTxf.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        searchTxf.trailingAnchor.constraint(equalTo: searchDeleteBtn.leadingAnchor, constant: -4).isActive = true
    }
}
