import UIKit
import MapKit
import SnapKit
import RxCocoa
import RxSwift

class MapViewController: UIViewController {
    
    // MARK: Properties
    //
    private let disposeBag = DisposeBag()
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocationCoordinate2D?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Views
    //
    private let centerLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("접종센터로", for: .normal)
        return button
    }()
    private let myLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("현재위치로", for: .normal)
        return button
    }()
    private let mapView = MKMapView()
    
    // MARK: Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
        setupAttribute()
        setupBindings()
    }
    
    // MARK: functions
    //
    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(myLocationButton)
        mapView.addSubview(centerLocationButton)
    }
    private func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-140)
            make.left.equalToSuperview().offset(CommonSize.PaddingValue)
            make.right.equalToSuperview().offset(-CommonSize.PaddingValue)
            make.height.equalTo(50)
        }
        
        centerLocationButton.snp.makeConstraints { make in
            make.top.equalTo(myLocationButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(CommonSize.PaddingValue)
            make.right.equalToSuperview().offset(-CommonSize.PaddingValue)
            make.height.equalTo(50)
        }
    }
    private func setupAttribute() {
        mapView.delegate = self
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.startUpdatingLocation()
        
        setupNavigationBar()
        goCenterLocation()
    }
    private func setupNavigationBar() {
        self.title = "지도"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
    }
    private func setupBindings() {
        centerLocationButton.rx.tap
            .bind { [weak self] in
                self?.goCenterLocation()
            }
            .disposed(by: disposeBag)
        
        myLocationButton.rx.tap
            .bind { [weak self] in
                if CLLocationManager().authorizationStatus == .authorizedAlways || CLLocationManager().authorizationStatus == .authorizedWhenInUse {
                    self?.goMyLocation()
                } else {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
            .disposed(by: disposeBag)
    }
    private func goCenterLocation() {
        guard let latitude = self.latitude else { return }
        guard let longitude = self.longitude else { return }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
    }
    private func goMyLocation() {
        guard let locationManager = self.locationManager else { return }
        self.currentLocation = locationManager.location?.coordinate
        guard let currentLocation = self.currentLocation else { return }
        let coordinate = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied:
            print("GPS 권한 요청 거부됨")
        default:
            print("GPS Default")
        }
    }
}
