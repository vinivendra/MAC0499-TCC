
import UIKit


enum Orientation {
    case Horizontal
    case Vertical
}


let fromViewMargin: CGFloat = 10
let edgesMargin: CGFloat = 2 * fromViewMargin
let totalMargin = fromViewMargin + edgesMargin


class MenuView: UIView {

    convenience init(fromView: UIView, inView: UIView) {

        let availableWidth = inView.frame.size.width
        let availableHeight = inView.frame.size.height

        let fromViewFrame = inView.convertRect(fromView.frame,
                                               fromView: fromView.superview)
        let fromViewOrigin = fromViewFrame.origin
        let fromViewSize = fromViewFrame.size

        let availableUp = fromViewOrigin.y
        let availableDown = availableHeight - fromViewOrigin.y - fromViewSize.height
        let availableLeft = fromViewOrigin.x
        let availableRight = availableWidth - fromViewOrigin.x - fromViewSize.width

        let originX: CGFloat
        let originY: CGFloat
        let availableX: CGFloat
        let availableY: CGFloat

        if (availableLeft > availableRight) {
            originX = edgesMargin
            availableX = availableLeft - totalMargin
        } else {
            originX = availableWidth - availableRight + fromViewMargin
            availableX = availableWidth - originX - edgesMargin
        }

        if (availableUp > availableDown) {
            originY = edgesMargin
            availableY = availableUp - totalMargin
        } else {
            originY = availableHeight - availableDown + fromViewMargin
            availableY = availableHeight - originY - edgesMargin
        }

        self.init(frame: CGRectMake(originX, originY, availableX, availableY))

        self.backgroundColor = UIColor.whiteColor()
    }

    convenience init(fromView: UIView, inView: UIView, orientation: Orientation) {

        self.init(fromView: fromView, inView: inView)

        let availableWidth = inView.frame.size.width
        let availableHeight = inView.frame.size.height

        let originX: CGFloat
        let originY: CGFloat
        let availableX: CGFloat
        let availableY: CGFloat

        if (orientation == .Horizontal) {
            originY = edgesMargin
            availableY = availableHeight - totalMargin
            originX = self.frame.origin.x
            availableX = self.frame.size.width
        }
        else {
            originX = edgesMargin
            availableX = availableWidth - totalMargin
            originY = self.frame.origin.y
            availableY = self.frame.size.height
        }

        self.frame = CGRectMake(originX, originY, availableX, availableY)
    }

}
