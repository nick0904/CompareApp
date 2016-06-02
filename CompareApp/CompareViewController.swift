

import UIKit

class CompareViewController: UIViewController {

    var homePage:ViewController?
    
    //紙牌大小 與 間隔
    let spaceW:CGFloat = 3
    let spaceH:CGFloat = 8
    let cardW:CGFloat = 71
    let cardH:CGFloat = 120
    
    //顯示標籤 相關宣告
    var m_topLabel:UILabel? //最上層標籤
    var player01Label:UILabel! //玩家1標籤
    var player02Label:UILabel! //玩家2標籤
    var winnerLabel:UILabel! //Winner
    
    //撲克牌 相關宣告
    var m_cardImgView:CompareImageViewTouchEvent! //顯示待選撲克牌的ImgView
    var m_aryCardImgView = [CompareImageViewTouchEvent]() //儲存撲克牌的陣列
    var m_aryPlayerImageView = [UIImageView]() ////顯示玩家撲克牌的ImgVie
    
    //按鈕 相關宣告
    var m_restartBt:UIButton! //重新開始按鈕
    var m_homeBt:UIButton! //回首頁按鈕
    var m_resultBt:UIButton! // vs 按扭
    
    //計時器
    var m_timer:NSTimer!
    
    
    
//MARK: - Normal Function
//-----------------------
    func refreash(frame:CGRect){
        
        self.view.backgroundColor = UIColor.blackColor()
        
        //******************  m_topLabel  ***************
        m_topLabel = UILabel(frame: CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: 40))
        m_topLabel?.center = CGPoint(x: self.view.frame.size.width/2, y: 40)
        m_topLabel?.textColor = UIColor.cyanColor()
        m_topLabel?.textAlignment = NSTextAlignment.Center
        m_topLabel?.font = UIFont.systemFontOfSize(self.view.frame.size.width/15)
        self.view.addSubview(m_topLabel!)
        
        //******************  playerLabel  ***************
        //player01
        player01Label = UILabel(frame: CGRect(x: 0, y: 0, width:100, height: 25))
        player01Label.center = CGPoint(x: self.view.frame.size.width/4, y: self.view.frame.size.height - 90)
        player01Label.text = "玩家 1"
        player01Label.textColor = UIColor.whiteColor()
        player01Label.textAlignment = NSTextAlignment.Center
        player01Label.font = UIFont.boldSystemFontOfSize(20.0)
        self.view.addSubview(player01Label)
        
        //player02
        player02Label = UILabel(frame: CGRect(x: 0, y: 0, width:100, height: 25))
        player02Label.center = CGPoint(x: self.view.frame.size.width/4*3, y: self.view.frame.size.height - 90)
        player02Label.text = "玩家 2"
        player02Label.textColor = player01Label.textColor
        player02Label.textAlignment = NSTextAlignment.Center
        player02Label.font = player01Label.font
        self.view.addSubview(player02Label)
        
