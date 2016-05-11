//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"
func RGB(R:CGFloat,G:CGFloat,B:CGFloat)->UIColor{
    return RGBA(R, G: G, B: B, A: 1.0)
}

func RGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat)->UIColor{
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}

arc4random()

func title(str:String)->String{
    return str;
}

daylight

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
containerView.backgroundColor = UIColor.whiteColor()
XCPShowView("containerView", view: containerView)

var nav_View:UIView = UIView.init(frame: CGRectMake(0, 0, 320, 64))
nav_View.backgroundColor = RGB(150, G: 100, B: 65)
containerView.addSubview(nav_View)

var label:UILabel = UILabel.init(frame: CGRectMake(110, 30, 100, 20))
label.text = title("聚赢宝商城")
label.textAlignment = NSTextAlignment.Center
label.textColor = UIColor.whiteColor()

var leftItem:UIButton = UIButton.init(frame: CGRectMake(8, 30, 30, 20))
leftItem.setTitle("<", forState: UIControlState.Normal)
leftItem.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

nav_View.addSubview(leftItem)
nav_View.addSubview(label)


var demoView : UIView = UIView.init(frame: CGRectMake(0, 0, 5, 5))
demoView.center = containerView.center
demoView.backgroundColor = RGB(100, G: 20, B: 100)
demoView.layer.cornerRadius = 2.5
demoView.layer.masksToBounds = true
containerView.addSubview(demoView)

var scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
scaleAnimation.toValue = 50.0
scaleAnimation.duration = 1.0
scaleAnimation.repeatCount = MAXFLOAT

var opacityAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
opacityAnimation.fromValue = 1.0
opacityAnimation.toValue = 0.0
opacityAnimation.duration = 1.0
opacityAnimation.repeatCount = MAXFLOAT

demoView.layer.addAnimation(opacityAnimation, forKey: "opacityAnimation")
demoView.layer.addAnimation(scaleAnimation, forKey: "scaleAnimation")

// MARK:

var msgLabel:UILabel = UILabel.init(frame: CGRectMake(0, 500, 320, 30))
msgLabel.textColor = UIColor.blackColor()
msgLabel.text = "正在咻一咻"
msgLabel.textAlignment = NSTextAlignment.Center
containerView.addSubview(msgLabel)









