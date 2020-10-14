import UIKit

struct MessageType {
    var type: ToastView.ToastType!
    var message: String!
}

extension MessageType: Equatable {
    static func == (lhs: MessageType, rhs: MessageType) -> Bool {
        return lhs.type == rhs.type &&
            lhs.message == rhs.message
    }
}

struct Queue {
    var items: [MessageType] = []
    mutating func enqueue(element: MessageType) {
        items.append(element)
    }
    mutating func dequeue() -> MessageType? {
        if items.isEmpty {
            return nil
        } else {
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
}

public class ToastViewConstant {
    private init() {}
    public static let heightToastView: CGFloat = 108.0
    public static var yDefaultOrigin: CGFloat = -heightToastView
    public static var timeRunAnimation: TimeInterval = 0.5
    public static var delayTime: TimeInterval = 2.0
}

public class ToastMessages {
    private init() {}
    private var isShowing: Bool = false
    var toastView: ToastView!
    var messageQueue: Queue = Queue()
    var viewController: UIViewController!
    public  static let shared = ToastMessages()

    public func show(messge: String,
                     type: ToastView.ToastType,
                     from viewController: UIViewController) {
        self.viewController = viewController
        let messageType = MessageType(type: type, message: messge)

        if self.isShowing {
            messageQueue.enqueue(element: messageType)
        } else {
            self.showToastView(messageType: messageType,
                               from: viewController)
        }
    }
    private func showToastView(messageType: MessageType,
                               from viewController: UIViewController) {
        if self.toastView == nil {
            let rect = CGRect(x: 0,
                              y: ToastViewConstant.yDefaultOrigin,
                              width: viewController.view.frame.width,
                              height: ToastViewConstant.heightToastView)
            toastView = ToastView(frame: rect)
        }
        self.isShowing = true
        toastView.message = messageType.message
        toastView.type = messageType.type
        viewController.view.addSubview(toastView)
        self.runAnimation()
    }

    private func runAnimation() {
        guard toastView != nil else { return }
        UIView.animate(withDuration: ToastViewConstant.timeRunAnimation) {
            self.toastView.frame.origin.y = self.caculatePositionY()
        }

        UIView.animate(withDuration: ToastViewConstant.timeRunAnimation,
                       delay: ToastViewConstant.delayTime,
                       options: [],
                       animations: {
                        self.toastView.frame.origin.y = ToastViewConstant.yDefaultOrigin
        }, completion: { _ in
            self.toastView.removeFromSuperview()
            self.toastView = nil
            self.isShowing = false
            self.checkQueue()
        })
    }

    private func checkQueue() {
        guard let messageType = self.messageQueue.dequeue(),
            let viewVC = self.viewController else { return }
        self.showToastView(messageType: messageType,
                           from: viewVC)
    }

    private func caculatePositionY() -> CGFloat {
        guard let viewController = self.viewController,
            let navigation = viewController.navigationController else { return 0.0}
        if navigation.navigationBar.isHidden {
            return 0
        } else {
            return viewController.topbarHeight
        }
    }
}

public extension UIViewController {
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
            return topBarHeight
        }
    }
}
