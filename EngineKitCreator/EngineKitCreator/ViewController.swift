// TODO: Create light items and substitute the light nodes for them
// TODO: Allow loading fmt files from javascript, stop loading them from code.

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
    case ChangingProperties
    case ChoosingItem
    case Playing
}


protocol MenuManager {
    func dismissMenu()
}


class ViewController: UIViewController, CallbackDelegate, MenuManager {

    @IBOutlet weak var itemsButton: UIButton!
    @IBOutlet weak var propertiesButton: UIButton!
    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!
    @IBOutlet weak var playButton: UIButton!

    var editorSceneManager: EditorSceneManager?
    var playerSceneManager: PlayerSceneManager?

    var menuView: MenuView?
    var menuController: MenuController?

    var cameraX: Vector?
    var cameraY: Vector?
    var cameraZ: Vector?

    var selectedItem: Item? {
        get {
            return editorSceneManager?.selectedItem
        }
        set {
            editorSceneManager?.selectedItem = newValue
            updatePropertiesButtonForSelectedItem(newValue)
        }
    }

    var state: ViewControllerStates? {
        willSet {
            if (state != newValue) {
                if (state == .Neutral) {            // From neutral
                    if (newValue != .Neutral) {     // To something
                        changeState(state, toState: newValue)
                    }
                }
                else {                              // From something
                    if (newValue == .Neutral) {     // To neutral
                        changeState(state, toState: newValue)
                    }
                    else {                          // To something else
                        changeState(state, toState: .Neutral)
                        changeState(.Neutral, toState: newValue)
                    }
                }
            }
        }
    }

    func changeState(fromState: ViewControllerStates?, toState: ViewControllerStates?) {
        if (fromState == .Neutral) {
            if (toState == .ChoosingObject) {
                menuController = ObjectsMenuController()
                showMenuForButton(objectsButton)
            }
            else if (toState == .ChangingProperties) {
                if let selectedItem = selectedItem {
                    menuController = PropertiesMenuViewController(item: selectedItem)
                    showMenuForButton(propertiesButton)
                }
            }
            else if (toState == .ChoosingItem) {
                let itemController = ItemsMenuViewController()
                itemController.manager = self
                menuController = itemController
                showMenuForButton(itemsButton)
            }
            else if (toState == .Playing) {
                hideUI()
                createPlayScene()
                setupCurrentSceneForPlayer(playerSceneManager!)
                switchToSceneManager(playerSceneManager)
            }
        }
        else if (fromState == .Playing) {
            showUI()
            switchToSceneManager(editorSceneManager)
        }
        else {
            hideMenu()
            updatePropertiesButtonForSelectedItem(selectedItem)
        }
    }

    // MARK: - MenuManager

    func dismissMenu() {
        state = .Neutral
    }

    // MARK: - CallbackDelegate

    func callGestureCallbackForGesture(gesture: UIGestures, state: UIGestureRecognizerState, withArguments arguments: [AnyObject]!) {
        if (gesture == UIGestures.PanGesture && state == UIGestureRecognizerState.Changed) {
            handlePan(arguments)
        }
        if (gesture == UIGestures.TapGesture) {
            handleTap(arguments)
        }
    }

    func callUICallbackForView(view: UIView!, ofType type: UIType) {

    }

    // MARK: Gestures

    func handlePan(arguments: [AnyObject]!) {
        if let numberOfTouches = arguments[2] as? Int,
            items = arguments[1] as? [Item],
            translation = arguments[0] as? Vector {

                if (numberOfTouches == 1) {
                    if (items.count > 0 && items[0] == selectedItem) {
                        moveItem(translation)
                    }
                    else {
                        rotateCamera(translation)
                    }
                }
        }
    }

