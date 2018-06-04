//
//  DrawingViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/3/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import ChromaColorPicker

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var drawImageView: UIImageView!
    private var lastPoint = CGPoint(x: 0, y: 0)
    private var currentColor = UIColor.blue.cgColor
    private var brushSize: Float = 10.0
    private var colorPicker: ChromaColorPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func colorTapped(_ sender: Any) {
    }
    
    @IBAction func sizeTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Brush Size", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        let slider = UISlider(frame: CGRect(x: 10, y: 50, width: 250, height: 80))
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = brushSize
        alertController.view.addSubview(slider)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.brushSize = slider.value
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func eraseTapped(_ sender: Any) {
        currentColor = UIColor.white.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let beginPoint = touches.first?.location(in: drawImageView) {
            lastPoint = beginPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let endPoint = touches.first?.location(in: drawImageView) {
            drawBetweenTwoPoints(p1: lastPoint, p2: endPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let movedPoint = touches.first?.location(in: drawImageView) {
            drawBetweenTwoPoints(p1: lastPoint, p2: movedPoint)
            lastPoint = movedPoint
        }
    }

    func drawBetweenTwoPoints(p1: CGPoint, p2: CGPoint) {
        UIGraphicsBeginImageContext(drawImageView.frame.size)
        drawImageView.image?.draw(in: CGRect(x: 0, y: 0, width: drawImageView.frame.size.width, height: drawImageView.frame.size.height))
        if let context = UIGraphicsGetCurrentContext() {
            context.move(to: p1)
            context.addLine(to: p2)
            context.setLineWidth(CGFloat(brushSize))
            context.setLineCap(.round)
            context.setStrokeColor(currentColor)
            context.strokePath()
            drawImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
    }
}
