import Foundation
import RxSwift
import Alamofire

class APIService {
    static func fetchCenterRx(pageCount: Int) -> Observable<CenterData> {
        let parameters: Parameters = ["page" : pageCount, "perPage" : "10", "serviceKey" : API.AUTH_KEY]
        
        return Observable<CenterData>.create { emitter in
            AF.request(URLManager.get.result, method: .get, parameters: parameters)
                .responseDecodable ( of: CenterData.self ) { response in
                    switch response.result {
                    case let .success(data):
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

enum API {
    static let CENTER_BASE_URL: String = "https://api.odcloud.kr"
    static let CENTER_BASE_PATH: String = "/api/15077586/v1/centers"
    static let AUTH_KEY: String = "bNmSjmL3NWL/mAmsQV0SyDT+8DCdZckhVg5/tSsmJHa47eBZBE+aFvCHYxeM1Dsz2FcgQ64elqYL3mr6GUyjOg=="
}

enum URLManager {
    case get
    var result: String {
        switch self {
        case .get:
            return "\(API.CENTER_BASE_URL)\(API.CENTER_BASE_PATH)"
        }
    }
}
