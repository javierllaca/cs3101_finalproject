//
//  JLOHomeViewController.m
//  Note-Taker
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOHomeViewController.h"
#import "JLOTitleViewController.h"
#import "JLONote.h"

@interface JLOHomeViewController () <UITableViewDataSource, UITableViewDelegate, JLOTitleViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *strings;

@end

@implementation JLOHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                        action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    NSLog(@"Add Button Pressed");
    JLOTitleViewController *titleVC = [[JLOTitleViewController alloc] init];
    [self.navigationController pushViewController:titleVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifer"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellReuseIdentifer"];
    }
    
    cell.textLabel.text = self.strings[indexPath.row];
    
    return cell;
}

-(void)inputController:(JLOTitleViewController *)controller didFinishWithText:(NSString *)text
{
    
}

@end
