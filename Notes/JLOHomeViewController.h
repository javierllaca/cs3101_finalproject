//
//  JLOHomeViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOTitleViewController.h"

@interface JLOHomeViewController : UIViewController <UITableViewDataSource,
    UITableViewDelegate, JLOTitleViewControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

@end
