import Foundation

struct CenterData: Codable {
    let currentCount: Int
    let data: [Datum]
    let matchCount, page, perPage, totalCount: Int
}

struct Datum: Codable {
    let address, centerName: String
    let centerType: CenterType
    let createdAt, facilityName: String
    let id: Int
    let lat, lng, org, phoneNumber: String
    let sido, sigungu, updatedAt, zipCode: String
}

enum CenterType: String, Codable {
    case 중앙권역 = "중앙/권역"
    case 지역 = "지역"
}
