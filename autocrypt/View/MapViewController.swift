import UIKit
import MapKit
import SnapKit
import RxCocoa
import RxSwift

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let centerLocationButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("접종센터로", for: .normal)
        return button
    }()
    let myLocationButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("현재위치로", for: .normal)
        return button
    }()
    let mapView = MKMapView()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    var latitude: Double?
    var longitude: Double?
    private let disposeBag = DisposeBag()
    private let status = CLLocationManager().authorizationStatus
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "지도"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        view.addSubview(mapView)
        
        mapView.addSubview(myLocationButton)
        mapView.addSubview(centerLocationButton)
        
        

        mapView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-140)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        centerLocationButton.snp.makeConstraints { make in
            make.top.equalTo(myLocationButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        centerLocationButton.rx.tap
            .bind { [weak self] in
                let coordinate = CLLocationCoordinate2D(latitude: (self?.latitude)!, longitude: (self?.longitude)!)
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self?.mapView.setRegion(region, animated: true)
            }
            .disposed(by: disposeBag)
        
        myLocationButton.rx.tap
            .bind { [weak self] in
                if self?.status == .authorizedAlways || self?.status == .authorizedWhenInUse {
                    self?.currentLocation = self?.locationManager?.location?.coordinate
                    let coordinate = CLLocationCoordinate2D(latitude: (self?.currentLocation?.latitude)!, longitude: (self?.currentLocation?.longitude)!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    self?.mapView.setRegion(region, animated: true)
                } else {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
            .disposed(by: disposeBag)
        
    
        // 처음에는 대구광역시로 세팅
        let coordinate = CLLocationCoordinate2D(latitude: 35.8714354, longitude: 128.601445)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //location5
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager?.startUpdatingLocation() // 중요!
            
            guard let locationManager else { return }
            currentLocation = locationManager.location?.coordinate
            guard let currentLocation else { return }
            let coordinate = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied:
            print("GPS 권한 요청 거부됨")
        default:
            print("GPS: Default")
        }
    }
}
