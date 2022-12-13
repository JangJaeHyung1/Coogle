//
//  CreateRecipeViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//

import UIKit
import RxSwift
import RxCocoa

class CreateRecipeViewController: UIViewController {
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var recipeName = ""
    private let placeholder = "예시) 간단한 밥반찬으로 딱 좋은 소세지\n야채볶음을 한번 만들어보겠습니다."
    let categoryArr = ["메인요리","국 찌개", "밑반찬", "다이어트", "건강주스"]
    let personArr = ["1인분","2인분", "3인분", "4인분"]
    
    private let disposeBag = DisposeBag()
    let viewModel = CreateRecipeViewModel()
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.progressBarBg
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let progressLine: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.progressBar
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let recipeNameLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "어떤 요리 레시피인가요?"
        return lbl
    }()
    
    private let recipeNameTf: BaseTf = {
        let txf = BaseTf()
        txf.placeholder = "예시) 소세지 야채 볶음"
        return txf
    }()
    
    private let categoryLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "카테고리가 어떻게 되나요?"
        return lbl
    }()
    
    private let categoryTf: BaseTf = {
        let txf = BaseTf()
        txf.isEnabled = false
        txf.placeholder = "예) 메인요리"
        return txf
    }()
    
    private let moreBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let moreBtnImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "moreBtn")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let recipeIntroLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "레시피를 간략하게 설명해주세요"
        return lbl
    }()
    
    private let recipeIntroTv: BaseTv = {
        let tv = BaseTv()
        tv.text = "예시) 간단한 밥반찬으로 딱 좋은 소세지\n야채볶음을 한번 만들어보겠습니다."
        return tv
    }()
    
    private let difficultyLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "난이도는 어떤가요?"
        return lbl
    }()
    
    private let easyBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("쉬움", for: .normal)
        btn.setTitleColor(BaseColor.sub, for: .normal)
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = BaseFont.subTitle
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let normalBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("보통", for: .normal)
        btn.setTitleColor(BaseColor.sub, for: .normal)
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = BaseFont.subTitle
        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let difficultBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("어려움", for: .normal)
        btn.setTitleColor(BaseColor.sub, for: .normal)
        btn.layer.borderColor = BaseColor.border.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = BaseFont.subTitle
        //        btn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        btn.imageEdgeInsets = .init(top: 0, left: 50, bottom: 0, right: 0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let nextBtn: NextBtn = {
        let btn = NextBtn()
        btn.isEnabled = false
        btn.backgroundColor = BaseColor.progressBarBg
        btn.setTitle("다음", for: .normal)
        return btn
    }()
    
    private lazy var difficultyBtnArr: [UIButton] = [easyBtn, normalBtn, difficultBtn]
    
    private let personLbl: BaseLbl = {
        let lbl = BaseLbl()
        lbl.text = "몇 인분인가요?"
        return lbl
    }()
    
    private let personTf: BaseTf = {
        let txf = BaseTf()
        txf.isEnabled = false
        txf.placeholder = "예) 1인분"
        return txf
    }()
    
    private let moreBtn2: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private let moreBtnImage2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "moreBtn")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
        
    }
}

extension CreateRecipeViewController {
    private func setUp() {
        setNavi()
        addViews()
        bind()
        fetch()
        setConstraints()
        hideTextFieldKeyboardWhenTappedBackground()
    }
    
    private func fetch() {
        recipeNameTf.text = recipeName
        viewModel.input.firstPageRecipeName.accept(recipeName)
        categoryTf.text = viewModel.input.firstPageCategory.value
        if viewModel.input.firstPageDescription.value.count > 0 {
            recipeIntroTv.text = viewModel.input.firstPageDescription.value
            recipeIntroTv.textColor = BaseColor.main
        }
        if viewModel.input.firstPageDifficulty.value != -1 {
            difficultyBtnArr[viewModel.input.firstPageDifficulty.value].isSelected = true
            difficultyBtnArr[viewModel.input.firstPageDifficulty.value].layer.borderColor = BaseColor.red.cgColor
        }
    }
    
