

import UIKit

class LotteryViewController: UIViewController {
    
//MARK: 變數 & 屬性相關宣告
//---------------------------
    
    //機台圖片動畫 相關宣告
    var m_imgView:UIImageView?//樂透機台
    var aryAnimationImgs = [UIImage]() //機台轉動動畫
    
    //開獎 相關宣告
    var aryBalls:[UIImage] = [UIImage]()//開獎球圖片陣列
    var aryPlayerLabel = [UILabel]() //顯示玩家抽到的樂透球號
    var labelTitle:UILabel!
    
    //按鈕相關宣告
    var m_startBt:UIButton? //轉動按鈕
    var m_reStartBt:UIButton? //再一次按鈕
    var m_homeBt:UIButton? //回首頁按鈕
    var aryTotalNumsOrigin = [Int]() //存放 1~9 的數字陣列(原始)
    var aryTotalNums = [Int]() //存放 1~9 的數字陣列
    var total:Int = 0
    var homePage:ViewController? //首頁
    
    //seesaw 蹺蹺板 相關宣告
    var m_seesawBoard:UILabel? //蹺蹺板
    var m_seesawSupport:CGView? //蹺蹺板底座
    var m_player01ImgView:UIImageView? //顯示player01的view
    var m_player02ImgView:UIImageView? //顯示player02的view
    
    
//MARK: - Normal Function
//-----------------------
     func refreash(frame:CGRect){
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //請 按 開 始
        labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/8))
        labelTitle.center = CGPoint(x:self.view.frame.size.width/2, y: self.view.frame.size.height/20)
        labelTitle.text = "玩家1 請 按 轉 動 鍵 "
        labelTitle.textAlignment = NSTextAlignment.Center
        labelTitle.textColor = UIColor.blueColor()
        labelTitle.font = UIFont.boldSystemFontOfSize(self.view.frame.size.height/25)
        self.view.addSubview(labelTitle)
        
        //顯示樂透機台
        let imgViewSizeW:CGFloat = self.view.frame.size.width*0.7
        m_imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewSizeW, height: imgViewSizeW))
        m_imgView?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/8*2.5)
        m_imgView?.image = UIImage(named: "stay.jpg")
        self.view.addSubview(m_imgView!)
        
        //機台動畫圖片陣列
        for insertImg in 1 ... 6 {
            
            aryAnimationImgs.append(UIImage(named: "start0\(insertImg).jpg")!)
        }
        
        m_imgView?.animationImages = aryAnimationImgs
        
        //開始按鈕
        let startBtSizeW:CGFloat = self.view.frame.size.width/4.5
        m_startBt = UIButton(frame: CGRect(x: 0, y: 0, width: startBtSizeW , height: startBtSizeW/2))
        m_startBt?.center = CGPoint(x: m_imgView!.center.x, y: self.view.frame.size.height/8*4.5)
        m_startBt?.layer.cornerRadius = m_startBt!.frame.size.width/9
        m_startBt?.titleLabel?.font = UIFont.boldSystemFontOfSize(m_startBt!.frame.size.height*0.5)
        m_startBt?.titleLabel?.adjustsFontSizeToFitWidth = true
        m_startBt?.setTitle("轉 動", forState: UIControlState.Normal)
        m_startBt?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        m_startBt?.backgroundColor = UIColor.blueColor()
        m_startBt?.addTarget(self, action: #selector(LotteryViewController.onStartBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_startBt!)
        
        //開獎球圖片陣列
        for ballIndex in 1 ... 9 {
            
            aryBalls.append(UIImage(named: "ball0\(ballIndex).jpg")!)
        }
        
        //顯示 player1 & 2:
        let playerLabelSizeW:CGFloat =  self.view.frame.size.width/5
        for playerLabelIndex in 0 ..< 2 {
            let playerlabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: playerLabelSizeW/1.5 , height: playerLabelSizeW/3))
            playerlabel.center = CGPoint(x:self.view.frame.size.width/4 * CGFloat(2*(playerLabelIndex)+1) , y:self.view.frame.size.height/10*8 )
            playerlabel.text = "玩家 \(playerLabelIndex + 1)"
            playerlabel.textAlignment = NSTextAlignment.Center
            playerlabel.backgroundColor = UIColor.clearColor()
            playerlabel.font = UIFont(name: "Marker Felt", size: playerlabel.frame.size.height*0.88)
            playerlabel.adjustsFontSizeToFitWidth = true
            playerlabel.textColor = UIColor(red: 0, green: 0.38, blue: 0.6, alpha: 1.0)
            self.view.addSubview(playerlabel)
        }
        
        
        //m_seesawBoard 蹺蹺板
        m_seesawBoard = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width*0.88, height: self.view.frame.size.height/45))
        m_seesawBoard?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/10*7)
        m_seesawBoard?.backgroundColor = UIColor.brownColor()
        self.view.addSubview(m_seesawBoard!)
        
        //m_seesawSupport
        m_seesawSupport = CGView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/6, height: self.view.frame.size.width/6))
        m_seesawSupport?.center = CGPoint(x: m_seesawBoard!.center.x, y: m_seesawBoard!.center.y +  m_seesawBoard!.frame.size.height/2 + m_seesawSupport!.frame.size.height/2)
        self.view.addSubview(m_seesawSupport!)
        
        //m_playr01ImgView
        let playerImgViewL:CGFloat = self.view.frame.size.width/6
        m_player01ImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: playerImgViewL, height: playerImgViewL))
        self.view.addSubview(m_player01ImgView!)
        
        //m_player02ImgView
        m_player02ImgView = UIImageView(frame: m_player01ImgView!.frame)
        self.view.addSubview(m_player02ImgView!)
        
        
        self.seesawBalance(self.view.frame.size.width/3, angle:17) //一開始為平衡狀態
        
        //存放 1~9 的數字陣列
        for num in 1 ... aryBalls.count {
            
            aryTotalNumsOrigin.append(num)
        }
        aryTotalNums = aryTotalNumsOrigin
        total = aryTotalNums.count //此時total = 9
        
        //reStartBt 再一次按鈕
        m_reStartBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2 - 0.5, height: 60))
        m_reStartBt?.center = CGPoint(x:self.view.frame.size.width/4*3 + 0.5, y: self.view.frame.size.height - 30)
        m_reStartBt?.backgroundColor = UIColor.darkGrayColor()
        m_reStartBt?.setTitle("再一次", forState: UIControlState.Normal)
        m_reStartBt?.showsTouchWhenHighlighted = true
        m_reStartBt?.addTarget(self, action: #selector(LotteryViewController.onRestartBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        m_reStartBt?.enabled = false
        m_reStartBt?.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.view.addSubview(m_reStartBt!)
       
        
        //homeBt 回首頁按鈕
        m_homeBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2 - 0.5, height: 60))
        m_homeBt?.center = CGPoint(x:self.view.frame.size.width/4 - 0.5, y: self.view.frame.size.height - 30)
        m_homeBt?.backgroundColor = m_reStartBt!.backgroundColor
        m_homeBt?.setTitle("回首頁", forState: UIControlState.Normal)
        m_homeBt?.showsTouchWhenHighlighted = true
        m_homeBt?.addTarget(self, action: #selector(LotteryViewController.onHomeBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_homeBt!)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.backToOrigin()
    }
    
