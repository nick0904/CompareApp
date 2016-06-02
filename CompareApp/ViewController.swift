

import UIKit

class ViewController: UIViewController {
    
    var m_compareBt:UIButton?//進入poker畫面的按鈕
    var m_lotteryBt:UIButton?//進入lottery畫面的按鈕
    var compareVC:CompareViewController? //切換至抽牌頁面
    var lotteryVC:LotteryViewController? //切換至樂透球頁面
    
    //MARK: - Normal Function
    //-----------------------
    func refreash(frame:CGRect){
        
        self.view.frame = frame
        
        //************  backgroundImgView  **************
        let backgroundImgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backgroundImgView.image = UIImage(named: "background.jpg")
        self.view.addSubview(backgroundImgView)
        
        //************  porker  **************
        //compareLabel
        var compareLabel:UILabel? = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width/3.5))
        compareLabel!.center = CGPoint(x: frame.size.width/2, y: frame.size.height/8)
        compareLabel!.textColor = UIColor.whiteColor()
        compareLabel!.textAlignment = NSTextAlignment.Center
        compareLabel!.text = "Poker"
        compareLabel?.adjustsFontSizeToFitWidth = true
        compareLabel!.font = UIFont.systemFontOfSize(frame.size.width/7)
        self.view.addSubview(compareLabel!)
        
        //compareView
        let compareView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/4))
        compareView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/8*3)
        compareView.backgroundColor = UIColor(red:0.0 , green: 0.9, blue: 0.85, alpha: 0.66)
        self.view.addSubview(compareView)
        
        //compareLabel(upon compareView)
        compareLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: frame.size.height/4))
        compareLabel!.center = CGPoint(x: compareView.center.x, y: compareView.center.y-20)
        compareLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        compareLabel?.numberOfLines = 0
        compareLabel?.textAlignment = NSTextAlignment.Center
        compareLabel?.textColor = UIColor.whiteColor()
        compareLabel?.text =
        "抽牌比大小\n 玩家1 - 玩家2 各選一張牌\n 雙方選定後按下 VS 觀看比較結果"
        compareLabel?.font = UIFont.systemFontOfSize(frame.size.width/20)
        self.view.addSubview(compareLabel!)
        
        //compareBt
        m_compareBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/4, height: self.view.frame.size.width/10))
        m_compareBt!.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2 - 30)
        m_compareBt?.layer.cornerRadius = m_compareBt!.frame.size.width/5
        m_compareBt?.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.85, alpha: 1.0)
        m_compareBt?.setTitle("Start", forState: UIControlState.Normal)
        m_compareBt?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        m_compareBt?.showsTouchWhenHighlighted = true
        m_compareBt?.titleLabel?.font = UIFont.boldSystemFontOfSize(m_compareBt!.frame.size.height*0.58)
        m_compareBt?.addTarget(self, action: #selector(ViewController.onCompareBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_compareBt!)
        
        
        //************  lottery  **************
        //lotteryLabel
        let lotteryLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width/3.5))
        lotteryLabel.center = CGPoint(x: frame.size.width/2, y: frame.size.height/8*5)
        lotteryLabel.text = "Lottery"
        lotteryLabel.textAlignment = NSTextAlignment.Center
        lotteryLabel.textColor = UIColor.whiteColor()
        lotteryLabel.font = UIFont.systemFontOfSize(frame.size.width/7)
        self.view.addSubview(lotteryLabel)
        
        //lotteryView
        let lotteryView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/4))
        lotteryView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/8*7)
        lotteryView.backgroundColor = UIColor(red: 1.0, green: 0.65, blue: 0.0, alpha: 0.68)
        self.view.addSubview(lotteryView)
        
        //lotteryContent (upon guessView)
        let lotteryContent:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/4))
        lotteryContent.center = CGPoint(x: lotteryView.center.x, y:lotteryView.center.y-25)
        lotteryContent.textAlignment = NSTextAlignment.Center
        lotteryContent.textColor = UIColor.whiteColor()
        lotteryContent.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        lotteryContent.numberOfLines = 0
        lotteryContent.text =
        "樂透球比大小\n 玩家1 - 玩家2 各轉動一次\n 得到的樂透球號數較大者獲勝"
        lotteryContent.font = UIFont.systemFontOfSize(frame.size.width/20)
        self.view.addSubview(lotteryContent)
        
        //m_lotteryBt
        m_lotteryBt = UIButton(frame: self.m_compareBt!.frame)
        m_lotteryBt?.center = CGPoint(x: frame.size.width/2, y: frame.size.height - 35)
        m_lotteryBt?.backgroundColor = UIColor(red: 0.95, green: 0.77, blue: 0.0, alpha: 1.0)
        m_lotteryBt?.layer.cornerRadius = m_compareBt!.frame.size.width/5
        m_lotteryBt?.setTitle("Start", forState: UIControlState.Normal)
        m_lotteryBt?.showsTouchWhenHighlighted = true
        m_lotteryBt?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        m_lotteryBt?.titleLabel?.font = UIFont.boldSystemFontOfSize(m_compareBt!.frame.size.height*0.58)
        m_lotteryBt?.addTarget(self, action: #selector(ViewController.onLottrryBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_lotteryBt!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - onCompareBtAction 切換到compare頁面
    //----------------------------------
    func onCompareBtAction(bt:UIButton){
        
        if compareVC == nil {
            
            compareVC = CompareViewController()
            compareVC?.refreash(self.view.frame)
        }
        compareVC?.homePage = self
        self.presentViewController(compareVC!, animated: true, completion: nil)
    }
    
    //MARK: - onLottrryBtAction 切換到Lottery頁面
    //----------------------------------
    func onLottrryBtAction(bt:UIButton){
        
        if lotteryVC == nil {
            
            lotteryVC = LotteryViewController()
            lotteryVC?.refreash(self.view.frame)
        }
        lotteryVC?.homePage = self
        self.presentViewController(lotteryVC!, animated: true, completion: nil)
    }
    
    //MARK: - 隱藏狀態列
    //----------------------------------
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    
}//end class