    private func setBtnSelected(_ btn: UIButton){
        for i in 0..<difficultyBtnArr.count {
            if btn == difficultyBtnArr[i] {
                viewModel.input.firstPageDifficulty.accept(i)
                difficultyBtnArr[i].setTitleColor(BaseColor.red, for: .normal)
                difficultyBtnArr[i].isSelected = true
                difficultyBtnArr[i].layer.borderColor = BaseColor.red.cgColor
            } else {
                difficultyBtnArr[i].setTitleColor(BaseColor.sub, for: .normal)
                difficultyBtnArr[i].isSelected = false
                difficultyBtnArr[i].layer.borderColor = BaseColor.border.cgColor
            }
        }
    }
    
    
    private func bind() {
        
        
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                let nextVC = CreateRecipeSecondViewController()
                nextVC.viewModel = self.viewModel
                self.navigationController?.pushViewController(
                    nextVC, animated: false)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.firstCompleted
            .subscribe(onNext:{ [unowned self] res in
                if res {
                    self.nextBtn.isEnabled = true
                    self.nextBtn.backgroundColor = BaseColor.btnColor
                } else {
                    self.nextBtn.isEnabled = false
                    self.nextBtn.backgroundColor = BaseColor.progressBarBg
                }
            })
            .disposed(by: disposeBag)
        
        recipeNameTf.rx.text
            .subscribe(onNext:{ [unowned self] res in
                guard let txt = res else { return }
                self.viewModel.input.firstPageRecipeName.accept(txt)
            })
            .disposed(by: disposeBag)
        
        moreBtn.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext:{ [unowned self] _ in
                self.moreBtn.isSelected = !self.moreBtn.isSelected
                
                if self.moreBtn.isSelected {
                    createPickerView()
                } else {
                    toolBar.removeFromSuperview()
                    picker.removeFromSuperview()
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.moreBtnImage.transform = self.moreBtnImage.transform.rotated(by: .pi)
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
            })
            .disposed(by: disposeBag)
        
        moreBtn2.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext:{ [unowned self] _ in
                self.moreBtn.isSelected = !self.moreBtn.isSelected
                
                if self.moreBtn.isSelected {
                    createPickerView2()
                } else {
                    toolBar.removeFromSuperview()
                    picker.removeFromSuperview()
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.moreBtnImage2.transform = self.moreBtnImage2.transform.rotated(by: .pi)
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
            })
            .disposed(by: disposeBag)
        
        recipeIntroTv.rx.didBeginEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.recipeIntroTv.text == placeholder){
                    self.recipeIntroTv.text = nil
                    self.recipeIntroTv.textColor = BaseColor.main
                }
            })
            .disposed(by: disposeBag)
        
        recipeIntroTv.rx.didEndEditing
            .subscribe(onNext:{ [unowned self] res in
                if(self.recipeIntroTv.text == "" || self.recipeIntroTv.text == nil){
                    self.recipeIntroTv.text = placeholder
                    self.recipeIntroTv.textColor = BaseColor.placeholder
                }
            })
            .disposed(by: disposeBag)
        
        recipeIntroTv.rx.text
            .subscribe(onNext:{ [unowned self] res in
                guard let txt = res else { return }
                if txt != placeholder {
                    self.viewModel.input.firstPageDescription.accept(txt)
                }
            })
            .disposed(by: disposeBag)
        
        easyBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.setBtnSelected(easyBtn)
            })
            .disposed(by: disposeBag)
        normalBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.setBtnSelected(normalBtn)
            })
            .disposed(by: disposeBag)
        difficultBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.setBtnSelected(difficultBtn)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "레시피 만들기"
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(bottomLine)
        view.addSubview(progressLine)
        view.addSubview(recipeNameLbl)
        view.addSubview(recipeNameTf)
        view.addSubview(categoryLbl)
        view.addSubview(categoryTf)
        view.addSubview(moreBtnImage)
        view.addSubview(moreBtn)
        view.addSubview(recipeIntroLbl)
        view.addSubview(recipeIntroTv)
        view.addSubview(difficultyLbl)
        view.addSubview(easyBtn)
        view.addSubview(normalBtn)
        view.addSubview(difficultBtn)
        view.addSubview(nextBtn)
        
        view.addSubview(personTf)
        view.addSubview(personLbl)
        view.addSubview(moreBtn2)
        view.addSubview(moreBtnImage2)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        bottomLine.leadingAnchor.constraint(equalTo: naviView.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: naviView.trailingAnchor).isActive = true
        bottomLine.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 10).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        progressLine.leadingAnchor.constraint(equalTo: naviView.leadingAnchor).isActive = true
        progressLine.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3).isActive = true
        progressLine.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 10).isActive = true
        progressLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        recipeNameLbl.topAnchor.constraint(equalTo: progressLine.bottomAnchor, constant: 20).isActive = true
        recipeNameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        recipeNameTf.topAnchor.constraint(equalTo: recipeNameLbl.bottomAnchor, constant: 10).isActive = true
        recipeNameTf.leadingAnchor.constraint(equalTo: recipeNameLbl.leadingAnchor).isActive = true
        recipeNameTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        recipeNameTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        categoryLbl.topAnchor.constraint(equalTo: recipeNameTf.bottomAnchor, constant: 20).isActive = true
        categoryLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        categoryTf.topAnchor.constraint(equalTo: categoryLbl.bottomAnchor, constant: 10).isActive = true
        categoryTf.leadingAnchor.constraint(equalTo: recipeNameLbl.leadingAnchor).isActive = true
        categoryTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        categoryTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        moreBtnImage.centerYAnchor.constraint(equalTo: categoryTf.centerYAnchor).isActive = true
        moreBtnImage.trailingAnchor.constraint(equalTo: categoryTf.trailingAnchor, constant: -10).isActive = true
        moreBtnImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        moreBtnImage.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        moreBtn.leadingAnchor.constraint(equalTo: categoryTf.leadingAnchor).isActive = true
        moreBtn.trailingAnchor.constraint(equalTo: categoryTf.trailingAnchor).isActive = true
        moreBtn.bottomAnchor.constraint(equalTo: categoryTf.bottomAnchor).isActive = true
        moreBtn.topAnchor.constraint(equalTo: categoryTf.topAnchor).isActive = true
        
        recipeIntroLbl.topAnchor.constraint(equalTo: categoryTf.bottomAnchor, constant: 20).isActive = true
        recipeIntroLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        recipeIntroTv.topAnchor.constraint(equalTo: recipeIntroLbl.bottomAnchor, constant: 10).isActive = true
        recipeIntroTv.leadingAnchor.constraint(equalTo: recipeIntroLbl.leadingAnchor).isActive = true
        recipeIntroTv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        recipeIntroTv.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        difficultyLbl.topAnchor.constraint(equalTo: recipeIntroTv.bottomAnchor, constant: 20).isActive = true
        difficultyLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        easyBtn.leadingAnchor.constraint(equalTo: difficultyLbl.leadingAnchor).isActive = true
        easyBtn.topAnchor.constraint(equalTo: difficultyLbl.bottomAnchor, constant: 10).isActive = true
        easyBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        easyBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        normalBtn.leadingAnchor.constraint(equalTo: easyBtn.trailingAnchor, constant: 10).isActive = true
        normalBtn.topAnchor.constraint(equalTo: difficultyLbl.bottomAnchor, constant: 10).isActive = true
        normalBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        normalBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        difficultBtn.leadingAnchor.constraint(equalTo: normalBtn.trailingAnchor, constant: 10).isActive = true
        difficultBtn.topAnchor.constraint(equalTo: difficultyLbl.bottomAnchor, constant: 10).isActive = true
        difficultBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        difficultBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        personLbl.topAnchor.constraint(equalTo: difficultBtn.bottomAnchor, constant: 20).isActive = true
        personLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        personTf.topAnchor.constraint(equalTo: personLbl.bottomAnchor, constant: 10).isActive = true
        personTf.leadingAnchor.constraint(equalTo: recipeNameLbl.leadingAnchor).isActive = true
        personTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        personTf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        moreBtnImage2.centerYAnchor.constraint(equalTo: personTf.centerYAnchor).isActive = true
        moreBtnImage2.trailingAnchor.constraint(equalTo: personTf.trailingAnchor, constant: -10).isActive = true
        moreBtnImage2.widthAnchor.constraint(equalToConstant: 10).isActive = true
        moreBtnImage2.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        moreBtn2.leadingAnchor.constraint(equalTo: personTf.leadingAnchor).isActive = true
        moreBtn2.trailingAnchor.constraint(equalTo: personTf.trailingAnchor).isActive = true
        moreBtn2.bottomAnchor.constraint(equalTo: personTf.bottomAnchor).isActive = true
        moreBtn2.topAnchor.constraint(equalTo: personTf.topAnchor).isActive = true
        
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
    }
}