    func handleTap(arguments: [AnyObject]!) {
        guard (state == .Neutral) else {
            state = .Neutral
            return
        }

        if let items = arguments[0] as? [Item]
            where items.count > 0 {
                if let item = items[0] as? Shape {
                    if (item == selectedItem) {
                        deselectItem(selectedItem!)
                    }
                    else {
                        if (selectedItem != nil) {
                            deselectItem(selectedItem!)
                        }
                        selectItem(item)
                    }
                }
        }
        else {
            if let item = selectedItem {
                deselectItem(item)
            }
        }
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        editorSceneManager = EditorSceneManager()
        switchToSceneManager(editorSceneManager)
        setupCurrentSceneForEditor(editorSceneManager!)

        self.propertiesButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        self.selectedItem = nil

        state = .Neutral
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    // MARK: UI Actions

    func updatePropertiesButtonForSelectedItem(selectedItem: Item?) {
        if (selectedItem != nil) {
            propertiesButton.enabled = true
        }
        else {
            propertiesButton.enabled = false
        }
    }

    func hideUI() {
        hideMenu()
        hideButtons()
        playButton.setTitle("Edit", forState: UIControlState.Normal)
    }

    func showUI() {
        showButtons()
        playButton.setTitle("Play", forState: UIControlState.Normal)
    }

    func hideButtons() {
        objectsButton.hidden = true
        propertiesButton.hidden = true
        itemsButton.hidden = true
    }

    func showButtons() {
        objectsButton.hidden = false
        propertiesButton.hidden = false
        itemsButton.hidden = false
    }

    func hideMenu() {
        menuView?.removeFromSuperview()
    }

    func showMenuForButton(button:UIButton) {
        hideMenu()

        menuView = MenuView(fromView: button, inView: view, orientation: .Vertical, sizeRatio: 0.3)
        menuView?.backgroundColor = UIColor.orangeColor()

        menuController!.setupMenuView(menuView!)

        view.addSubview(menuView!)
    }

    // MARK: Scene Actions

    func createPlayScene() {
        playerSceneManager = PlayerSceneManager()
        editorSceneManager?.scene.deepCopyToScene(playerSceneManager?.scene)
    }

    func switchToSceneManager(sceneManager: SceneManager?) {
        engineKitView.scene = sceneManager?.scene
        sceneManager?.makeCurrentSceneManager()

        if let camera = sceneManager?.camera {
            cameraX = camera.rotation.rotate(Axis.x())
            cameraY = camera.rotation.rotate(Axis.y())
            cameraZ = camera.rotation.rotate(Axis.z())
        }
    }

    func selectItem(item: Item) {
        selectedItem = item
        item.selected = true
    }

    func deselectItem(item: Item) {
        item.selected = false
        selectedItem = nil
    }

    func moveItem(translation: Vector) {
        let resized = translation.times(0.01)

        let translation = cameraX?.times(resized.x)
            .plus(cameraY?.times(resized.y));

        let position = selectedItem?.position as? Position
        selectedItem?.position = position!.plus(translation!)
    }

    func rotateCamera(translation: Vector) {
        let camera = SceneManager.currentSceneManager().camera

        cameraX = camera!.rotation.rotate(Axis.x())
        cameraY = camera!.rotation.rotate(Axis.y())

        let resized = translation.times(0.02)

        let axis: Vector = (cameraX?.times(resized.y).plus(cameraY?.times(-resized.x)))!

        let rot = Rotation.create([axis, resized.normSquared])

        camera!.rotate(rot, around: Position.origin())
    }

    func setupCurrentSceneForEditor(sceneManager: SceneManager) {
        let gestures = sceneManager.gestures

        gestures.sceneView = engineKitView
        gestures.gesturesView = engineKitView

        gestures.setupGestures()

        gestures.delegate = self

        let javaScript = sceneManager.javaScript
        javaScript.load()

        let bola = Sphere.create()
        bola.color = "blue";
        bola.radius = 3
        bola.addAction(["set", "position", "x"],
                       forTrigger: NSNumber(unsignedLong: UIGestures.TapGesture.rawValue),
                       withArguments: -1)
        bola.addAction(["set", "position", "y"],
                        forTrigger: NSNumber(unsignedLong: UIGestures.TapGesture.rawValue),
                        withArguments: -1)
        bola.addAction(["set", "position", "z"],
                forTrigger: NSNumber(unsignedLong: UIGestures.TapGesture.rawValue),
                withArguments: -1)
    }

    func setupCurrentSceneForPlayer(sceneManager: SceneManager) {
        let gestures = sceneManager.gestures

        gestures.sceneView = engineKitView
        gestures.gesturesView = engineKitView

        gestures.setupGestures()

        gestures.delegate = sceneManager.javaScript.triggerActionManager
    }

    // MARK: - IBActions

    @IBAction func playButtonPressed(sender: AnyObject) {
        if (state == .Neutral) {
            state = .Playing
        }
        else {
            state = .Neutral
        }
    }

    @IBAction func itemsButtonTap(sender: AnyObject) {
        if (state == .Neutral) {
            state = .ChoosingItem
        }
        else {
            state = .Neutral
        }
    }

    @IBAction func propertiesButtonTap(sender: AnyObject) {
        if (state == .ChangingProperties) {
            state = .Neutral
        }
        else {
            state = .ChangingProperties
        }
    }
    
    @IBAction func objectsButtonTap(sender: UIView) {
        if (state == .ChoosingObject) {
            state = .Neutral
        }
        else {
            state = .ChoosingObject
        }
    }
    
}

