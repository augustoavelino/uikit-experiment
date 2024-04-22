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
    var incrementValueRelay: BehaviorRelay<Int> { get }
    var incrementRelay: PublishRelay<Void> { get }
}

class TapperViewModel: TapperViewModelProtocol {
    let counter = BehaviorRelay<Int>(value: 0)
    let incrementValueRelay = BehaviorRelay<Int>(value: 1)
    let incrementRelay = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        incrementRelay
            .withLatestFrom(Observable.combineLatest(counter, incrementValueRelay))
            .map({ $0 + $1 })
            .bind(to: counter)
            .disposed(by: disposeBag)
    }
}
