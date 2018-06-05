//
//  DrawingViewController.swift
//  Sketchpad
//
//  Created by Rommel Rico on 6/3/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import ChromaColorPicker

class DrawingViewController: UIViewController, ChromaColorPickerDelegate {
    
    @IBOutlet weak var drawImageView: UIImageView!
    private var lastPoint = CGPoint(x: 0, y: 0)
    private var currentColor = UIColor.blue.cgColor
    private var brushSize: Float = 10.0
    private var colorPicker: ChromaColorPicker?
    private var greyedOut = UIView()
    @IBOutlet weak var controlStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Greyed out view
        greyedOut.frame = view.frame
        greyedOut.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(greyedOut)
        greyedOut.isHidden = true
        
        // Setting up the color picker
        colorPicker = ChromaColorPicker(frame: CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height/2 - 100, width: 200, height: 200))
        if let picker = colorPicker {
            picker.delegate = self
            picker.padding = 5
            picker.stroke = 3
            picker.hexLabel.isHidden = true
            view.addSubview(picker)
        }
        colorPicker?.isHidden = true
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Name your picture", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "My Masterpiece"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let name = alertController.textFields?.first?.text {
                if name != "" {
                    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                        let picture = Picture(context: context)
                        picture.name = name
                        if let image = self.drawImageView.image {
                            picture.image = UIImageJPEGRepresentation(image, 1.0)
                            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            // TODO.
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func colorTapped(_ sender: Any) {
        colorPicker?.adjustToColor(UIColor(cgColor: currentColor))
        colorPicker?.isHidden = false
        greyedOut.isHidden = false
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
        controlStackView.isHidden = true
        if let beginPoint = touches.first?.location(in: drawImageView) {
            lastPoint = beginPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlStackView.isHidden = false
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
    
    // MARK: ChromaColorPickerDelegate
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        currentColor = color.cgColor
        colorPicker.isHidden = true
        greyedOut.isHidden = true
    }
}