        //******************  playerImageView   ***************
        for player in 0 ..< 2 {
            let playersImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardW, height: cardH))
            playersImgView.center = CGPoint(x: self.view.frame.size.width/4 * CGFloat((2*player)+1), y: self.view.frame.size.height - 170)
            playersImgView.image = UIImage(named: "black.png")
            m_aryPlayerImageView.append(playersImgView)
            self.view.addSubview(m_aryPlayerImageView[player])
        }
        
        //******************  m_homeBt 回首頁按鈕   ***************
        m_homeBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2 - 0.5, height: 60))
        m_homeBt.center = CGPoint(x: self.view.frame.size.width/4 - 0.5, y: self.view.frame.size.height - 30)
        m_homeBt.backgroundColor = UIColor.darkGrayColor()
        m_homeBt.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        m_homeBt.setTitle("回首頁", forState: UIControlState.Normal)
        m_homeBt.showsTouchWhenHighlighted = true
        m_homeBt.addTarget(self, action: #selector(CompareViewController.onHomeBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_homeBt)
        
        //******************  m_restartBt 再一次按鈕   ***************
        m_restartBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2 - 0.5, height: 60))
        m_restartBt.center = CGPoint(x:  self.view.frame.size.width/4*3 + 0.5, y: m_homeBt.center.y)
        m_restartBt.backgroundColor = UIColor.darkGrayColor()
        m_restartBt.setTitle("再一次", forState: UIControlState.Normal)
        m_restartBt.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        m_restartBt.showsTouchWhenHighlighted = true
        m_restartBt.addTarget(self, action: #selector(CompareViewController.onRestartBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(m_restartBt!)
        self.theButtonEnable(m_restartBt!, isEnable: false)
        
        //*******************  m_resultBt  *******************
        m_resultBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/5, height: self.view.frame.size.width/5))
        m_resultBt.center = CGPoint(x: self.view.frame.size.width/2, y: m_aryPlayerImageView[0].center.y*1.08)
        m_resultBt.setTitle("VS", forState: UIControlState.Normal)
        m_resultBt.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        m_resultBt.titleLabel?.font = UIFont.boldSystemFontOfSize(m_resultBt!.frame.size.width/1.5)
        m_resultBt.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.theButtonEnable(m_resultBt, isEnable: false)
        m_resultBt.alpha = 0.0
        self.m_resultBt.addTarget("self", action: #selector(CompareViewController.onResultBtAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.m_resultBt!)
        
        
        //*******************  winnerLabel 產生Winner標籤  *******************
        winnerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: self.view.frame.size.height/20))
        winnerLabel.text = "Winner"
        winnerLabel.textColor = UIColor.orangeColor()
        winnerLabel.textAlignment = NSTextAlignment.Center
        winnerLabel.font = UIFont.systemFontOfSize(self.view.frame.size.width/10)
        winnerLabel.alpha = 0.0
        self.view.addSubview(winnerLabel)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.createCards()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.backToOrigin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - createCards (產生15張撲克牌)
