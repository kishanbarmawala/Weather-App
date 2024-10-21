//
//  ProgressHUD.swift
//  GenericNetworkLayer
//
//  Created by Kian on 23/09/21.
//

import UIKit

class ProgressHUD {
    static func show(text: String = "Please wait...") {
        guard let keyWindow = UIWindow.keyWindow() else { return }
        let disableView = UIView()
        disableView.backgroundColor = .clear
        disableView.isUserInteractionEnabled = true
        disableView.frame = UIScreen.main.bounds
        disableView.tag = 1001
        if let disableView = keyWindow.subviews.first(where: {$0.tag == 1001 }) {
            if let loaderView = disableView.subviews.first(where: { $0 is LoaderView }) as? LoaderView {
                loaderView.text = text
            }
        } else {
            let loaderView = LoaderView(text: text)
            loaderView.frame = UIScreen.main.bounds
            disableView.addSubview(loaderView)
            keyWindow.addSubview(disableView)
            loaderView.show()
        }
    }
    
    static func hide(quick : Bool = false) {
        if let disableView = UIWindow.keyWindow()?.subviews.first(where: { $0.tag == 1001 }), let loaderView = disableView.subviews.first(where: { $0 is LoaderView }) as? LoaderView {
            if quick {
                loaderView.hide()
                loaderView.removeFromSuperview()
                disableView.removeFromSuperview()
            } else {
                loaderView.hide {
                    loaderView.removeFromSuperview()
                    disableView.removeFromSuperview()
                }
            }
        }
    }
}

class LoaderView: UIVisualEffectView {

    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    let containerView: UIView
    let animationDuration: TimeInterval = 0.25
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        self.containerView = UIView()
        super.init(effect: blurEffect)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        self.containerView = UIView()
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(containerView)
        containerView.addSubview(activityIndictor)
        containerView.addSubview(label)
        activityIndictor.startAnimating()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = self.superview {
            
            let fontAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
            let size = (text! as NSString).size(withAttributes: fontAttributes)
            
            let width : CGFloat = size.width + 65
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2, y: superview.frame.height / 2 - height / 2, width: width, height: height)
            vibrancyView.frame = self.bounds
            vibrancyView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            containerView.frame = vibrancyView.frame
            containerView.backgroundColor = .clear
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: 5, y: height / 2 - activityIndicatorSize / 2, width: activityIndicatorSize, height: activityIndicatorSize)

            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5, y: 0, width: width - activityIndicatorSize - 15, height: height)
            label.textColor = UIColor.darkGray
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }

    func show() {
        self.isUserInteractionEnabled = false
        self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        self.isHidden = false
        UIView.animate(withDuration: animationDuration) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    func hide(onCompletion: (() -> ())? = nil) {
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: animationDuration) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        } completion: { _ in
            self.isHidden = true
            onCompletion?()
        }
    }
}
