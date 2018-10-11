import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var projectorContents: UIViewController?
    var window: UIWindow?

    @IBAction func putStuffOnPröjector() {
        if projectorContents == nil {
            guard let storyboard = self.storyboard else { return }
            guard let projectorContents = storyboard.instantiateViewController(withIdentifier: ProjectorContentsViewController.storyboardName) as? ProjectorContentsViewController else { return }
            addVCToProjector(projectorContents)
        } else {
            removeVCFromProjector(projectorContents!)
        }
    }

    func hasSecondScreen() -> Bool {
        return UIScreen.screens.count > 1 
    }

    func removeVCFromProjector(_ projectorContents: UIViewController) {
        self.projectorContents?.view.removeFromSuperview()
        window = nil
        self.projectorContents = nil
    }

    func addVCToProjector(_ projectorContents: UIViewController) {
        guard hasSecondScreen() else { return }
        guard let screen = UIScreen.screens.last else { return }
        
        self.projectorContents = projectorContents
        guard let view = projectorContents.view else { return } // forces view load
        view.translatesAutoresizingMaskIntoConstraints = false
#if false
        var max = CGSize.zero
        var maxScreenMode: UIScreenMode? = nil
        for mode in screen.availableModes {
            if mode.size.width * mode.size.height > max.width * max.height {
                max = mode.size
                maxScreenMode = mode
            }
        }
        screen.currentMode = maxScreenMode
#endif
        window = UIWindow()
        window?.screen = screen
        window?.addSubview(view)

        let leftConstraint = view.leftAnchor.constraint(equalTo: window!.leftAnchor)
        let topConstraint = view.topAnchor.constraint(equalTo: window!.topAnchor)
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: window!.bottomAnchor)
        let rightConstraint = view.rightAnchor.constraint(equalTo: window!.rightAnchor)
        
        NSLayoutConstraint.activate([leftConstraint, topConstraint, 
                                     bottomConstraint, rightConstraint])
        window?.isHidden = false
    }
}

