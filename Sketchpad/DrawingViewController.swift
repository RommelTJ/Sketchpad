//
//  DrawingViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/3/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var drawImageView: UIImageView!
    private var lastPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func colorTapped(_ sender: Any) {
    }
    
    @IBAction func sizeTapped(_ sender: Any) {
    }
    
    @IBAction func eraseTapped(_ sender: Any) {
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
            context.setLineWidth(10)
            context.setLineCap(.round)
            context.setStrokeColor(UIColor.red.cgColor)
            context.strokePath()
            drawImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
    }
}
