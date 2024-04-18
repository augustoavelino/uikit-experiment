//
//  ColorPickerView.swift
//  uikit-experiment
//
//  Created by Augusto Avelino on 18/04/24.
//

import UIKit

protocol ColorPickerViewDelegate: AnyObject {
    func colorPicker(_ colorPicker: ColorPickerView, didSelectColor color: UIColor?)
}

class ColorPickerView: UIView {
    
    // MARK: Props
    
    weak var delegate: ColorPickerViewDelegate?
    
    // MARK: UI
    
    let gradientView: ColorPickerGradientView = {
        let gradientView = ColorPickerGradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    let scopeView: UIView = {
        let scopeView = UIImageView(image: UIImage(systemName: "scope"))
        scopeView.tintColor = .lightGray
        scopeView.translatesAutoresizingMaskIntoConstraints = false
        scopeView.contentMode = .scaleAspectFit
        scopeView.layer.compositingFilter = "linearDodgeBlendMode"
        return scopeView
    }()
    var scopeCenterXConstraint: NSLayoutConstraint?
    var scopeCenterYConstraint: NSLayoutConstraint?
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        setupGradientView()
        setupScopeView()
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.0
    }
    
    private func setupGradientView() {
        addSubview(gradientView)
        gradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupScopeView() {
        addSubview(scopeView)
        scopeView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        scopeView.heightAnchor.constraint(equalTo: scopeView.widthAnchor).isActive = true
        scopeCenterXConstraint = scopeView.centerXAnchor.constraint(equalTo: leadingAnchor)
        scopeCenterYConstraint = scopeView.centerYAnchor.constraint(equalTo: topAnchor)
        scopeCenterXConstraint?.isActive = true
        scopeCenterYConstraint?.isActive = true
    }
    
    // MARK: - Actions
    
    fileprivate func limitPoint(_ point: CGPoint) -> CGPoint {
        let x = max(1.0, min(point.x, bounds.width - 1.0))
        let y = max(1.0, min(point.y, bounds.height - 1.0))
        return CGPoint(x: x, y: y)
    }
    
    fileprivate func moveScope(to point: CGPoint) {
        scopeCenterXConstraint?.constant = point.x
        scopeCenterYConstraint?.constant = point.y
    }
    
    fileprivate func getColor(of point: CGPoint) -> UIColor? {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        guard let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        context.translateBy(x: -point.x, y: -point.y)
        gradientView.layer.render(in: context)
        
        let red = CGFloat(pixel[0]) / 255.0
        let green = CGFloat(pixel[1]) / 255.0
        let blue = CGFloat(pixel[2]) / 255.0
        let alpha = CGFloat(pixel[3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleTouch(touches.first)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        handleTouch(touches.first)
    }
    
    private func handleTouch(_ touch: UITouch?) {
        guard let touch = touch else { return }
        let location = touch.location(in: self)
        let limitedPoint = limitPoint(location)
        moveScope(to: limitedPoint)
        let color = getColor(of: limitedPoint)
        delegate?.colorPicker(self, didSelectColor: color)
    }
}
