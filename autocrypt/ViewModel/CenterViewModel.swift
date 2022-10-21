import Foundation
import RxSwift
import RxRelay

class CenterViewModel {
    let disposeBag = DisposeBag()
    
    private var pageCount = 0
    private let perPage = 10
    var isFetch = false
    var isNext = true
    let centerObservable = BehaviorRelay<[Datum]>(value: [])
    
    init() {
        getData()
    }
    
    
    func refreshData() {
        pageCount = 1
        isFetch = true
        APIService.fetchCenterRx(pageCount: pageCount)
            .map {
                $0.data.sorted { $0.updatedAt > $1.updatedAt }
            }
            .subscribe(
                onNext: { [weak self] repo in
                    guard let perPage = self?.perPage else { return }
                    if repo.count < perPage { self?.isNext = false }
                    self?.centerObservable.accept(repo)
                    self?.isFetch = false
                    print("?? repo \(repo)")
                },
                onError: { [weak self] err in
                    print("err \(err)")
                    self?.isFetch = false
                }
            )
            .disposed(by: disposeBag)
    }
    
    func getData() {
        pageCount += 1
        APIService.fetchCenterRx(pageCount: pageCount)
            .map {
                $0.data.sorted { $0.updatedAt > $1.updatedAt }
            }
            .subscribe(
                onNext: { [weak self] repo in
                    
                    
                    self?.centerObservable.accept(((self?.centerObservable.value)!) + repo)
                    self?.isFetch = false
                    print("?? repo \(repo)")
                },
                onError: { [weak self] err in
                    print("err \(err)")
                    self?.isFetch = false
                }
            )
            .disposed(by: disposeBag)
    }
}
