//
//  ARViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/13.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import ARKit
import ARCL
import CoreLocation


class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneLocationView = SceneLocationView()
    private var drivingPath: [[Double]] = []
    private var locationNode = [LocationAnnotationNode]()
    // didLoad -> getPath -> viewWillAppear 순으로 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getDrivePath(_ pathData: [[Double]]) {
        self.drivingPath = pathData
        print("getPath")
        drivingPath.forEach { (path) in
            let coordinate = CLLocationCoordinate2D(latitude: path.last!, longitude: path.first!)
            let location = CLLocation(coordinate: coordinate, altitude: 50)
            let image = UIImage(named: "pin")!
            locationNode.append(LocationAnnotationNode(location: location, image: image))
        }
        self.locationNode.forEach {
            self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: $0)
        }
        // TODO: ARCL의 addRoutes함수의 경우 MKRout를 매개변수로 받는다 이를 적절하게 변형을 하던지 아니면 extension 을 통해 NMKLatlng를 입력받아 추가할 수 있게 해야한다.
        // 
        // sceneLocationView.addRoutes(routes: <#T##[MKRoute]#>)
        return
    }
}
