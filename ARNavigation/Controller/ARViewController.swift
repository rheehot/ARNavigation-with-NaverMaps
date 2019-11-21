//
//  ARViewController.swift
//  ARNavigation
//
//  Created by youngjun goo on 2019/11/13.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import CoreLocation


class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var arSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arSceneView.delegate = self
        arSceneView.showsStatistics = true
        arSceneView.scene = SCNScene()
        let circleNode = createSphereNode(with: 0.2, color: .blue)
        circleNode.position = SCNVector3(0, 0, -1)
        arSceneView.scene.rootNode.addChildNode(circleNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arSceneView.session.pause()
    }
    
    func createSphereNode(with radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
}
