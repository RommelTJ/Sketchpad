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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
