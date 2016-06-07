//
//  MGDetailViewController.swift
//  MGSlideViewDemo
//
//  Created by ming on 16/6/5.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

let cellId = "cellId"
class MGDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var array:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.array = ["开通会员", "QQ钱包", "个性装扮", "我的收藏", "我的相册", "我的文件", "我的名片夹"]
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array!.count
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        cell!.backgroundColor = UIColor.clearColor()
        cell!.textLabel!.text = self.array![indexPath.row]
        cell!.textLabel!.textColor = UIColor.purpleColor()
        cell!.textLabel!.font = UIFont.systemFontOfSize(16)
        let indexname = self.array![indexPath.row]
        cell!.imageView!.image = UIImage(named: indexname)
        return cell!

    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
