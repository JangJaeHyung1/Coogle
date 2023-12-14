//
//  SearchViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/27.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let naviView: NaviBackUIView = {
        let view = NaviBackUIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var tableViewMain: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
        naviView.searchView.isHidden = false
    }
}

extension SearchViewController {
    private func setUp() {
        setNavi()
        setTableView()
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
        
        naviView.searchDeleteBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                naviView.searchTxf.text = ""
            })
            .disposed(by: disposeBag)
        
        tableViewMain.rx.itemSelected
            .subscribe(onNext:{ [unowned self] _ in
                let nextVC = DetailViewController(isBookmark: false, canEdit: false)
                PageNum.value = 0
                self.navigationController?.pushViewController(
                    nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setNavi() {
    }
    
    private func addViews() {
        view.addSubview(naviView)
        view.addSubview(tableViewMain)
    }
    
    private func setConstraints() {
        naviView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        naviView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        naviView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        naviView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        
        tableViewMain.topAnchor.constraint(equalTo: naviView.bottomAnchor).isActive = true
        tableViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewMain.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}

// MARK: - TableView Delegate, DataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
