//
//  ViewController.swift
//  MLForKids
//
//  Created by Suman Sigdel on 2/6/20.
//  Copyright © 2020 Suman Sigdel. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var canvasView: Canvas!
    var requests = [VNRequest]()
    
    

    @IBAction func checkButton(_ sender: UIButton) {
        let image = UIImage(view: canvasView)
        let scaledImage = scaleImage(image: image, toSize: CGSize(width: 28, height: 28))
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaledImage.cgImage!, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        }
        catch {
            print(error)
        }
        
    }
    
    func generateRandomNumber() -> Int{
        let firstNum = Int.random(in: 0...10)
        let secondNum = Int.random(in: 0...10)
        
        return firstNum; secondNum
        
    }
    
    
    func scaleImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        canvasView.clearCanvas()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVision()
    }
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: MNISTClassifier().model) else {fatalError("Cannot load vision ML model") }
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        self.requests = [classificationRequest]
    }
    
    func handleClassification (request : VNRequest, error : Error?) {
        guard let observations = request.results else {print("No results"); return}
        let classfications = observations
            .flatMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.9})
            .map({$0.identifier})
        DispatchQueue.main.async {
            self.question.text = classfications.first
        }
        
        
    }


}

