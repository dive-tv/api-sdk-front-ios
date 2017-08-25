//
//  Section.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 13/09/16.
//  Copyright © 2016 Touchvie. All rights reserved.
//

import Foundation
import UIKit
import DiveApi

protocol SectionDelegate : class {
    func reloadTableAndOffset ();
    func reloadTable();
    func setController(viewController : UIViewController);
    
    func updateIndexPathAnalytics(indexPath : IndexPath, indexPathsAnalytics : [IndexPath]);
}

class Section : UIViewController, SectionDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var configSection : ConfigSection!;
    fileprivate var cardDetail : CardDetailResponse!
    var cardDelegate : CardDetailDelegate?;
    var isMain = false;
    
    private var controller : UIViewController?;
    
    private var alert : UIAlertController?;
    
    private var indexPathsAnalytics = [IndexPath : [IndexPath]]();
    
    private var finishReload = true;
    
    override var childViewControllerForStatusBarStyle: UIViewController?{
        return self.controller;
    }
    
    //MARK: INIT
    
    
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _configSection : ConfigSection, _cardDetail : CardDetail) {
//        
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
//        self.configSection = _configSection;
//        self.cardDetail = _cardDetail;
//    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _configSection : ConfigSection, _cardDetail : CardDetailResponse) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.configSection = _configSection
        self.cardDetail = _cardDetail
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    deinit {
        print("Section destroid ------->")
    }
    
    //MARK: UIViewController methods
    
    
    /**
     Configures tableView and register tableViewCells
     */
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white;
        self.tableView.backgroundColor = UIColor.white;
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero);
        self.tableView.separatorStyle = .none;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "nativeCell");
        
        if(self.isMain){
            
            let like = UIBarButtonItem(image: (self.cardDetail.user?.isLiked)! ? #imageLiteral(resourceName: "ico_like_active") : #imageLiteral(resourceName: "ico_like"), style: .plain, target: self, action: #selector(Section.saveCard));
            like.tintColor = UIColor.diveWarmGreyColor();
            
            let more = UIBarButtonItem(image: #imageLiteral(resourceName: "ico_more"), style: .plain, target: self, action: #selector(Section.openOptions));
            more.tintColor = UIColor.diveWarmGreyColor();
            
            self.navigationItem.rightBarButtonItems = [more, like];
        }
        
        //let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String;
        
        for module in self.configSection.arrayModules {
        self.tableView?.register(UINib(nibName: module.moduleName!, bundle: Bundle(for: self.classForCoder)), forCellReuseIdentifier: module.moduleName!);
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.indexPathsAnalytics.removeAll();
        self.finishReload = false;
        self.tableView.reloadData {
            self.checkVisibleCells();
            self.finishReload = true;
        }
        
        //self.tableView.setContentOffset(self.tableView.contentOffset, animated: false);
    }
    
    
    //MARK: Private

    
    
    fileprivate func getScrollViewOffset (_ _offset : CGFloat) -> CGFloat {
        
        var offset = _offset;
        
        if (_offset != 0 && _offset + self.tableView.frame.height > self.tableView.contentSize.height) {
            offset -= abs(self.tableView.contentSize.height - (offset + self.tableView.frame.height));
        }
        
        return offset < 0.0 ? _offset : offset;
    }
    
    private func checkVisibleCells(){
        if let visibleIndexPaths = self.tableView.indexPathsForVisibleRows, self.tableView.visibleCells.count > 0{
            for indexPath in visibleIndexPaths{
                if(self.indexPathsAnalytics[indexPath] == nil){
                    if(indexPath.row != self.configSection.arrayModules.count){
                        if let cell = self.tableView.cellForRow(at: indexPath) as? SDKFrontModule{
                            self.indexPathsAnalytics[indexPath] = [IndexPath]();
                            self.sentModuleImpression(name: "\(cell.classForCoder)");
                            cell.setIndexPathsAnalytics(indexPath: indexPath, indexPathsAnalytics: self.indexPathsAnalytics[indexPath] == nil ? [IndexPath]() : self.indexPathsAnalytics[indexPath]!);
                        }
                        
                    }
                }
                
            }
        }
    }
    
    private func sentModuleImpression(name : String){
        AnalyticsManager.shared.callEventForModule(contentType: name, referrerCardId: self.cardDetail.cardId, referrerType: self.cardDetail.type.rawValue);
    }
    
    //MARK: Section delegate
    
    
    /**
     Reload tableview and calls tab menu to refresh if exists.
     */
    func reloadTableAndOffset() {
        
        let offset = self.tableView.contentOffset.y;
        self.tableView.reloadData();
        
        if (self.tableView.contentSize.height > self.tableView.frame.height) {
            self.tableView.layoutIfNeeded();
            self.tableView.contentOffset.y = self.getScrollViewOffset(offset);
        }
    }
    
    func reloadTable() {
        self.tableView.reloadData();
    }
    
    
    func setController(viewController: UIViewController) {
        self.controller = viewController;
    }
    
    func updateIndexPathAnalytics(indexPath: IndexPath, indexPathsAnalytics: [IndexPath]) {
        self.indexPathsAnalytics[indexPath] = indexPathsAnalytics;
    }
    
    // MARK: UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.configSection.arrayModules.count;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == self.configSection.arrayModules.count){
            return 75;
        }
        return UITableViewAutomaticDimension;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == self.configSection.arrayModules.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "nativeCell", for: indexPath);
            cell.selectionStyle = .none;
            cell.backgroundColor = UIColor.clear;
            cell.contentView.backgroundColor = UIColor.clear;
            return cell;
        }
        else{
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.configSection.arrayModules[(indexPath as NSIndexPath).row].moduleName!) as! SDKFrontModule;
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.sectionDelegate = self;
            cell.cardDelegate = self.cardDelegate;
            //cell.setIndexPathsAnalytics(indexPath: indexPath, indexPathsAnalytics: self.indexPathsAnalytics[indexPath] == nil ? [IndexPath]() : self.indexPathsAnalytics[indexPath]!);
           
           cell.setCardDetail(self.configSection.arrayModules[(indexPath as NSIndexPath).row], _cardDetail: self.cardDetail);
            return cell;
        }
    }
    
    // MARK: Selector
    func saveCard(){
        
        self.cardDetail.user?.isLiked = self.cardDetail.user?.isLiked != nil ? !self.cardDetail.user!.isLiked! : false
        
        let like = UIBarButtonItem(image: (self.cardDetail.user?.isLiked)! ? #imageLiteral(resourceName: "ico_like_active") : #imageLiteral(resourceName: "ico_like"), style: .plain, target: self, action: #selector(Section.saveCard));
        like.tintColor = UIColor.diveWarmGreyColor();
        
        let more = UIBarButtonItem(image: #imageLiteral(resourceName: "ico_more"), style: .plain, target: self, action: #selector(Section.openOptions));
        more.tintColor = UIColor.diveWarmGreyColor();
        
        self.navigationItem.rightBarButtonItems = [more, like];
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addLikeNotification"), object: self.cardDetail);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeLikeProductNotification"), object: self.cardDetail);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addLikeMenuItemNotification"), object: self.cardDetail);
        
        self.cardDelegate?.addRemoveLike(cardId: self.cardDetail.cardId, like: (self.cardDetail.user?.isLiked!)!, completion: { (statusCode) in
            print("");
        })
        
        AnalyticsManager.shared.callEventForLikeUnlike(cardId: self.cardDetail.cardId, liked: self.cardDetail.user?.isLiked);
    }
    
    func openOptions(){
        
        self.cardDelegate?.shareOptions()
        
    }
    
    // MARK: ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.finishReload){
            self.checkVisibleCells();
        }
        
    }
    
}
