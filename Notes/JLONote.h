//
//  JLONote.h
//  Notes
//
//  Created by Javier Llaca on 4/22/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLONote : NSObject

@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString  *body;
@property (strong, nonatomic) NSDate    *date;
@property (strong, nonatomic) UIImage   *image;

- (id)initWithTitle:(NSString *)title Body:(NSString *)body Image:(UIImage *)image;

@end
