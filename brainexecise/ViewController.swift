//
//  ViewController.swift
//  brainexecise
//
//  Created by Petch Temeeyasen on 5/19/15.
//  Copyright (c) 2015 meesoft. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var UnlockButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBarHidden = true
        self.title = "30 sec test"
        // Set IAPS
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID:NSSet = NSSet(objects: "th.co.meesoft.brainexecise.unlock")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
        
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        
        if let isFirstTimeDone = userSetting.boolForKey("isdonefirsttime") as Bool? {
            if !isFirstTimeDone {
                userSetting.setBool(true, forKey: "isdonefirsttime")
                userSetting.setBool(false, forKey: "ispurchased")
                //userSetting.setBool(false, forKey: "ispurchased2")
                userSetting.setBool(false, forKey: "iswatchscore")
                userSetting.setObject("Beginner", forKey: "rank")
                userSetting.setInteger(1, forKey: "level")
                userSetting.setInteger(0, forKey: "rankprogress")
                userSetting.setInteger(3, forKey: "maxprogress")
                
                userSetting.setBool(false, forKey: "practicemode")
                
                userSetting.setInteger(0, forKey: "dailyplay")
                userSetting.setInteger(0, forKey: "game1play")
                userSetting.setInteger(0, forKey: "game2play")
                userSetting.setInteger(0, forKey: "game3play")
                userSetting.setInteger(0, forKey: "game4play")
                userSetting.setInteger(0, forKey: "game5play")
                
                userSetting.setBool(false, forKey: "game1unlock")
                userSetting.setBool(false, forKey: "game2unlock")
                userSetting.setBool(false, forKey: "game3unlock")
                userSetting.setBool(false, forKey: "game4unlock")
                userSetting.setBool(false, forKey: "game5unlock")
                
                userSetting.setInteger(10, forKey: "hiscore")
                userSetting.setInteger(1, forKey: "topgame")
                userSetting.setInteger(0, forKey: "hiscore1")
                userSetting.setInteger(0, forKey: "hiscore2")
                userSetting.setInteger(0, forKey: "hiscore3")
                userSetting.setInteger(0, forKey: "todayscore")
                
                let lastestDate: NSDate = NSDate(timeIntervalSince1970: 0)

                userSetting.setObject(lastestDate, forKey: "lastdate")
                
                userSetting.setObject([10, 10, 10], forKey: "scoresgame1") // top 3 hiscore of speed cal game for practise mode.
                userSetting.setObject([10, 10, 10], forKey: "scoresgame2")
                userSetting.setObject([10, 10, 10], forKey: "scoresgame3")
                //userSetting.synchronize()
            }
            
            if let isPurchase = userSetting.boolForKey("ispurchased") as Bool? {
                statusLabel.text = isPurchase ? "Full Version" : "Free Version"
                //puchaseSwitch.setOn(isPurchase, animated: true)
                UnlockButton.hidden = isPurchase
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UnlockClick(sender: AnyObject) {
        for product in list {
            let prodID = product.productIdentifier
            if(prodID == "th.co.meesoft.brainexecise.unlock") {
                p = product
                makePurchase()
                break;
            }
        }
    }
    
    var list = [SKProduct]()
    var p = SKProduct()

    func makePurchase() {
        print("purchasing: " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
    }
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product )
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print("transactions restored")
        //var purchasedItemIDS = []
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction 
            
            let prodID = t.payment.productIdentifier as String
            if(prodID == "th.co.meesoft.brainexecise.unlock"){
                print("Unlock to full version.")
                doUnlockFeatures()
            }
            else {
                print("IAP not setup")
            }
        }
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
            case .Purchased:
                print("Buying success: Unlock features.")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                if(prodID == "th.co.meesoft.brainexecise.unlock"){
                    print("Unlock to full version.")
                    doUnlockFeatures()
                }
                else {
                    print("IAP not setup")
                }
                
                queue.finishTransaction(trans)
                break;
            case .Failed:
                print("buy error")
                queue.finishTransaction(trans)
                break;
            default:
                print("default")
                break;
                
            }
        }
    }
    
    func finishTransaction(trans:SKPaymentTransaction){
        print("finish trans")
        SKPaymentQueue.defaultQueue().finishTransaction(trans)
    }
    
    func paymentQueue(queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]){
        print("remove trans");
    }
    
    func doUnlockFeatures(){
        let userSetting: NSUserDefaults! = NSUserDefaults(suiteName: "group.brainexecise")
        userSetting.setBool(true, forKey: "ispurchased")
        UnlockButton.hidden = true
        statusLabel.text = "Full Version"
    }
}

