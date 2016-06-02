

import UIKit

class CompareImageViewTouchEvent: UIImageView {
    
    var isOpen:Bool = false
    
//MARK: - Override Function
//--------------------------------
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = frame
        self.userInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        UIView.transitionWithView(self, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
                
            self.image = UIImage(named: "black.png")
            self.isOpen = true;
            self.userInteractionEnabled = false
            }, completion: nil)
        
    }
    
    
}//end class
