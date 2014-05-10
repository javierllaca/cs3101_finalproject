//
//  JLONote.h
//  Notes
//
//  Created by Javier Llaca on 4/22/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLONote : NSObject <NSCoding>

@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *body;
@property (strong, nonatomic) NSDate    *date;
@property (strong, nonatomic) UIImage   *image;
@property BOOL stored;

// Custom contructor
- (id)initWithTitle:(NSString *)title Body:(NSString *)body Image:(UIImage *)image;

// Returns a string with title, body, and date of image
- (NSString *)description;

@end
