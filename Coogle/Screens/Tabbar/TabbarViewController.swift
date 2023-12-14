//
//  TabbarViewController.swift
//  Coogle
//
//  Created by jh on 2022/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class TabbarViewController: UITabBarController  {
    private let safeLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.safeAreaInsets.bottom > 10 {
            tabBar.frame.size.height = 88
            tabBar.frame.origin.y = view.frame.height - 88
        } else {
            tabBar.frame.size.height = 54
            tabBar.frame.origin.y = view.frame.height - 54
        }
    }
    
}

extension TabbarViewController {
    private func setUp() {
        setTabBar()
        setupStyle()
        setNavi()
        setSafeLayoutGuideView()
    }
    
    private func setSafeLayoutGuideView() {
        view.addSubview(safeLayoutView)
        self.safeLayoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.safeLayoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.safeLayoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.safeLayoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    private func setTabBar(){
        let vc1 = MainViewController()
        let vc2 = TipViewController()
        let vc3 = BookmarkViewController()
        let vc4 = SettingViewController()
        vc1.title = "레시피"
        vc2.title = "꿀팁"
        vc3.title = "북마크"
        vc4.title = "마이페이지"
        self.setViewControllers([vc1,vc2,vc3,vc4], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let itemsImage = ["tab_recipe","tab_tip","tab_bookmark","tab_myProfile"]
        let selectedImages = ["tab_recipe_on","tab_tip_on","tab_bookmark_on","tab_myProfile_on"]
        for x in 0...3 {
            let image = UIImage(named: itemsImage[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
            
            let selectedImage = UIImage(named: selectedImages[x])?.resizedImage(Size: CGSize(width: 24, height: 24))
            
            items[x].image = image?.withRenderingMode(.alwaysOriginal)
            items[x].selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        }
        
        self.tabBar.unselectedItemTintColor = BaseColor.main
        self.tabBar.tintColor = BaseColor.tabbarTintColor
    }
    
}
