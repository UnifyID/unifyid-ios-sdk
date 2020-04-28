// Copyright © 2019 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.

import UIKit
import UnifyID

class UnifyVC : UIViewController
{
    static var unify : UnifyID?

    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

    func styledButton(_ title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    internal func styledLabel(text: String, style: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: style)
        return label
    }

    static var alertQueue : OperationQueue = {
        let alertQueue = OperationQueue()
        alertQueue.maxConcurrentOperationCount = 1
        alertQueue.underlyingQueue = DispatchQueue.main
        return alertQueue
    }()

    var stack : UIStackView?
    var backView : UIImageView?

    func addViews(_ append: [UIView] = [])
    {
        // Back
        backView = UIImageView(image: UIImage(named: "wave-bg"))
        backView!.contentMode = .bottom
        view.addSubview(backView!)

        // Stack
        var views : [UIView] = [
            UIImageView(image: UIImage(named: "logo")),
            styledLabel(text: "v\(appVersion)", style: .title3)
        ]
        views.append(contentsOf: append)
        view.backgroundColor = UIColor.white
        stack = UIStackView(arrangedSubviews: views)
        stack!.axis = .vertical
        stack!.distribution = .fill
        stack!.spacing = 12
        stack!.alignment = .leading
        view.addSubview(stack!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let stack = stack, let superview = stack.superview {
            let bounds = superview.bounds.inset(by: UIEdgeInsets(top: 50, left: 12, bottom: 25, right: 12))
            let size = stack.systemLayoutSizeFitting(bounds.size)
            stack.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: size.height)
        }
        if let backView = backView, let superview = backView.superview {
            backView.frame = superview.bounds
        }
    }

    func alert(_ title: String,
               message: String? = nil,
               actions: AlertActions = [{ _ in UIAlertAction(title: "OK", style: .cancel, handler: nil) }],
               textFields: TextFields = []
    )
    {
        Self.alertQueue.addOperation {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            textFields.forEach { alert.addTextField(configurationHandler: $0) }
            actions.forEach { alert.addAction($0(alert)) }
            Self.alertQueue.isSuspended = true
            self.present(alert, animated: true, completion: {
                Self.alertQueue.isSuspended = false
            })
        }
    }

    typealias AlertActions = [(UIAlertController) -> UIAlertAction]
    typealias TextFields = [(UITextField) -> Void]

    func handleError(_ title: String,
                     message: String? = nil,
                     error: Error? = nil,
                     actions: AlertActions? = nil,
                     textFields: TextFields? = nil)
    {
        alert(title, message: message ?? error?.localizedDescription)
    }

    func setAlert(_ title: String,
                  message: String? = nil,
                  value: String? = nil,
                  actions: AlertActions = [],
                  completion: @escaping ((String?) -> Bool)
    ) {
        let replay = {
            self.setAlert(title, message: message, value: value, completion: completion)
        }
        var defaultActions : AlertActions = [
        { alert in
            UIAlertAction(title: "Set", style: .default) { (_) in
                if !completion(alert.textFields?[0].text) {
                    // Invalid value, ask again
                    replay()
                }
            }
        },
        ]
        defaultActions.append(contentsOf: actions)
        alert(title, message: message, actions: defaultActions, textFields: [
            { textfield in
                textfield.placeholder = title
                textfield.text = value
            }])
    }

    func updateButton(_ button : UIButton, _ title : String, _ value : String) {
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byTruncatingMiddle
        button.setTitle("\(title):\n\(value)", for: .normal)
    }

    func openSettings(_ message: String = "You must first initialize SDK") {
        alert("Initialize SDK",
              message: message,
              actions: [{ _ in
                UIAlertAction(title: "Go to settings", style: .default) { (_) in
                    let tab = self.tabBarController!
                    let index = tab.viewControllers!.firstIndex { $0 as? SettingsVC != nil }!
                    tab.selectedIndex = index
                }
                }])
    }
}

