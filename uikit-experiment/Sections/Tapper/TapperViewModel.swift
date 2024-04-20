//
//  TapperViewModel.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 20/04/24.
//

import RxCocoa
import RxSwift

protocol TapperViewModelProtocol: AnyObject {
    var counter: BehaviorRelay<Int> { get }
    var incrementValue: BehaviorRelay<Int> { get }
    var increment: PublishRelay<Void> { get }
}

class TapperViewModel: TapperViewModelProtocol {
    let counter = BehaviorRelay<Int>(value: 0)
    let incrementValue = BehaviorRelay<Int>(value: 1)
    let increment = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        increment.withLatestFrom(Observable.combineLatest(counter, incrementValue))
            .map({ $0 + $1 })
            .bind(to: counter)
            .disposed(by: disposeBag)
    }
}
