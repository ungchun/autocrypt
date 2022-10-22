import Foundation
import RxSwift
import RxRelay

class CenterViewModel {
    
    let disposeBag = DisposeBag()
    let centerObservable = BehaviorRelay<[Datum]>(value: [])
    private var pageCount = 0
    private let perPage = 10
    var isNext = true
    var isFetch = false
    
    init() {
        getCenterData()
    }
    
    func getCenterData() {
        pageCount += 1
        isFetch = true
        callAPIService(refreshCheck: false)
    }
    
    func refreshData() {
        pageCount = 1
        isFetch = true
        callAPIService(refreshCheck: true)
    }
    
    func callAPIService(refreshCheck: Bool) {
        APIService.fetchCenterRx(pageCount: pageCount)
            .map {
                $0.data.sorted { $0.updatedAt > $1.updatedAt }
            }
            .subscribe(
                onNext: { [weak self] repo in
                    guard let perPage = self?.perPage else { return }
                    if repo.count < perPage { self?.isNext = false }

                    refreshCheck ? self?.centerObservable.accept(repo)
                    : self?.centerObservable.accept(((self?.centerObservable.value)! + repo)
                        .sorted {
                            $0.updatedAt > $1.updatedAt
                        })
                    
                    self?.isFetch = false
                },
                onError: { [weak self] err in
                    self?.isFetch = false
                }
            )
            .disposed(by: disposeBag)
    }
}
