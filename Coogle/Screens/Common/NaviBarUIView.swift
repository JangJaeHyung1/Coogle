//
//  NaviView.swift
//  Coogle
//
//  Created by jh on 2022/08/07.
//

import UIKit

class NaviBarUIView: UIView {
    private let safeLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    private let logoLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.logo
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "coogle"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "searchIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let filterBtn: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = .init(top: 4, left: 60, bottom: 10, right: 10)
        btn.setImage(UIImage(named: "filterIcon")?.resizedImage(Size: CGSize(width: 10, height: 10)), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.imageView?.contentMode = .scaleAspectFit
//        btn.backgroundColor = .red
        return btn
    }()
    
    let filterLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = BaseFont.subTitle
        lbl.textColor = BaseColor.main
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "최신순"
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
        naviView.addSubview(logoLbl)
        naviView.addSubview(searchBtn)
        naviView.addSubview(filterBtn)
        naviView.addSubview(filterLbl)
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
        
        logoLbl.leadingAnchor.constraint(equalTo: naviView.leadingAnchor, constant: 20).isActive = true
        logoLbl.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        
        searchBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor)
            .isActive = true
        searchBtn.trailingAnchor.constraint(equalTo: naviView.trailingAnchor, constant: -16).isActive = true
        
        filterBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        filterBtn.trailingAnchor.constraint(equalTo: searchBtn.leadingAnchor, constant: -4).isActive = true
        
        filterLbl.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        filterLbl.trailingAnchor.constraint(equalTo: filterBtn.leadingAnchor, constant: 54).isActive = true
    }
}
