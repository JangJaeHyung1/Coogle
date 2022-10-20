//
//  EndCookingViewController.swift
//  Coogle
//
//  Created by jh on 2022/10/19.
//

import UIKit
import RxSwift
import RxCocoa

class EndCookingViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var tableView: UITableView!

    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.title
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "소세지 야채 볶음"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    let reviewTextView: UITextView = {
        let tv = UITextView()
        tv.contentInset = .init(top: 5, left: 10, bottom: 10, right: 10)
        tv.layer.cornerRadius = 4
        tv.layer.borderWidth = 1
        tv.layer.borderColor = BaseColor.border.cgColor
        tv.font = BaseFont.normal
        tv.textColor = BaseColor.placeholder
        tv.addCharacterSpacing()
        tv.text = "(선택) 자신이 직접 만들어 본 소세지 야채볶음, 해당 레시피가 마음에 들었나요?"
        tv.backgroundColor = .clear
        tv.autocapitalizationType = .none
        tv.autocorrectionType = .no
        tv.smartDashesType = .no
        tv.smartQuotesType = .no
        tv.smartInsertDeleteType = .no
        tv.spellCheckingType = .no
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let tipLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = BaseColor.main
        lbl.font = BaseFont.menuTitle
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "🤔 요리 이후에 정리는 어떻게 할까요?"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("리뷰 완료", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = BaseFont.bold
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = BaseColor.btnColor
        btn.layer.cornerRadius = 4
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
    }
}

extension EndCookingViewController {
    private func setUp() {
        setTableView()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
        hideTextFieldKeyboardWhenTappedBackground()
    }

    private func setTableView(){
        tableView = UITableView()
        //        tableView = UITableView(frame: .zero, style: .plain)
                tableView.dataSource = self
        tableView.delegate = self
//        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        //        tableView.register(CommunityHeaderView.self, forHeaderFooterViewReuseIdentifier: CommunityHeaderView.headerViewID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func fetch() {

    }

    private func bind() {

        reviewTextView.rx.didBeginEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.reviewTextView.text == "(선택) 자신이 직접 만들어 본 소세지 야채볶음, 해당 레시피가 마음에 들었나요?"){
                    self.reviewTextView.text = nil
                    self.reviewTextView.textColor = BaseColor.main
                }
            })
            .disposed(by: disposeBag)
        
        reviewTextView.rx.didEndEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.reviewTextView.text == "" || self.reviewTextView.text == nil){
                    self.reviewTextView.text = "(선택) 자신이 직접 만들어 본 소세지 야채볶음, 해당 레시피가 마음에 들었나요?"
                    self.reviewTextView.textColor = BaseColor.placeholder
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    

    private func setNavi() {
        naviView.titleLbl.text = "리뷰 작성하기"
        //        self.navigationItem.title = "<#title#>"
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        //        self.navigationItem.largeTitleDisplayMode = .always
        //        self.navigationItem.setHidesBackButton(true, animated: true)
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationController?.isNavigationBarHidden = true
    }

    private func addViews() {

        view.addSubview(naviView)
        view.addSubview(titleLbl)
        view.addSubview(reviewTextView)
        view.addSubview(tipLbl)
        view.addSubview(tableView)
        view.addSubview(nextBtn)
    }

    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: naviView.bottomAnchor,constant: 44).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 60).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -60).isActive = true
        
        reviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        reviewTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        reviewTextView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 96).isActive = true
        
        tipLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tipLbl.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 40).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: tipLbl.bottomAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
    }
}

extension EndCookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.font = BaseFont.normal
        if indexPath.row == 0 {
            cell.textLabel?.text = "  " + "양파 보관법"
        } else {
            cell.textLabel?.text = "  " + "파프리카 보관법"
        }
        return cell
    }


}
