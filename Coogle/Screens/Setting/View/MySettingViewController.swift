//
//  MySettingViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/14.
//
import UIKit
import RxSwift
import RxCocoa

class MySettingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let nickNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.subBold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "닉네임"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        return lbl
    }()
    
    private let nickNameTf: UITextField = {
        let txf = UITextField()
        txf.isEnabled = false
        txf.layer.cornerRadius = 4
        txf.layer.borderWidth = 1
        txf.layer.borderColor = BaseColor.border.cgColor
        txf.font = BaseFont.normal
        txf.textColor = BaseColor.main
        txf.addCharacterSpacing()
        txf.text = "매콤한 떡볶이"
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txf.leftViewMode = .always
        txf.autocapitalizationType = .none
        txf.autocorrectionType = .no
        txf.smartDashesType = .no
        txf.smartQuotesType = .no
        txf.smartInsertDeleteType = .no
        txf.spellCheckingType = .no
        return txf
    }()
    
    private let conformBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("수정", for: .normal)
        btn.setTitleColor(BaseColor.red, for: .normal)
        btn.titleLabel?.font = BaseFont.subTitle
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    let emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.textColor = BaseColor.sub
        lbl.font = BaseFont.subBold
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "이메일"
        lbl.isUserInteractionEnabled = true
        lbl.addCharacterSpacing()
        lbl.isHidden = true
        return lbl
    }()
    
    private let emailTf: UITextField = {
        let txf = UITextField()
        txf.isEnabled = false
        txf.layer.cornerRadius = 4
        txf.layer.borderWidth = 1
        txf.layer.borderColor = BaseColor.border.cgColor
        txf.font = BaseFont.normal
        txf.textColor = BaseColor.main
        txf.addCharacterSpacing()
        txf.text = "leestart1023@naver.com"
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        txf.leftViewMode = .always
        txf.autocapitalizationType = .none
        txf.autocorrectionType = .no
        txf.smartDashesType = .no
        txf.smartQuotesType = .no
        txf.smartInsertDeleteType = .no
        txf.spellCheckingType = .no
        txf.isHidden = true
        return txf
    }()
    
    private let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.setTitle("로그아웃", for: .normal)
        btn.setTitleColor(BaseColor.main, for: .normal)
        btn.titleLabel?.font = BaseFont.normal
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let withdrawBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.setTitle("회원탈퇴", for: .normal)
        btn.setTitleColor(BaseColor.red, for: .normal)
        btn.titleLabel?.font = BaseFont.normal
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
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


extension MySettingViewController {
    private func setUp() {
        setNavi()
        addViews()
        setConstraints()
        hideTextFieldKeyboardWhenTappedBackground()
        bind()
        fetch()
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        
        logoutBtn.rx.tap
            .subscribe(onNext:{ [unowned self] res in
                LoginUserHashCache.shared.logout()
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        conformBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                print("conformBtn.isSelected : \(self.conformBtn.isSelected)")
                
                self.conformBtn.isSelected = !self.conformBtn.isSelected
                
                if self.conformBtn.isSelected {
                    self.naviView.titleLbl.text = "내 정보 수정"
                    self.naviView.backBtn.isHidden = true
                    self.nickNameTf.isEnabled = true
                    self.conformBtn.setTitle("완료", for: .normal)
                    self.emailTf.textColor = BaseColor.sub
                    self.logoutBtn.isHidden = true
                    self.withdrawBtn.isHidden = true
                } else {
                    self.naviView.backBtn.isHidden = false
                    self.naviView.titleLbl.text = "내 정보"
                    self.nickNameTf.isEnabled = false
                    self.conformBtn.setTitle("수정", for: .normal)
                    self.emailTf.textColor = BaseColor.main
                    self.logoutBtn.isHidden = false
                    self.withdrawBtn.isHidden = false
                }
                
            })
            .disposed(by: disposeBag)
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "내 정보"
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(nickNameLbl)
        view.addSubview(nickNameTf)
        view.addSubview(conformBtn)
        view.addSubview(emailLbl)
        view.addSubview(emailTf)
        view.addSubview(logoutBtn)
        view.addSubview(withdrawBtn)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        nickNameLbl.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 20).isActive = true
        nickNameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        nickNameTf.topAnchor.constraint(equalTo: nickNameLbl.bottomAnchor, constant: 10).isActive = true
        nickNameTf.leadingAnchor.constraint(equalTo: nickNameLbl.leadingAnchor).isActive = true
        nickNameTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nickNameTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        conformBtn.trailingAnchor.constraint(equalTo: nickNameTf.trailingAnchor, constant: -10).isActive = true
        conformBtn.centerYAnchor.constraint(equalTo: nickNameTf.centerYAnchor).isActive = true
        
        emailLbl.topAnchor.constraint(equalTo: nickNameTf.bottomAnchor, constant: 20).isActive = true
        emailLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        emailTf.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 10).isActive = true
        emailTf.leadingAnchor.constraint(equalTo: emailLbl.leadingAnchor).isActive = true
        emailTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        emailTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        logoutBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        logoutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        logoutBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        logoutBtn.bottomAnchor.constraint(equalTo: withdrawBtn.topAnchor, constant: -6).isActive = true
        
        withdrawBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        withdrawBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        withdrawBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        withdrawBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
    }
}
