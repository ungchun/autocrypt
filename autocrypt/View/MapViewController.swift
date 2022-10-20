import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let sesacLocationButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.titleLabel?.text = "접종센터로"
        return button
    }()
    let myLocationButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.titleLabel?.text = "현재위치로"
        return button
    }()
    let mapView = MKMapView()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
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
        mapView.addSubview(sesacLocationButton)
        
        

        mapView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-140)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        sesacLocationButton.snp.makeConstraints { make in
            make.top.equalTo(myLocationButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        
    
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
