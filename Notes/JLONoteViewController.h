//
//  JLONoteViewController.h
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLONote.h"

@interface JLONoteViewController : UIViewController

@property (strong, nonatomic) JLONote *note;

- (id)initWithNote:(JLONote *)note;

@end
