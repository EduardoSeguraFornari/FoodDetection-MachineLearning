//
//  ViewController.swift
//  Food Detection
//
//  Created by Eduardo Fornari on 12/04/18.
//  Copyright © 2018 Eduardo Fornari. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var textInformation: TextInformation!
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        self.setTextInformation()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processImage), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func setTextInformation() {
        self.textInformation = TextInformation()
        self.sceneView.addSubview(self.textInformation)
        self.textInformation.translatesAutoresizingMaskIntoConstraints = false
        self.textInformation.topAnchor.constraint(equalTo: self.sceneView.topAnchor, constant: 5).isActive = true
        self.textInformation.rightAnchor.constraint(equalTo: self.sceneView.rightAnchor, constant: -5).isActive = true
        self.textInformation.leftAnchor.constraint(equalTo: self.sceneView.leftAnchor, constant: 5).isActive = true
    }
    
    let model = Food101()
    @objc func processImage() {
        DispatchQueue.global(qos: .background).async {
            let image = self.sceneView.snapshot()

            let size = CGSize(width: 299, height: 299)

            guard let buffer = image.resize(to: size)?.pixelBuffer() else {
                fatalError("Scaling or converting to pixel buffer failed!")
            }

            let model = self.model

            guard let result = try? model.prediction(image: buffer) else {
                fatalError("Prediction failed!")
            }

            let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
            let converted = String(format: "%.2f", confidence)

            DispatchQueue.main.async {
                self.textInformation.text = "\(result.classLabel) - \(converted) %"
            }
        }
    }
}