//-------------------------------
    func createCards() {
        
        //生成十五張紙牌 與 動畫
        UIView.beginAnimations("postCards", context: nil)
        UIView.setAnimationDuration(0.68)
        for row in 0 ..< 3 {
            
            for column in 0 ..< 5 {
                
                //unChooseCount += 1 //每生成一張,計數器+1 (共15張)
                m_cardImgView = CompareImageViewTouchEvent(frame: CGRect(x: 0, y: 0, width: cardW, height: cardH))
                m_cardImgView.center = CGPoint(
                    x: CGFloat(column+1) * spaceW + cardW/2 * CGFloat(2*column + 1),
                    y: 60 + CGFloat(row+1) * spaceH + cardH/2 * CGFloat(2*row + 1))
                m_cardImgView.image = UIImage(named: "poker_0.png")
                m_aryCardImgView.append(m_cardImgView)
                self.view.addSubview(m_cardImgView)
            }
        }

        player01Label.backgroundColor = UIColor.redColor()
        m_topLabel?.text = "玩家1 請點選一張牌"
        UIView.commitAnimations()
        
        self.m_timer = NSTimer.scheduledTimerWithTimeInterval(1/10, target: self, selector: #selector(CompareViewController.checkCardCount(_:)), userInfo: nil, repeats: true)
        
    }
    
var openCount:Int = 0
//MARK: - checkCardCount (檢查已翻牌幾張)
//------------------------------------
    func checkCardCount(sender:NSTimer){
        //每點選一張,unChooseCount-1
        for i in 0 ..< m_aryCardImgView.count {
            
            if m_aryCardImgView[i].isOpen == true {
                
                self.theButtonEnable(m_homeBt, isEnable: false)
                openCount += 1
                m_aryCardImgView[i].isOpen = false;
            }
        }
        
        switch openCount {
        case 1:
            self.showPlayersCard(m_aryPlayerImageView[0])
        case 2:
            self.cardsEnable(false)
            self.showPlayersCard(m_aryPlayerImageView[1])
            m_timer.invalidate() //停止偵測
        default:
            break
        }
        
    }
    
//MARK: - showPlayersCard (顯示玩家的撲克牌)
//-------------------------------
    func showPlayersCard(sender:UIImageView){
        
        sender.image = UIImage(named: "poker_0.png")
        
        switch openCount {
        case 1:
            player01Label.backgroundColor = UIColor.blackColor()
            player02Label.backgroundColor = UIColor.redColor()
            m_topLabel?.text = "玩家2 請點選一張牌"
        case 2:
            NSTimer.scheduledTimerWithTimeInterval(1/20, target: self, selector: #selector(CompareViewController.resultBtShow(_:)), userInfo: nil, repeats: false)
        default:
            break
        }
        
    }
    
//MARK: - resultBtShow (生成 VS 按鈕的方法)
//--------------------------------------
    func resultBtShow(sender:NSTimer){
        
        m_resultBt.alpha = 1.0
        self.theButtonEnable(m_resultBt, isEnable: true)
        player02Label.backgroundColor = UIColor.blackColor()
        m_topLabel?.text = "請點選 VS 看結果"
    }

    
//MARK: - cardsenable (是否禁止翻牌)
//-------------------------------
    func cardsEnable(bool:Bool) {
        
        //點選圖片消失功能是否失效
        for i in 0 ..< m_aryCardImgView.count {
            
            m_aryCardImgView[i].userInteractionEnabled = bool
        }
    }

//MARK: - theButtonEnable & color
//-------------------------------
    func theButtonEnable(bt:UIButton,isEnable:Bool) {
        
        bt.enabled = isEnable
        let color = isEnable == true ? UIColor.whiteColor() : UIColor.lightGrayColor()
        bt.setTitleColor(color, forState: .Normal)
    }
    
//MARK: - onResultBtAction (結果出爐)
//-------------------------------
    func onResultBtAction(sender:UIButton) {
        
        //m_resultBt
        self.theButtonEnable(m_resultBt, isEnable: false)
        self.m_resultBt.alpha = 0.0
        
        //m_homeBt
        self.theButtonEnable(m_homeBt, isEnable: true)
        
        //m_restartBt
        self.theButtonEnable(m_restartBt, isEnable: true)
        
        
        let player01Value:Int = Int(arc4random() % 15 + 1)
        var player02Value:Int = Int(arc4random() % 15 + 1)
        
        let newQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        
        dispatch_async(newQueue) {
            
            if player02Value == player01Value {
                
                player02Value = Int(arc4random() % 15 + 1)
            }
            else {
                
                dispatch_async(dispatch_get_main_queue(), { 
                    
                    self.cardTransitionToUser(player01Value, playerView: self.m_aryPlayerImageView[0])
                    self.cardTransitionToUser(player02Value, playerView: self.m_aryPlayerImageView[1])
                    self.m_topLabel?.text = ""
                    
                    if player01Value > player02Value {
                        
                        self.winnerLabel.center = CGPoint(x:self.m_aryPlayerImageView[0].center.x, y: self.m_aryPlayerImageView[0].center.y)
                    }
                    else {
                        
                        self.winnerLabel.center = CGPoint(x: self.m_aryPlayerImageView[1].center.x, y:self.m_aryPlayerImageView[1].center.y)
                    }
                    

                })
                
            }

            
        }
        
        
    }

//MARK: - cardTransitionToUser (撲克牌轉向正面)
//------------------------------------------
    func cardTransitionToUser(imgIndex:Int,playerView:UIImageView){
        
        UIView.transitionWithView(playerView, duration: 0.68, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
            
            playerView.image = UIImage(named:String(format: "poker_%d.png",imgIndex))
            self.performSelector(#selector(CompareViewController.showWinnerLabel), withObject: nil, afterDelay: 0.58)
            
            }, completion: nil)
    }
    
//MARK: - showWinnerLabel (顯示Winner標籤)
//-------------------------
    func showWinnerLabel() {
        
        winnerLabel.alpha = 1.0
        self.theButtonEnable(m_restartBt, isEnable: true)
    }
    
//MARK: - onHomeBtAction (回首頁方法)
//-------------------------------
    func onHomeBtAction(sender:UIButton) {
        
        if homePage != nil {
            
            homePage?.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
//MARK: - backToOrigin (回到初始設定)
//-------------------------------
    func backToOrigin() {
        
        winnerLabel.alpha = 0.0
        openCount = 0
        m_timer.invalidate()
        
        //刪除所有陣列裡的項目,歸還記憶體
        for i in 0 ..< m_aryCardImgView.count {
            
            m_aryCardImgView[i].removeFromSuperview()
        }
        m_aryCardImgView.removeAll()
        
        //player01 & 02 顯示的撲克牌消失
        for i in 0 ..< m_aryPlayerImageView.count {
            
            m_aryPlayerImageView[i].image = UIImage(named: "black.png")
        }

        self.theButtonEnable(m_restartBt, isEnable: false)//重新開始鍵失效
    }
    
//MARK: - onRestartBtAction (再一次按鈕方法)
//-------------------------------
    func onRestartBtAction(sender:UIButton) {
        
        self.theButtonEnable(m_restartBt, isEnable: false)
        self.backToOrigin()
        self.createCards()
    }

    
}//end class
