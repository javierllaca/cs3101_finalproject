//
//  JLOViewController.m
//  Note-Taker
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOViewController.h"
#import "JLONote.h"

@interface JLOViewController ()

@end

@implementation JLOViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    JLONote *note = [[JLONote alloc] init];
    NSLog(@"\nNote date: %@", [note date]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
