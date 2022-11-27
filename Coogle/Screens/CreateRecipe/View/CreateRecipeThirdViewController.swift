//
//  CreateRecipeThirdViewController.swift
//  Coogle
//
//  Created by jh on 2022/11/17.
//


import UIKit
import RxSwift
import RxCocoa
import Photos

class CreateRecipeThirdViewController: UIViewController {
    
    private var tableView: UITableView!
    var viewModel = CreateRecipeViewModel()
    private let disposeBag = DisposeBag()
    
    private var imagesArr: [Data?] = [nil]
    private var descriptArr: [String] = [""]
    
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
        btn.setTitle("레시피 생성 완료!", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
        
    }
}

extension CreateRecipeThirdViewController {
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
        tableView.register(StepRecipeTableViewCell.self, forCellReuseIdentifier: StepRecipeTableViewCell.cellId)
        tableView.register(IngredientsLastTableViewCell.self, forCellReuseIdentifier: IngredientsLastTableViewCell.cellId)
        tableView.contentInset = .init(top: 0, left: 0, bottom: 150, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func fetch() {
        descriptArr = viewModel.input.thirdPageDescription.value
        imagesArr = viewModel.input.thirdPageImageData.value
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
        
        viewModel.output.thirdCompleted
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
                self.backTwo(1)
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
        progressLine.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        progressLine.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 10).isActive = true
        progressLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        tableView.topAnchor.constraint(equalTo: bottomLine.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -10).isActive = true
        
        
        nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
    }
}

extension CreateRecipeThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptArr.count + 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomTableHeaderView()
        headerView.recipeNameLbl.text = "단계별로 레시피를 작성해주세요."
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == descriptArr.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsLastTableViewCell.cellId, for: indexPath) as! IngredientsLastTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StepRecipeTableViewCell.cellId, for: indexPath) as! StepRecipeTableViewCell
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.closeBtn.isHidden = true
            } else {
                cell.closeBtn.isHidden = false
            }

            cell.stepLbl.text = "Step\(indexPath.row+1)"
            cell.profileImage.image = nil
            cell.decriptTv.text = nil
            cell.decriptTv.text = descriptArr[indexPath.row]
            if let imageData = imagesArr[indexPath.row] {
                cell.profileImage.image = UIImage(data: imageData)
            }
            
            cell.profileImageBtn.rx.tap
                .flatMap{ _ in PhotoPermissionManager.shared.requestPhoto()}
                .filter({ status in
                    return status.rawValue == 3
                })
                .flatMapLatest { [weak self] _ in
                    return UIImagePickerController.rx.createWithParent(self) { picker in
                        picker.sourceType = .photoLibrary
                        picker.allowsEditing = true
                    }
                    .flatMap {
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
                }
                .map { info in
                    return info[.editedImage] as? UIImage
                }
                .subscribe(onNext:{ res in
                    cell.profileImage.image = res
                })
                .disposed(by: cell.disposeBag)
            
            cell.profileImage.rx.observe(UIImage.self,"image")
                .subscribe(onNext:{ [unowned self] res in
                    if res != nil {
                        self.imagesArr[indexPath.row] = res!.jpegData(compressionQuality: 0.7)!
                    }
                    self.viewModel.input.thirdPageImageData.accept(self.imagesArr)
                })
                .disposed(by: cell.disposeBag)
            
            cell.decriptTv.rx.text.orEmpty
                .subscribe(onNext:{ [unowned self] res in
                    self.descriptArr[indexPath.row] = res
                    self.viewModel.input.thirdPageDescription.accept(self.descriptArr)
                    if res.count == 0 {
                        cell.placeHolderLbl.isHidden = false
                    } else {
                        cell.placeHolderLbl.isHidden = true
                    }
                })
                .disposed(by: cell.disposeBag)
            
            cell.closeBtn.rx.tap
                .subscribe(onNext:{ [weak self] _ in
                    guard let self = self else { return }
                    self.descriptArr.remove(at: indexPath.row)
                    self.imagesArr.remove(at: indexPath.row)
                    self.tableView.reloadData()
                })
                .disposed(by: cell.disposeBag)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == descriptArr.count {
            descriptArr.append("")
            imagesArr.append(nil)
            self.tableView.reloadData()
        }
    }
}
extension CreateRecipeThirdViewController {
    func backTwo(_ idx: Int) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - idx-3], animated: true)
    }
}
