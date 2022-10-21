import Foundation
import RxSwift
import Alamofire

class APIService {
    static func fetchCenterRx(pageCount: Int) -> Observable<CenterData> {
        
        let url = "https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=10&serviceKey=bNmSjmL3NWL/mAmsQV0SyDT%2B8DCdZckhVg5/tSsmJHa47eBZBE%2BaFvCHYxeM1Dsz2FcgQ64elqYL3mr6GUyjOg%3D%3D"
        
        return Observable<CenterData>.create { emitter in
            AF.request(URL(string: url)!, method: .get)
                .responseDecodable ( of: CenterData.self ) { response in
                    print("response \(response.response?.url)")
                    switch response.result {
                    case let .success(data):
                        print("data \(data)")
                        emitter.onNext(data)
                        emitter.onCompleted()
                    case let .failure(error):
                        print("err \(error)")
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