extension CreateRecipeViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return categoryArr.count
        } else {
            return personArr.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
        return categoryArr[row]
        } else {
            return personArr[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
        categoryTf.text = categoryArr[row]
        viewModel.input.firstPageCategory.accept(categoryArr[row])
        } else {
            personTf.text = personArr[row]
            viewModel.input.firstPagePerson.accept(personArr[row])
        }
    }
    
    func createPickerView(){
        picker = UIPickerView.init()
        picker.tag = 0
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        
                
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let selectBtn = UIBarButtonItem.init(title: "선택", style: .done, target: self, action: #selector(onDoneButtonTapped))
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 40))
        toolBar.setItems([flexSpace,selectBtn], animated: true)
        self.view.addSubview(toolBar)
        
        view.layoutIfNeeded()
    }
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        moreBtn.sendActions(for: .touchUpInside)
    }
    
    func createPickerView2(){
        picker = UIPickerView.init()
        picker.tag = 1
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        
                
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let selectBtn = UIBarButtonItem.init(title: "선택", style: .done, target: self, action: #selector(onDoneButtonTapped2))
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 40))
        toolBar.setItems([flexSpace,selectBtn], animated: true)
        self.view.addSubview(toolBar)
        
        view.layoutIfNeeded()
    }
    @objc func onDoneButtonTapped2() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        moreBtn2.sendActions(for: .touchUpInside)
    }
}

