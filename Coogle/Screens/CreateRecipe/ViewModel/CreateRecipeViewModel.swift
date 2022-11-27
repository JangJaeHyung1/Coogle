//
//  CreateRecipeViewModel.swift
//  Coogle
//
//  Created by jh on 2022/11/16.
//

import Foundation
import RxSwift
import RxRelay

class CreateRecipeViewModel {
    let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let firstPageRecipeName = BehaviorRelay<String>(value: "")
        let firstPageCategory = BehaviorRelay<String>(value: "")
        let firstPageDescription = BehaviorRelay<String>(value: "")
        let firstPageDifficulty = BehaviorRelay<Int>(value: -1)
        
        let secondPageIngredientFrist = BehaviorRelay<[[String]]>(value: [["",""]])
        let secondPageIngredientSecond = BehaviorRelay<[[String]]>(value: [["",""]])
        
        let thirdPageImageData = BehaviorRelay<[Data?]>(value: [nil])
        let thirdPageDescription = BehaviorRelay<[String]>(value: [""])
    }
    struct Output {
        let firstCompleted = PublishRelay<Bool>()
        let secondCompleted = PublishRelay<Bool>()
        let thirdCompleted = PublishRelay<Bool>()
    }
    
    init() {
        
        Observable.combineLatest(input.thirdPageImageData, input.thirdPageDescription)
            .subscribe { [weak self] (data, description) in
                guard let self = self else { return }
                var temp = true
                for i in 0..<self.input.thirdPageDescription.value.count {
                    if  self.input.thirdPageDescription.value[i].count == 0 {
                        temp = false
                    }
                }
                for i in 0..<self.input.thirdPageImageData.value.count {
                    if  self.input.thirdPageImageData.value[i] == nil {
                        temp = false
                    }
                }
                self.output.thirdCompleted.accept(temp)
            } onError: { err in
                debugPrint("🔵thirdPage combineLatest err : \(err)")
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: disposeBag)
        
        Observable.combineLatest(input.firstPageRecipeName, input.firstPageCategory, input.firstPageDescription, input.firstPageDifficulty)
        //            .debug()
            .subscribe { [weak self] (recipeName, category, discript, difficulty) in
                guard let self = self else { return }
                if recipeName.count > 0 && category.count > 0 && discript.count > 0 && difficulty > -1 {
                    self.output.firstCompleted.accept(true)
                } else {
                    self.output.firstCompleted.accept(false)
                }
                
            } onError: { err in
                debugPrint("🔵firstPage combineLatest err : \(err)")
            } onCompleted: {
            } onDisposed: {
            }.disposed(by: disposeBag)
        
        Observable.combineLatest(input.secondPageIngredientFrist, input.secondPageIngredientSecond)
            .subscribe(onNext:{ [weak self] first, second in
                guard let self = self else { return }
                var temp = true
                for i in first {
                    if i[0].count == 0 || i[1].count == 0 {
                        temp = false
                    }
                }
                for j in second {
                    if j[0].count == 0 || j[1].count == 0 {
                        temp = false
                    }
                }
                self.output.secondCompleted.accept(temp)
                
            })
            .disposed(by: disposeBag)
        
        transform()
    }
    private func transform(){
        
    }
}
