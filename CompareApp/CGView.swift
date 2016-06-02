

import UIKit

class CGView: UIView {

    var m_context:CGContextRef? // 筆+記事本
    
    
//MARK: - Override Function
//------------------------------------
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        m_context = UIGraphicsGetCurrentContext() //初始化 筆+記事本 

        //triangle 繪製三角形
        self.setContentColor(UIColor(red:1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        self.drawTriangle(CGPoint(x: 0, y: 0), size: CGSize(width: self.frame.size.width , height: self.frame.size.width), isFill: true)
        
    }

//MARK: - setContentColor 配置繪製顏色
//------------------------------------
    func setContentColor(color:UIColor){
        //欲複製圖像層級(顏色,邊框,透明度...)使用 CG...
        let component = CGColorGetComponents(color.CGColor)
        CGContextSetRGBFillColor(m_context, component[0], component[1], component[2], 1.0)
        CGContextSetRGBStrokeColor(m_context, component[0], component[1], component[2], 1.0)
    }
    
    
//MARK: - drawTriangle 繪製三角形的方法
//------------------------------------
    func drawTriangle(on:CGPoint,size:CGSize,isFill:Bool) {
        
        CGContextMoveToPoint(m_context, on.x + size.width/2, on.y)
        CGContextAddLineToPoint(m_context, on.x + size.width, on.y + size.height)
        CGContextAddLineToPoint(m_context, on.x, on.y + size.height)
        CGContextAddLineToPoint(m_context, on.x + size.width/2, on.y)

        if isFill{
            
            CGContextFillPath(m_context)
        }
        else{
            
            CGContextStrokePath(m_context)
        }
        
}//end class


}
