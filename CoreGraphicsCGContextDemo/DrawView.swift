//
//  DrawView.swift
//  CoreGraphicsCGContextDemo
//
//  Created by Jayden Garrick on 9/12/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

import UIKit

class DrawView: UIView {
    // MARK: - Properties
    var isDrawing = false
    var lastPoint: CGPoint!
    var strokeColor: CGColor = UIColor.red.cgColor
    var strokes = [Stroke]()
    
    let eraseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(erase), for: .touchUpInside)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    // MARK: - Setup
    func setupEraseButton() {
        self.addSubview(eraseButton)
        eraseButton.translatesAutoresizingMaskIntoConstraints = false
        eraseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        eraseButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        eraseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        eraseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else { return }
        setupEraseButton()
        isDrawing = true
        guard let currentPoint = touches.first?.location(in: self) else { return }
        setNeedsDisplay()
        lastPoint = currentPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        guard let currentPoint = touches.first?.location(in: self) else { return }
        let stroke = Stroke(startPoint: lastPoint, endPoint: currentPoint, color: strokeColor)
        lastPoint = currentPoint
        setNeedsDisplay()
        strokes.append(stroke)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else { return }
        isDrawing = false
        guard let currentPoint = touches.first?.location(in: self) else { return }
        let stroke = Stroke(startPoint: lastPoint, endPoint: currentPoint, color: strokeColor)
        strokes.append(stroke)
        setNeedsDisplay()
        lastPoint = nil
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        context.setLineWidth(10)
        
        for stroke in strokes {
            context.beginPath()
            context.move(to: stroke.startPoint)
            context.addLine(to: stroke.endPoint)
            context.setStrokeColor(stroke.color)
            context.strokePath()
        }
        
        // Initialization Code
        setupEraseButton()    
    }
    
    @objc func erase() {
        self.strokes = []
        setNeedsDisplay()
    }
    
}
