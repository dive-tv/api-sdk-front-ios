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
    func getParentSize(indexPath: IndexPath) -> CGSize
    
    func updateIndexPathAnalytics(indexPath : IndexPath, indexPathsAnalytics : [IndexPath]);
}

open class Section : UIViewController, SectionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    fileprivate var configSection : ConfigSection!;
    fileprivate var cardDetail : CardDetailResponse!
    var cardDelegate : RenderCardDetailDelegate?;
    
    var isMain = false;
    
    private var controller : UIViewController?;
    
    private var alert : UIAlertController?;
    
    private var indexPathsAnalytics = [IndexPath : [IndexPath]]();
    
    private var finishReload = true;
    
    override open var childViewControllerForStatusBarStyle: UIViewController?{
        return self.controller;
    }
    
    //MARK: INIT
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _configSection : ConfigSection, _cardDetail : CardDetailResponse) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        self.configSection = _configSection
        self.cardDetail = _cardDetail
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    deinit {
        print("Section destroid ------->")
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        //flowLayout.invalidateLayout()
        
        self.collectionView.reloadData()
        
    }
    
    //MARK: UIViewController methods
    
    
    /**
     Configures tableView and register tableViewCells
     */
    override open func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white;
        self.collectionView.backgroundColor = UIColor.white;
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: C.Cell.nativeCell)
        self.collectionView.backgroundColor = ApiSDKConfiguration.backgroundColor
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            self.collectionView.alwaysBounceVertical = ApiSDKConfiguration.scrollDirection == .vertical ? true : false
            self.collectionView.alwaysBounceHorizontal = ApiSDKConfiguration.scrollDirection == .horizontal ? true : false
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection
           
        }
        
        if(self.isMain && self.navigationController != nil){
            
            let like = UIBarButtonItem(image: (self.cardDetail.user?.isLiked)! ? #imageLiteral(resourceName: "ico_like_active") : #imageLiteral(resourceName: "ico_like"), style: .plain, target: self, action: #selector(Section.saveCard));
            //like.tintColor = UIColor.diveWarmGreyColor();
            
            let more = UIBarButtonItem(image: #imageLiteral(resourceName: "ico_more"), style: .plain, target: self, action: #selector(Section.openOptions));
            //more.tintColor = UIColor.diveWarmGreyColor();
            
            self.navigationItem.rightBarButtonItems = [more, like];
        }
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: C.Cell.nativeCell)
        for module in self.configSection.arrayModules {
            
            self.collectionView.register(UINib(nibName: module.moduleName!, bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: module.moduleName!)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.collectionView.reloadData {
            self.checkVisibleCells();
            self.finishReload = true;
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        
        self.indexPathsAnalytics.removeAll();
        self.finishReload = false;
        
        
        //self.tableView.setContentOffset(self.tableView.contentOffset, animated: false);
    }
    
    
    public func changeConfiguration () {
        self.collectionView.backgroundColor = ApiSDKConfiguration.backgroundColor
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            self.collectionView.alwaysBounceVertical = ApiSDKConfiguration.scrollDirection == .vertical ? true : false
            self.collectionView.alwaysBounceHorizontal = ApiSDKConfiguration.scrollDirection == .horizontal ? true : false
            layout.scrollDirection = ApiSDKConfiguration.scrollDirection
            self.collectionView.collectionViewLayout = layout
        }
        
        self.collectionView.reloadData()
    }
    
    
    //MARK: Private

    
    
    fileprivate func getScrollViewOffset (_ _offset : CGFloat) -> CGFloat {
        
        var offset = _offset;
        
        if (_offset != 0 && _offset + self.collectionView.frame.height > self.collectionView.contentSize.height) {
            offset -= abs(self.collectionView.contentSize.height - (offset + self.collectionView.frame.height));
        }
        
        return offset < 0.0 ? _offset : offset;
    }
    
    private func checkVisibleCells(){
        if !self.collectionView.indexPathsForVisibleItems.isEmpty && self.collectionView.visibleCells.count > 0{
            for indexPath in self.collectionView.indexPathsForVisibleItems{
                if(self.indexPathsAnalytics[indexPath] == nil){
                    if(indexPath.row != self.configSection.arrayModules.count){
                        if let cell = self.collectionView.cellForItem(at: indexPath) as? SDKFrontModule{
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
        //AnalyticsManager.shared.callEventForModule(contentType: name, referrerCardId: self.cardDetail.cardId, referrerType: self.cardDetail.type.rawValue);
    }
    
    //MARK: Section delegate
    
    func getParentSize(indexPath: IndexPath) -> CGSize {
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            if (!ApiSDKConfiguration.separators || indexPath.row == 0 || indexPath.row % 2 == 0) {
                
                let height = (collectionView.bounds.width * 170) / 250
                let width = (collectionView.bounds.height * 250) / 170
                
                return layout.scrollDirection == .vertical ? CGSize(width: collectionView.bounds.width, height: height) : CGSize(width: width, height: collectionView.bounds.height)
            } else {
                return layout.scrollDirection == .vertical ? CGSize(width: collectionView.bounds.width, height: 2) : CGSize(width: 2, height: collectionView.bounds.height)
            }
        }
        
        return CGSize.zero
        
    }
    
    /**
     Reload tableview and calls tab menu to refresh if exists.
     */
    func reloadTableAndOffset() {
        
        let offset = self.collectionView.contentOffset.y;
        self.collectionView.reloadData();
        
        if (self.collectionView.contentSize.height > self.collectionView.frame.height) {
            self.collectionView.layoutIfNeeded();
            self.collectionView.contentOffset.y = self.getScrollViewOffset(offset);
        }
    }
    
    func reloadTable() {
        self.collectionView.reloadData();
    }
    
    
    func setController(viewController: UIViewController) {
        self.controller = viewController;
    }
    
    func updateIndexPathAnalytics(indexPath: IndexPath, indexPathsAnalytics: [IndexPath]) {
        self.indexPathsAnalytics[indexPath] = indexPathsAnalytics;
    }
    
    // MARK: UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (ApiSDKConfiguration.separators) {
            return (self.configSection.arrayModules.count * 2) - 1
        } else {
            return self.configSection.arrayModules.count
        }
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (!ApiSDKConfiguration.separators || indexPath.row == 0 || indexPath.row % 2 == 0) {
            
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.configSection.arrayModules[indexPath.row / 2].moduleName!, for: indexPath) as! SDKFrontModule
            cell.sectionDelegate = self;
            cell.cardDelegate = self.cardDelegate;
            cell.backgroundColor = .clear
            cell.backgroundView?.backgroundColor = .clear
            //cell.setIndexPathsAnalytics(indexPath: indexPath, indexPathsAnalytics: self.indexPathsAnalytics[indexPath] == nil ? [IndexPath]() : self.indexPathsAnalytics[indexPath]!);
            cell.indexPath = indexPath
            cell.setCardDetail(self.configSection.arrayModules[(indexPath as NSIndexPath).row / 2], _cardDetail: self.cardDetail);
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return cell;
        } else {
            
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: C.Cell.nativeCell, for: indexPath)
            cell.backgroundView?.backgroundColor = .white
            cell.backgroundColor = .white
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ApiSDKConfiguration.minimunSpaceCells
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.getParentSize(indexPath: indexPath)
    }
    
    
    // MARK: Selector
    func saveCard(){
        
        self.cardDetail.user?.isLiked = self.cardDetail.user?.isLiked != nil ? !self.cardDetail.user!.isLiked! : false
        
        let like = UIBarButtonItem(image: (self.cardDetail.user?.isLiked)! ? #imageLiteral(resourceName: "ico_like_active") : #imageLiteral(resourceName: "ico_like"), style: .plain, target: self, action: #selector(Section.saveCard));
        //like.tintColor = UIColor.diveWarmGreyColor();
        
        let more = UIBarButtonItem(image: #imageLiteral(resourceName: "ico_more"), style: .plain, target: self, action: #selector(Section.openOptions));
        //more.tintColor = UIColor.diveWarmGreyColor();
        
        self.navigationItem.rightBarButtonItems = [more, like];

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: C.NotificationNames.addLikeNotification), object: self.cardDetail);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: C.NotificationNames.changeLikeProductNotification), object: self.cardDetail);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: C.NotificationNames.addLikeMenuItemNotification), object: self.cardDetail);
        
        self.cardDelegate?.addRemoveLike(cardId: self.cardDetail.cardId, like: (self.cardDetail.user?.isLiked!)!, completion: { (statusCode) in
            print("");
        })
        
        //AnalyticsManager.shared.callEventForLikeUnlike(cardId: self.cardDetail.cardId, liked: self.cardDetail.user?.isLiked);
    }
    
    func openOptions(){
        
        self.cardDelegate?.shareOptions()
        
    }
    
    // MARK: ScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.finishReload){
            self.checkVisibleCells();
        }
    }
    
}
