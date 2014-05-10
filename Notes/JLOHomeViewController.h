//
//  JLOHomeViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLOTitleInputViewController.h"
#import "JLONoteViewController.h"
#import "JLOAppDelegate.h"

#define CELL_HEIGHT 80.0

@interface JLOHomeViewController : UIViewController <UINavigationControllerDelegate,
    UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *notes;

// Load notes from disk
- (void)loadStoredNotes;

// Setup edit and add note button in navigation bar
- (void)setNavigationBarButtons;

// Delete note from disk
- (void)deleteNote:(JLONote *)note;

// Add note to list
- (void)addNote:(UIBarButtonItem *)sender;

// Returns a square subsection from center of image to be used as a thumbnail
- (UIImage*)imageThumbnail:(UIImage *)image;


@end
