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
    
    let arrow = SCNScene(named: "SceneAsset.scnassets/arrow.scn")?.rootNode
    var center: CGPoint!
    //위치들을 저장할 SCNVector 형 배열
    var positions = [SCNVector3]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arSceneView.delegate = self
        arSceneView.showsStatistics = true
        arSceneView.scene = SCNScene()
        center = view.center
        if let node = arrow {
            arSceneView.scene.rootNode.addChildNode(node)
        } else {
            print("asset data가 존재하지 않습니다.")
        }
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
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
       let hitTest = arSceneView.hitTest(center, types: .featurePoint)
        //마지막 값을 반환
        let result = hitTest.last
        //세계 좌표계와 관련된 히트 테스트 결과의 위치와 방향.
        guard let transform = result?.worldTransform else {
            return
        }
        //3열의 좌표값을 반환
        let thirdColumn = transform.columns.3
        let position = SCNVector3Make(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        positions.append(position)
        // suffic 사용법 : 컬렉션의 최종 요소가 들어있는 지정된 최대 길이까지 하위 시퀀스를 반환
        // 많을 수록 부드러워 진다. --> 쓰레스홀드
        //positions 배열의 하위 10개의 position 인자들을 반환 한다.
        let lastTenPositions = positions.suffix(20)
        //하위 10개의 position들의 평균 position 값을 얻어 반환 한다.
        arrow?.position = getAveragePosition(from: lastTenPositions)
        print(arrow?.position)
    }
    
    func getAveragePosition(from positions: ArraySlice<SCNVector3>) -> SCNVector3 {
        var averageX: Float = 0
        var averageY: Float = 0
        var averageZ: Float = 0
        
        for position in positions {
            averageX += position.x
            averageY += position.y
            averageZ += position.z
        }
        let count = Float(positions.count)
        return SCNVector3Make(averageX / count, averageY / count, averageZ / count)
    }
    
}


