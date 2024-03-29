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
    var stat = Stat()
    
    struct Stat {
        let createRecipe = PublishSubject<Void>()
    }
    
    struct Input {
        let firstPageRecipeName = BehaviorRelay<String>(value: "")
        let firstPageCategory = BehaviorRelay<String>(value: "")
        let firstPagePerson = BehaviorRelay<String>(value: "")
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
        
        let recipeData = PublishRelay<RecipeData>()
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
        
        Observable.combineLatest(input.firstPageRecipeName, input.firstPageCategory, input.firstPageDescription, input.firstPageDifficulty, input.firstPagePerson)
        //            .debug()
            .subscribe { [weak self] (recipeName, category, discript, difficulty, person) in
                guard let self = self else { return }
                if recipeName.count > 0 && category.count > 0 && discript.count > 0 && difficulty > -1 && person.count > 0 {
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
        let firstPage5 = Observable.combineLatest(
            input.firstPageRecipeName,
            input.firstPageCategory,
            input.firstPagePerson,
            input.firstPageDescription,
            input.firstPageDifficulty)
        
        let secondThrid4 = Observable.combineLatest(
            input.secondPageIngredientFrist,
            input.secondPageIngredientSecond,
            input.thirdPageDescription,
            input.thirdPageDescription)
        
        let recipeDataObs = Observable.combineLatest(firstPage5, secondThrid4, stat.createRecipe) { ($0.0, $0.1, $0.2, $0.3, $0.4, $1.0, $1.1, $1.2, $1.3, $2) }
        
        recipeDataObs
            .subscribe(onNext:{ a,b,c,d,e,f,g,h,i,j in
                var contentArr: [Content] = []
                i.enumerated().forEach { idx, item in
                    contentArr.append(Content.init(step: idx, image: h[idx], text: item))
                }
                var ingredientsArr: [Ingredient] = []
                f.forEach { item in
                    ingredientsArr.append(Ingredient(ingredient: item[0], amount: item[1]))
                }
                var codimentsArr: [Condiment] = []
                g.forEach { item in
                    codimentsArr.append(Condiment(condiment: item[0], amount: item[1]))
                }
                let data = RecipeData(title: a, serving: Int(c) ?? 0, description: d, level: e, categoryId: 1, contents: contentArr, ingredients: ingredientsArr, condiments: codimentsArr)
                dump(data)
                CreateRecipeAPI.shared.uploadRecipeAPI(userId: "userId", recipedata: data) { result in
                    switch result {
                    case .success(let res):
                        print("🟢CreateRecipeAPI.shared.uploadRecipeAPI success res: \(res)")
                    case .failure(let err):
                        print("🔴CreateRecipeAPI.shared.uploadRecipeAPI err: \(err)")
                    }
                }
                
            })
            .disposed(by: disposeBag)
        
    }
}
