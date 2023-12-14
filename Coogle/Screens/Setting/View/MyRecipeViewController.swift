//
//  MyRecipeViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/13.
//


import UIKit
import RxSwift
import RxCocoa

class MyRecipeViewController: UIViewController {
    
    private var tableViewMain: UITableView!
    private let disposeBag = DisposeBag()
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let creatRecipeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "createBtn"), for: .normal)
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
        super.init(coder: coder)
    }

}


extension MyRecipeViewController {
    private func setUp() {
        configure()
        setTableView()
        setNavi()
        addViews()
        setConstraints()
        bind()
        fetch()
    }
    
    private func setTableView(){
        tableViewMain = UITableView()
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        tableViewMain.separatorStyle = .none
        tableViewMain.showsHorizontalScrollIndicator = false
        tableViewMain.showsVerticalScrollIndicator = false
        tableViewMain.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableViewMain.translatesAutoresizingMaskIntoConstraints = false
        tableViewMain.backgroundColor = .white
    }
    
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func fetch() {
        
    }
    
    private func bind() {
        naviView.backBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        tableViewMain.rx.itemSelected
            .subscribe(onNext:{ [unowned self] _ in
                let nextVC = DetailViewController(isBookmark: false, canEdit: true)
                PageNum.value = 0
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        creatRecipeBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                let nextVC = CreateRecipeViewController()
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
        naviView.titleLbl.text = "내가 만든 레시피"
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(creatRecipeBtn)
        view.addSubview(tableViewMain)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        creatRecipeBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        creatRecipeBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        creatRecipeBtn.centerYAnchor.constraint(equalTo: naviView.centerYAnchor).isActive = true
        creatRecipeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        
        tableViewMain.topAnchor.constraint(equalTo: naviView.bottomAnchor).isActive = true
        tableViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MyRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
}
