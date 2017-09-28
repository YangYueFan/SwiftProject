//
//  KenCollectionCTL.swift
//  Swift_Project5_CollectionViewAnimation
//
//  Created by 科技部2 on 2017/9/27.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit

class KenCollectionCTL: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    private struct Constants {
        static let AnimationDuration: Double = 1.0
        static let AnimationDelay: Double = 0.0
        static let AnimationSpringDamping: CGFloat = 0.5
        static let AnimationInitialSpringVelocity: CGFloat = 5
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var indexRow = -1
    
    //懒加载
    lazy var dataArr:[String] = {
        return ["01","02","03","04","05","06","07","08"]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        myCollectionView.register(UINib.init(nibName: "KenCollectionCell", bundle: nil), forCellWithReuseIdentifier: "KenCollectionCell")
        
        bgImageViewUISet()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:KenCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KenCollectionCell", for: indexPath) as! KenCollectionCell
        cell.imgVIew.image = UIImage(named: dataArr[indexPath.row])
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0,15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width-30, height: 330.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell:KenCollectionCell = collectionView.cellForItem(at: indexPath) as? KenCollectionCell   else {
            return
        }
        self.handleAnimationCellSelected(collectionView: collectionView, cell: cell ,indexPath: indexPath)
    }

    
    private func handleAnimationCellSelected(collectionView: UICollectionView, cell: KenCollectionCell, indexPath:IndexPath ) {
        
        if cell.isBig {
            return
        }else{
            cell.isBig = true
            cell.rect = cell.frame
            //返回按钮闭包
            cell.backButtonTapped = backButtonDidTouch
            indexRow = indexPath.row
        }
        
        //动画
        let animations: () -> () = {
            var rect = cell.frame
            rect = CGRect(x: cell.rect.origin.x-15, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            cell.frame = rect
            self.navigationController?.navigationBar.alpha = 0.0;
            cell.backBtn.isHidden = false
            collectionView.isScrollEnabled = false
            cell.isSelected = true
            cell.layer.masksToBounds = false
        }
        
        // 动画结束
        let completion: (_ finished: Bool) -> () = { _ in
           
        }
        
        UIView.animate(withDuration: Constants.AnimationDuration,
                       delay: Constants.AnimationDelay,
                       usingSpringWithDamping: Constants.AnimationSpringDamping,
                       initialSpringVelocity: Constants.AnimationInitialSpringVelocity,
                       options: [],
                       animations: animations,
                       completion: completion)
    }
    
    
    func backButtonDidTouch() {
        
        guard let cell:KenCollectionCell = myCollectionView.cellForItem(at: IndexPath.init(row: indexRow, section: 0)) as? KenCollectionCell   else {
            return
        }
        
        cell.backBtn.isHidden = true
        
        let animations: () -> () = {
            cell.frame = cell.rect
            
            self.navigationController?.navigationBar.alpha = 1.0;
            cell.layer.masksToBounds = true
        }
        let completion: (_ finished: Bool) -> () = { _ in
            cell.isBig = false
            self.myCollectionView.isScrollEnabled = true
            self.myCollectionView?.reloadData()
            
        }
        
        UIView.animate(withDuration: Constants.AnimationDuration,
                       delay: Constants.AnimationDelay,
                       usingSpringWithDamping: Constants.AnimationSpringDamping,
                       initialSpringVelocity: Constants.AnimationInitialSpringVelocity,
                       options: [],
                       animations: animations,
                       completion: completion)
        
    }
    
    
    
    
    
    
    func bgImageViewUISet() {
        
        let blurEffect = UIBlurEffect.init(style: .prominent)
        let blurView   = UIVisualEffectView.init(effect: blurEffect)
        blurView.frame = self.view.bounds
        blurView.alpha = 0.7
        self.bgImageView .addSubview(blurView)
    }
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
