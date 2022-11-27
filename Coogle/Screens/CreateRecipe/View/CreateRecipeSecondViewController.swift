//
//  CreateRecipeSecondViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/15.
//

import UIKit
import RxSwift
import RxCocoa

class CreateRecipeSecondViewController: UIViewController {

    private var tableView: UITableView!
    var viewModel = CreateRecipeViewModel()
    private let disposeBag = DisposeBag()
    
    private var firstArr: [[String]] = [["",""]]
    private var secondArr: [[String]] = [["",""]]
    
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
    
    private let nextBtn: NextBtn = {
        let btn = NextBtn()
        btn.backgroundColor = BaseColor.progressBarBg
        btn.isEnabled = false
        btn.setTitle("다음", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
        
    }
}

extension CreateRecipeSecondViewController {
    private func setUp() {
        setNavi()
        setTableView()
        addViews()
        bind()
        fetch()
        setConstraints()
        hideTextFieldKeyboardWhenTappedBackground()
    }
    private func setTableView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.cellId)
        tableView.register(IngredientsLastTableViewCell.self, forCellReuseIdentifier: IngredientsLastTableViewCell.cellId)
        tableView.contentInset = .init(top: 0, left: 0, bottom: 150, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func fetch() {
        firstArr = viewModel.input.secondPageIngredientFrist.value
        secondArr = viewModel.input.secondPageIngredientSecond.value
        tableView.reloadData()
    }
    
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: false)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.secondCompleted
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
        
        nextBtn.rx.tap
            .subscribe(onNext:{ [weak self] _ in
                guard let self = self else { return }
                let nextVC = CreateRecipeThirdViewController()
                nextVC.viewModel = self.viewModel
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
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
        view.addSubview(tableView)
        view.addSubview(nextBtn)
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
        progressLine.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/3 * 2).isActive = true
        progressLine.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 10).isActive = true
        progressLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        tableView.topAnchor.constraint(equalTo: bottomLine.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: 0).isActive = true
        
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
    }
}

extension CreateRecipeSecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return firstArr.count + 1
        } else {
            return secondArr.count + 1
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = CustomTableHeaderView()
            headerView.recipeNameLbl.text = "어떤 조미료가 필요한가요?"
            return headerView
        }
        return CustomTableHeaderView()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == firstArr.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsLastTableViewCell.cellId, for: indexPath) as! IngredientsLastTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.cellId, for: indexPath) as! IngredientsTableViewCell
                cell.selectionStyle = .none
                if indexPath.row == 0 {
                    cell.closeBtn.isHidden = true
                } else {
                    cell.closeBtn.isHidden = false
                }
                cell.recipeNameTf.placeholder = "예시) 소세지"
                cell.IngredientsTf.placeholder = "200 g"
                cell.recipeNameTf.text = firstArr[indexPath.row][0]
                cell.IngredientsTf.text = firstArr[indexPath.row][1]
                
                cell.recipeNameTf.rx.text.orEmpty
                    .subscribe(onNext:{ [unowned self] res in
                        self.firstArr[indexPath.row][0] = res
                        self.viewModel.input.secondPageIngredientFrist.accept(self.firstArr)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.IngredientsTf.rx.text.orEmpty
                    .subscribe(onNext:{ [unowned self] res in
                        self.firstArr[indexPath.row][1] = res
                        self.viewModel.input.secondPageIngredientFrist.accept(self.firstArr)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.closeBtn.rx.tap
                    .subscribe(onNext:{ [weak self] _ in
                        guard let self = self else { return }
                        self.firstArr.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    })
                    .disposed(by: cell.disposeBag)
                
                return cell
            }
        } else {
            if indexPath.row == secondArr.count  {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsLastTableViewCell.cellId, for: indexPath) as! IngredientsLastTableViewCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.cellId, for: indexPath) as! IngredientsTableViewCell
                cell.selectionStyle = .none
                if indexPath.row == 0 {
                    cell.closeBtn.isHidden = true
                } else {
                    cell.closeBtn.isHidden = false
                }
                cell.recipeNameTf.placeholder = "예시) 소금"
                cell.IngredientsTf.placeholder = "5 g"
                cell.recipeNameTf.text = secondArr[indexPath.row][0]
                cell.IngredientsTf.text = secondArr[indexPath.row][1]
                
                cell.recipeNameTf.rx.text.orEmpty
                    .subscribe(onNext:{ [unowned self] res in
                        self.secondArr[indexPath.row][0] = res
                        self.viewModel.input.secondPageIngredientSecond.accept(self.secondArr)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.IngredientsTf.rx.text.orEmpty
                    .subscribe(onNext:{ [unowned self] res in
                        self.secondArr[indexPath.row][1] = res
                        self.viewModel.input.secondPageIngredientSecond.accept(self.secondArr)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.closeBtn.rx.tap
                    .subscribe(onNext:{ [weak self] _ in
                        guard let self = self else { return }
                        self.secondArr.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    })
                    .disposed(by: cell.disposeBag)
                
                return cell
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == firstArr.count {
                firstArr.append(["",""])
                self.tableView.reloadData()
            }
        } else {
            if indexPath.row == secondArr.count {
                secondArr.append(["",""])
                self.tableView.reloadData()
            }
        }
    }
}
