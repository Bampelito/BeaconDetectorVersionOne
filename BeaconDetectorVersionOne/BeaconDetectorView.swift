//
//  BeaconDetectorView.swift
//  BeaconDetectorVersionOne
//
//  Created by TESTING on 22/01/2020.
//  Copyright © 2020 TESTING. All rights reserved.
//

import Combine
import CoreLocation
import SwiftUI

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {
    let objectWillChange = ObservableObjectPublisher()
    var locationManager: CLLocationManager?
    var lastDistance = CLProximity.unknown
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    enum BeaconsUUID: String{
        case FPV = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
        case EF = "B5B182C7-EAB1-4988-AA99-B5C1517008D9"
        case PRF = "74278BDA-B644-4520-8F0C-720EAF059935"
    }
    
    enum BeaconsMajor: Int{
        case FPV = 0
        case EF = 2
        case PRF = 3
    }
    
    enum BeaconsMinor: Int{
        case FPV = 0
        case EF = 2
        case PRF = 3
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        //let uuid = UUID(uuidString: "B5B182C7-EAB1-4988-AA99-B5C1517008D9")!
        let uuid = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 100, minor: 101)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "MyBeacon1")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        }
        else {
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity) {
        lastDistance = distance
        self.objectWillChange.send()
    }
}

struct BigText: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.system(size: 72, design: .rounded))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct BeaconDetectorView: View {
    @ObservedObject var detector = BeaconDetector()
    
    var body: some View {
        if detector.lastDistance == .immediate {
           return Text("RIGHT HERE!")
            .modifier(BigText())
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
        } else if detector.lastDistance == .near{
           return Text("NEAR")
            .modifier(BigText())
                .background(Color.orange)
                .edgesIgnoringSafeArea(.all)
        } else if detector.lastDistance == .far {
           return Text("FAR")
            .modifier(BigText())
                .background(Color.blue)
                .edgesIgnoringSafeArea(.all)
        } else {
           return Text("UNKNOWN")
            .modifier(BigText())
                .background(Color.gray)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BeaconDetectorView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetectorView()
    }
}
