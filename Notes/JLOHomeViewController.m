//
//  JLOHomeViewController.m
//  Notes
//
//  Created by Javier Llaca on 4/20/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLOHomeViewController.h"

@implementation JLOHomeViewController

- (id)init
{
    self = [super init];
    return self;
}

- (void)loadView
{
    [super loadView];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    [_tableView setRowHeight:CELL_HEIGHT];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _notes = [[NSMutableArray alloc] init];
    [self.view addSubview:_tableView];
    [self loadStoredNotes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notes";
    self.navigationController.delegate = self;
    [self setNavigationBarButtons];
}

- (void) viewDidAppear:(BOOL)animated
{    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (JLONote *note in _notes) {
            if (!note.stored) {
                NSLog(@"%@", note);
                
                // Store in core data
                JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                NSManagedObjectContext *context = [appDelegate managedObjectContext];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date == %@)", note.date];
                NSFetchRequest *request = [[NSFetchRequest alloc] init];
                [request setEntity:[NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context]];
                [request setPredicate:predicate];
                
                NSError *error = nil;
                NSArray *results = [context executeFetchRequest:request error:&error];
                
                if ([results count] != 0)
                    [context deleteObject:[results firstObject]];
                
                NSManagedObject *newContact;
                newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:context];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:note];
                [newContact setValue:data forKey:@"note"];
                [newContact setValue:note.date forKey:@"date"];
                
                [context save:&error];
                
                note.stored = YES;
            }
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setNavigationBarButtons
{
    // add note button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // edit note list button
    UIBarButtonItem *edit = [[UIBarButtonItem alloc]
                             initWithTitle:@"Edit"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(toggleEditingMode:)];
    self.navigationItem.leftBarButtonItem = edit;
}

// Load from core data
- (void)loadStoredNotes
{
    JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context]];
    [request setPredicate:nil];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *matches = nil;
    if ([objects count] != 0) {
        for (int i = 0; i < [objects count]; i++) {
            matches = objects[i];
            NSData *data = [matches valueForKey:@"note"];
            JLONote *note = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.notes addObject:note];
        }
    }
}

// deletes note from core data
- (void)deleteNote:(JLONote *)note
{
    JLOAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(date == %@)", note.date];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    [context deleteObject:[results firstObject]];
    [context save:&error];
    [_notes removeObjectIdenticalTo:note];
}

#pragma Navigation Bar Button Methods

- (void)addNote:(UIBarButtonItem *)sender
{
    JLOTitleViewController *titleVC = [[JLOTitleViewController alloc] init];
    [self.navigationController pushViewController:titleVC animated:YES];
}

- (IBAction)toggleEditingMode:(id)sender
{
    if (_tableView.isEditing) {
        [sender setTitle:@"Edit"];
        [_tableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done"];
        [_tableView setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [_notes copy];
        JLONote *note = items[indexPath.row];
        [_notes removeObject:note];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        [self deleteNote:note];
    }
}

#pragma Table View Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _notes.count;
}

-(UIImage*)imageThumbnail:(UIImage *)original
{
    double width, height, originX, originY;
    if (original.size.width > original.size.height) {
        width = height = original.size.height;
        originX = (original.size.width - height) / 2;
        originY = 0;
    } else {
        width = height = original.size.width;
        originX = 0;
        originY = (original.size.height - width) / 2;
    }
    
    CGRect cropSquare = CGRectMake(originX, originY, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([original CGImage], cropSquare);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:original.imageOrientation];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    JLONote *note = _notes[indexPath.row];
    
    // Format the NSDate in an NSString (e.g. "May 5, 2014")
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:note.date];
    
    UIImageView *photo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    
    // If note has an image, setup a subview for it in the cell
    if (note.image) {
        double margin = 5.0;
        double sideLength = CELL_HEIGHT - 2 * margin;
        CGRect thumbnail = CGRectMake(self.view.frame.size.width - margin - sideLength, margin, sideLength, sideLength);
        photo = [[UIImageView alloc]initWithFrame:thumbnail];
        photo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        photo.image = [self imageThumbnail:note.image];
        [cell.contentView addSubview:photo];
    }
    
    // Assign the cell title and subtitle
    cell.textLabel.text = note.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = dateString;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLONoteViewController *detailVC = [[JLONoteViewController alloc] initWithNote:_notes[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end