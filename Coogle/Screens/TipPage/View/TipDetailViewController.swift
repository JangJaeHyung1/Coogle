//
//  TipDetailViewController.swift
//  Coogle
//
//  Created by jh on 2022/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class TipDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = BaseFont.normal
        tv.textColor = BaseColor.main
        tv.isEditable = false
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.smartDashesType = .no
        tv.smartQuotesType = .no
        tv.smartInsertDeleteType = .no
        tv.spellCheckingType = .no
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = """
1. 껍질을 잘 벗겨준 양파는 뿌리 부분을 잘라주세요.

2. 꼭지 부분은 남겨놔주세요

3. 양파 1개씩 비닐랩으로 꽁꽁 싸주세요.

4. 지퍼락 또는 용기에 양파들을 넣어주세요.

6. 냉장실에 넣어주시면 끝!


※ 주의사항

양파 껍질을 벗긴 뒤 절대로 물에 헹구면 안됩니다.
요리할 때 씻어 사용해주세요.
"""
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension TipDetailViewController {
    private func setUp() {
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "양파 보관법"
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(contentTextView)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16).isActive = true
        contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16).isActive = true
        contentTextView.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 20).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
