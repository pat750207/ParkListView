//
//  ParkListViewController.m
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import "ParkListViewController.h"
#import "ParkDetailViewController.h"


@implementation ParkListViewController
@synthesize mParkList;
@synthesize mParkDetailList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mParkList = [[NSMutableArray alloc] init];
    mParkDetailList = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [mParkList objectAtIndex:section];
    return [dict objectForKey:@"ParkName"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mParkList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row)
    {
        case 0:
        {
            return 240;
            break;
        }
        case 1:
        {
            return 30;
            break;
        }
        case 2:
        {
            return 20;
            break;
        }
        case 3:
        {
            return UITableViewAutomaticDimension;
            break;
        }
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}

// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;

    NSString *CellIdentifier = [[NSString alloc] initWithFormat:@"ParkListCell%d%d",(int)section, (int)row];
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
                img.tag = IMAGE;
                [img setFrame:CGRectMake( 15, 5, 240, 180)];
                [cell.contentView addSubview:img];
            }
            UIImageView *img = (UIImageView*)[cell viewWithTag:IMAGE];
            NSDictionary *dict = [mParkList objectAtIndex:(int)section];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"Image"]]];
            if(imageData)
                img.image = [UIImage imageWithData:imageData];
            else
                img.image = [UIImage imageNamed:@"logo"];
            
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
            NSDictionary *dict = [mParkList objectAtIndex:(int)section];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
            cell.textLabel.text = [NSString stringWithString:[dict objectForKey:@"ParkName"]];

            
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
            NSDictionary *dict = [mParkList objectAtIndex:(int)section];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:18];
            cell.textLabel.text = [NSString stringWithString:[dict objectForKey:@"Name"]];
            
            
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
            NSDictionary *dict = [mParkList objectAtIndex:(int)section];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont fontWithName:@"Heiti SC" size:11];
            cell.textLabel.text = [NSString stringWithString:[dict objectForKey:@"Introduction"]];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
          
            
        
            return cell;
            
            break;
        }
    }
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ParkDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ParkDetailViewController"];
    mParkDetailList = [mParkList mutableCopy];
    
    for ( int index = [mParkList count]-1 ; index>=0 ; index--)
    {
        NSDictionary *data = [mParkList objectAtIndex:index];
        if(![[data objectForKey:@"ParkName"] isEqualToString:[[mParkList objectAtIndex:(int)section]objectForKey:@"ParkName"]])
            [mParkDetailList removeObjectAtIndex:index];
        else
            if([[data objectForKey:@"Name"] isEqualToString:[[mParkList objectAtIndex:(int)section]objectForKey:@"Name"]])
                [mParkDetailList removeObjectAtIndex:index];
    }
    
    NSLog(@"%d %d",[mParkList count] , [mParkDetailList count]);
    viewController.mParkDetail = [mParkList objectAtIndex:(int)section];
    viewController.mParkRelaList = mParkDetailList;
    [self.navigationController pushViewController:viewController animated:YES ];
    
    [_mParkListTable deselectRowAtIndexPath:indexPath animated:YES];
}


@end
