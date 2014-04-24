//
//  JLOTitleViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/23/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOTitleViewController.h"
#import "JLOBodyViewController.h"

@interface JLOTitleViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation JLOTitleViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Title";
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Content"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

- (void)nextButtonPressed:(UIBarButtonItem *)sender
{
    JLOBodyViewController *bodyVC = [[JLOBodyViewController alloc] init];
    [self.navigationController pushViewController:bodyVC animated:YES];
}

- (void)textFieldDidFinish:(UITextField *)textField
{
    
}

@end
