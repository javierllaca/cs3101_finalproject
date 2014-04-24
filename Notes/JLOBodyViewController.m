//
//  JLOBodyViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOBodyViewController.h"
#import "JLOImageViewController.h"

@interface JLOBodyViewController ()

@end

@implementation JLOBodyViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Content";
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Picture"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLOImageViewController *imageVC = [[JLOImageViewController alloc] init];
    [self.navigationController pushViewController:imageVC animated:YES];
}

@end
