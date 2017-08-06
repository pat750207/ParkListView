//
//  ParkListViewController.h
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CELL_TAG
{
    IMAGE = 1,

};

@interface ParkListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{

}
@property (weak, nonatomic) IBOutlet UITableView *mParkListTable;
@property (strong, nonatomic)NSMutableArray* mParkList;
@property (strong, nonatomic)NSMutableArray* mParkDetailList;

@end

