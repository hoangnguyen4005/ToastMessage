import UIKit

public class ToastView: UIView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    public enum ToastType {
        case warning
        case failure
        case success
    }
    var type: ToastType = .success {
        didSet {
            var backgroundColor: UIColor!
            switch type {
            case .success:
                backgroundColor = UIColor(red: 63.0/255.0, green: 156.0/255.0, blue: 53.0/255.0, alpha: 1.0)
            case .failure:
                backgroundColor = UIColor.red
            case .warning:
                backgroundColor = UIColor.orange
            }
            self.containView.backgroundColor = backgroundColor
            
            /*
             TO-DO:
             we can set image here
             self.imageView.image = image
             */
        }
    }
    public var message: String? = nil {
        willSet(value) {
            self.titleLabel.text = value
        }
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }

    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// :nodoc:
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
        _ = fromNib(nibName: String(describing: ToastView.self), isInherited: true)
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = .byWordWrapping
    }
}
