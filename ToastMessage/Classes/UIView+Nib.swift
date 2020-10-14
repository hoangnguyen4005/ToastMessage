import Foundation
import UIKit

// MARK: NIB
extension UIView {

    func fromNib<T: UIView>(nibName: String, isInherited: Bool = false) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let contentView =  bundle.loadNibNamed(nibName,
                                                     owner: self,
                                                     options: nil)?.first as? T else {
                                                        return nil
        }
        contentView.backgroundColor = .clear
        if isInherited {
            self.insertSubview(contentView, at: 0)
        } else {
            self.addSubview(contentView)
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fixConstraintsInView(self)
        return contentView
    }

    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal, toItem: container,
                           attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal, toItem: container,
                           attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal, toItem: container,
                           attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal, toItem: container,
                           attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

    // swiftlint:disable function_parameter_count
    func createDottedLine(width: CGFloat,
                          color: CGColor,
                          startX: CGFloat,
                          startY: CGFloat,
                          endX: CGFloat,
                          endY: CGFloat,
                          lineDashPattern: Bool = true) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        if lineDashPattern { caShapeLayer.lineDashPattern = [7, 5] }
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: startX, y: startY), CGPoint(x: endX, y: endY)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
}

