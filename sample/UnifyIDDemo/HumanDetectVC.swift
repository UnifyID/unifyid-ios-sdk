// Copyright © 2019 UnifyID, Inc. All rights reserved.
// Unauthorized copying or excerpting via any medium is strictly prohibited.
// Proprietary and confidential.

import UIKit
import HumanDetect

class HumanDetectVC : UnifyVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews([
            styledButton("Generate HumanDetect Token", selector: #selector(generateHumanToken))
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let humanDetect = Self.unify?.humanDetect {
            humanDetect.startPassiveCapture()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let humanDetect = Self.unify?.humanDetect {
            humanDetect.stopPassiveCapture()
        }
    }

    @objc func generateHumanToken() {
        guard let humanDetect = Self.unify?.humanDetect else {
            openSettings()
            return
        }
        do {
            let detectToken = try humanDetect.getPassive(identifier: "Testing").get()
            alert("Success", message: detectToken.token, actions: [
                { _ in
                    UIAlertAction(title: "Copy", style: .default, handler: { (_) in
                        UIPasteboard.general.string = detectToken.token
                    })
                },
                { _ in
                    UIAlertAction(title: "OK", style: .default, handler: nil)
                }
            ])
        } catch (let error) {
            handleError("HumanDetect Generate Failed", error: error)
        }
    }
}
