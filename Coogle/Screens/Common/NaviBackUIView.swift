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
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.menuTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = ""
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
        addSubview(safeLayoutView)
        addSubview(naviView)
        naviView.addSubview(backBtn)
        naviView.addSubview(titleLbl)
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
        
        titleLbl.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: naviView.centerXAnchor).isActive = true
    }
}
