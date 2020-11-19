//
//  ViewController.swift
//  WearMask
//
//  Created by Alexey Antonov on 16/11/20.
//

import UIKit
import ARKit

class WearMaskViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !ARFaceTrackingConfiguration.isSupported {
            fatalError("Face tracking is not supported")
        }
        
        sceneView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.run(ARFaceTrackingConfiguration())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
}

extension WearMaskViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        if let url = Bundle.main.url(forResource: "mask", withExtension: "obj", subdirectory: "Models.scnassets"),
           let overlay = SCNReferenceNode(url: url) {
            overlay.load()
            
            let node = SCNNode()
            node.addChildNode(overlay)
            return node
        } else {
            return nil
        }
    }
    
}
