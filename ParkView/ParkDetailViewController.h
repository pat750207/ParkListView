//
//  ParkListViewController.h
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

enum DETAIL_CELL_TAG
{
    IMAGECELL = 1,
    SCROLLVIEWCELL
};

@interface ParkDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
{
    __weak IBOutlet UITableView *mParkDetailListTable;
    UIPageControl* menuPage;
}

@property (strong, nonatomic)NSDictionary* mParkDetail;
@property (strong, nonatomic)NSMutableArray* mParkRelaList;

@end

