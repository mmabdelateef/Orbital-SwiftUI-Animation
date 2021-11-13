//
//  Stars.swift
//  Orbiter
//
//  Created by Mostafa Abdellateef on 11/12/21.
//
// https://stackoverflow.com/a/61711171/3846724
import UIKit
import SwiftUI

struct Stars: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let size = CGSize(width: 824.0, height: 1112.0)
        let host = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))

        let particlesLayer = CAEmitterLayer()
        particlesLayer.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

        host.layer.addSublayer(particlesLayer)
        host.layer.masksToBounds = true

        particlesLayer.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        particlesLayer.emitterShape = .circle
        particlesLayer.emitterPosition = CGPoint(x: 509.4, y: 707.7)
        particlesLayer.emitterSize = CGSize(width: 1648.0, height: 1112.0)
        particlesLayer.emitterMode = .surface
        particlesLayer.renderMode = .oldestLast



        let image1 = createCGImage()

        let cell1 = CAEmitterCell()
        cell1.contents = image1
        cell1.name = "Star"
        cell1.birthRate = 30
        cell1.lifetime = 20.0
        cell1.velocity = 5.0
        cell1.velocityRange = -5.0
        cell1.xAcceleration = 1.0
        cell1.yAcceleration = 3.0
        cell1.emissionRange = 180.0 * (.pi / 180.0)
        cell1.spin = -28.6 * (.pi / 180.0)
        cell1.spinRange = 57.2 * (.pi / 180.0)
        cell1.scale = 0.06
        cell1.scaleRange = 0.3
        cell1.color = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor

        particlesLayer.emitterCells = [cell1]
        return host
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }

    typealias UIViewType = UIView
}


func createCGImage() -> CGImage? {
    let rect = CGRect(origin: .zero, size: CGSize(width: 5, height: 5))
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    UIColor.white.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image?.cgImage
}