//MARK: - 隱藏狀態列
//----------------
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
//MARK: - onStartBtAction
//----------------------------
    var startBtPressedCount:Int = 0 //轉動按鈕被按次數
    
    func onStartBtAction(sender:UIButton) {
        
        startBtPressedCount += 1 //每按一次轉動按鈕,計數器加1

        //所有按鈕失效
        self.theButtonEnable(m_homeBt!, isEnable: false)
        self.theButtonEnable(m_reStartBt!, isEnable: false)
        self.theButtonEnable(m_startBt!, isEnable: false)
        
        //動畫開始
        m_imgView?.animationDuration = 0.38
        m_imgView?.startAnimating()
        
        NSTimer.scheduledTimerWithTimeInterval(1.58/1, target: self, selector: #selector(LotteryViewController.animationStop(_:)), userInfo: nil, repeats: false)
    }
    
//MARK: - animationForImgChange 機台動畫停止時
//-----------------------------------------
    func animationStop(sender:NSTimer) {

        self.produceTwoNumbers()
        m_imgView?.stopAnimating()
        m_imgView?.image = UIImage(named: "end.jpg")
        
        
        switch startBtPressedCount {
        case 1:
            self.theButtonEnable(m_startBt!, isEnable: true)
        case 2:
            self.restartBtAndHomeBtEnble()
        default:
            break
        }
    }
    
//MARK: - restartBtAndHomeBtEnble
//------------------------------
    func restartBtAndHomeBtEnble() {
        
        self.theButtonEnable(m_homeBt!, isEnable: true)
        self.theButtonEnable(m_reStartBt!, isEnable: true)
        self.theButtonEnable(m_startBt!, isEnable: false)
        
    }

//MARK: - 隨機選取號碼,每位玩家可以轉動1次(兩位玩家數字不可相同)
//------------------------------
    var player01Value:Int = 0
    var player02Value:Int = 0
    
    func produceTwoNumbers() {
        
        let ballnum = Int(arc4random() % UInt32(total)) //隨機選取號碼
        
        switch startBtPressedCount {
        
        case 1:
            m_player01ImgView?.image = UIImage(named: "ball0\(aryTotalNums[ballnum]).png")
            player01Value = aryTotalNums[ballnum]
            labelTitle.text = "玩家2 請 按 轉 動 鍵 "
        case 2:
            m_player02ImgView?.image = UIImage(named: "ball0\(aryTotalNums[ballnum]).png")
            player02Value = aryTotalNums[ballnum]
            self.performSelector(#selector(LotteryViewController.compareResult), withObject: nil, afterDelay: 0.01)
            labelTitle.text = ""
        default:
            break
        }
        aryTotalNums[ballnum] = aryTotalNums[total-1]
        total -= 1
    }
    

//MARK: - compareResult 比大小結果
//------------------------------
    var winner:UILabel!
    
    func compareResult() {
        
        winner = UILabel(frame: CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: self.view.frame.size.width/3, height: self.view.frame.size.width/8))
        winner.text = "Winner"
        winner.textAlignment = NSTextAlignment.Center
        winner.textColor = UIColor.purpleColor()
        winner.font = UIFont.boldSystemFontOfSize(winner.frame.size.height*0.68)
        winner.adjustsFontSizeToFitWidth = true
        
    
        UIView.beginAnimations("seesawAnimation", context: nil)
        UIView.setAnimationDuration(0.88)
        if player01Value > player02Value {
            //當player01獲勝時
            self.seesawPlayer01Win(self.view.frame.size.width/3, angle: 15)
            winner.center = CGPoint(x: self.view.frame.size.width/4, y: self.view.frame.size.height/10*8 + winner.frame.size.height/2)
            labelTitle.text = "玩家1 獲勝"
        }
        else {
            //當player02獲勝時
            self.seesawPlayer02Win(self.view.frame.size.width/3, angle: 15)
            winner.center = CGPoint(x: self.view.frame.size.width/4*3, y: self.view.frame.size.height/10*8 + winner.frame.size.height/2)
            labelTitle.text = "玩家2 獲勝"
        }
        self.view.addSubview(winner)
        UIView.commitAnimations()
        
        self.performSelector(#selector(LotteryViewController.restartBtAndHomeBtEnble), withObject: nil, afterDelay: 1.0)
    }
    
    
//MARK: - seesawBalance 蹺蹺板平衡時
//------------------------------
    func seesawBalance (distance:CGFloat,angle:CGFloat) {
        
        let center:CGPoint = CGPoint(x: m_seesawBoard!.center.x, y: m_seesawBoard!.center.y)
        let radian = angle * CGFloat(M_PI) / 180 //角度轉弧度(徑度)
        
        UIView.beginAnimations("seesawBalance", context: nil)
        UIView.setAnimationDuration(0.88)
        m_seesawBoard?.transform = CGAffineTransformMakeRotation(0)
        UIView.commitAnimations()
        
        m_player01ImgView?.center = CGPoint(x:center.x - distance * cos(radian) , y: center.y - distance * sin(radian))
        m_player02ImgView?.center = CGPoint(x: center.x + distance * cos(radian), y: center.y - distance * sin(radian))

    }
    
//MARK: - seesawPlayer01Win 蹺蹺板player01獲勝時
//------------------------------
    func seesawPlayer01Win(distance:CGFloat,angle:CGFloat) {
        
        let center:CGPoint = CGPoint(x: m_seesawBoard!.center.x, y: m_seesawBoard!.center.y)
        let radian = (angle) * CGFloat(M_PI) / 180 //角度轉弧度(徑度)
        let player01Radian = (angle - 17) * CGFloat(M_PI) / 180
        let player02Radian = (angle + 17) * CGFloat(M_PI) / 180
        
        m_seesawBoard?.transform = CGAffineTransformMakeRotation(-radian)
        m_player01ImgView?.center = CGPoint(x:center.x - distance * cos(player01Radian) , y: center.y + distance * sin(player01Radian))
        m_player02ImgView?.center = CGPoint(x: center.x + distance * cos(player02Radian), y: center.y - distance * sin(player02Radian))
    }
    
    
//MARK: - seesawPlayer02Win 蹺蹺板player02獲勝時
//------------------------------
    func seesawPlayer02Win(distance:CGFloat,angle:CGFloat) {
        
        let center:CGPoint = CGPoint(x: m_seesawBoard!.center.x, y: m_seesawBoard!.center.y)
        let radian = angle * CGFloat(M_PI) / 180 //角度轉弧度(徑度)
        let player01Radian = (angle + 17) * CGFloat(M_PI) / 180
        let player02Radian = (angle - 17) * CGFloat(M_PI) / 180
        
        m_seesawBoard?.transform = CGAffineTransformMakeRotation(radian)
        m_player01ImgView?.center = CGPoint(x:center.x - distance * cos(player01Radian) , y: center.y - distance * sin(player01Radian))
        m_player02ImgView?.center = CGPoint(x: center.x + distance * cos(player02Radian), y: center.y + distance * sin(player02Radian))
    }
    
    
//MARK: - onRestartBtAction 再一次
//------------------------------
    func onRestartBtAction(sender:UIButton) {
        
        self.backToOrigin()
    }
    
    
//MARK: - onHomeBtAction 回首頁
//------------------------------
    func onHomeBtAction(sender:UIButton) {
        
        if homePage != nil {
            
            self.homePage?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
//MARK: - 歸零
//------------------------------
    func backToOrigin() {
        
        self.theButtonEnable(m_startBt!, isEnable: true)
        self.theButtonEnable(m_homeBt!, isEnable: true)
        self.theButtonEnable(m_reStartBt!, isEnable: false)
        
        startBtPressedCount = 0 //轉動按鈕計數器歸0
        m_player01ImgView?.image = nil //player01圖片無
        m_player02ImgView?.image = nil //player02圖片無
        self.seesawBalance(self.view.frame.size.width/3, angle:17) //蹺蹺板復原
        total = aryTotalNums.count
        aryTotalNums = aryTotalNumsOrigin
        labelTitle.text = "玩家1 請 按 轉 動 鍵 "
        if winner != nil {
            
            winner.removeFromSuperview()
        }
    }

//MARK: - theButtonEnable & color
//-------------------------------
    func theButtonEnable(bt:UIButton,isEnable:Bool) {
        
        bt.enabled = isEnable
        let color = isEnable == true ? UIColor.whiteColor() : UIColor.lightGrayColor()
        bt.setTitleColor(color, forState: .Normal)
    }

    
}//end class

