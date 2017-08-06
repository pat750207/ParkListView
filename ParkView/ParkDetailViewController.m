//
//  ParkDetailViewController.m
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import "ParkDetailViewController.h"


@implementation ParkDetailViewController

@synthesize mParkDetail;
@synthesize mParkRelaList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //mParkRelaList = [[NSMutableArray alloc] init];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    switch (row)
    {
        case 0:
        {
            return 245;
            break;
        }
        case 1:
        {
            return 26;
            break;
        }
        case 2:
        {
            return 28;
            break;
        }
        case 3:
        {
            return 25;
            break;
        }
        case 4:
        {
            return 120;
            break;
        }
        case 5:
        {
            return 30;
            break;
        }
        case 6:
        {
            return 120;
            break;
        }
    }
     return UITableViewAutomaticDimension;
}

// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    NSString *CellIdentifier = [[NSString alloc] initWithFormat:@"ParkDetailListCell%d", (int)row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    switch (row)
    {
        case 0:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView *img = [[UIImageView alloc] init];
                img.tag = IMAGECELL;
                [img setFrame:CGRectMake( 15, 5, 240, 180)];
               
                [cell.contentView addSubview:img];
            }
            UIImageView *img = (UIImageView*)[cell viewWithTag:IMAGECELL];
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[mParkDetail objectForKey:@"Image"]]];
            if(imageData)
                img.image = [UIImage imageWithData:imageData];
            
            CGFloat imageRatio = img.image.size.height / img.image.size.width;
            img.frame = CGRectMake(0, 0, (CGRectGetWidth(self.view.bounds)),(CGRectGetWidth(self.view.bounds)) * imageRatio > 240 ? 240 : (CGRectGetWidth(self.view.bounds)) * imageRatio );
            
            return cell;
            
            break;
        }
        case 1:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
            cell.textLabel.text = [NSString stringWithString:[mParkDetail objectForKey:@"ParkName"]];
            
            
            return cell;
            
            break;
        }
        case 2:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:18];
            cell.textLabel.text = [NSString stringWithString:[mParkDetail objectForKey:@"Name"]];
            
            
            return cell;
            
            break;
        }
        case 3:
        {
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:13];
            cell.textLabel.text = [NSString stringWithString:[NSString stringWithFormat:@"開放時間:%@",[mParkDetail objectForKey:@"OpenTime"]]];
            
            
            return cell;
            
            break;
        }
        case 4:
        {
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }

            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:11];
            cell.textLabel.text = [NSString stringWithString:[mParkDetail objectForKey:@"Introduction"]];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            
            return cell;
            
            break;
        }
        case 5:
        {
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
            cell.textLabel.text = @"相關景點";

            
            return cell;
            
            break;
        }
        case 6:
        {
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIScrollView *scrollView = [[UIScrollView alloc] init];
                scrollView.tag = SCROLLVIEWCELL;
                [scrollView setFrame:CGRectMake( 10, 0, (CGRectGetWidth(self.view.bounds))-10, 120)];
                [scrollView setContentSize:CGSizeMake((10+[mParkRelaList count]*120)+60, 120)];//60 for the end
                //[scrollView setPagingEnabled:YES];
                scrollView.delegate = self;
                menuPage = [[UIPageControl alloc] initWithFrame:CGRectMake(15, 115, 320, 36)];
                menuPage.numberOfPages = [mParkRelaList count] + ([mParkRelaList count] % 3 > 0 ?  1 : 0);
                menuPage.currentPage = 0;
                menuPage.pageIndicatorTintColor = [UIColor whiteColor];
                menuPage.currentPageIndicatorTintColor = [UIColor grayColor];
                menuPage.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
                
                //[scrollView  addSubview:menuPage];
                [cell.contentView  addSubview:scrollView];
                
            }
            UIScrollView *scrollView = (UIScrollView*)[cell viewWithTag:SCROLLVIEWCELL];
            for(int index=0 ; index<[mParkRelaList count] ; index++)
            {
                NSDictionary *parkData = [mParkRelaList objectAtIndex:index];
                UIImageView *parkImg = [[UIImageView alloc] init];
                [parkImg setFrame:CGRectMake( 10+(125*index), 5, 120, 90)];
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[parkData  objectForKey:@"Image"]]];
                if(imageData)
                    parkImg.image = [UIImage imageWithData:imageData];
                else
                    parkImg.image = [UIImage imageNamed:@"logo"];
                
                UILabel *parkName = [[UILabel alloc] init];
                [parkName setFrame:CGRectMake( 10+(125*index), 93, 120, 30)];
                parkName.textColor = [UIColor blackColor];
                parkName.font = [UIFont fontWithName:@"Heiti SC" size:11];
                //NSLog(@"%@",[NSString stringWithString:[parkData  objectForKey:@"Name"]]);
                parkName.text = [NSString stringWithString:[parkData  objectForKey:@"Name"]];
                
                [scrollView addSubview:parkImg];
                [scrollView addSubview:parkName];
            }
            
            
         
            
            return cell;
            
            break;
        }
    }
    return cell;
}

#pragma mark -
#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //menuPage.currentPage = page;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
