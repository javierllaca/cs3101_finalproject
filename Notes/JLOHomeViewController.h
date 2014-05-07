//
//  JLOHomeViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOTitleViewController.h"
#import "JLONoteViewController.h"
#import "JLOAppDelegate.h"

@interface JLOHomeViewController : UIViewController <UINavigationControllerDelegate,
    UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

// retrieve stored notes using core data
- (void)loadStoredNotes;

// add note to list
- (void)addNote:(UIBarButtonItem *)sender;

@end
