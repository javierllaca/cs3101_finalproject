//
//  JLONote.h
//  Notes
//
//  Created by Javier Llaca on 4/22/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLONote : NSObject

@property NSString  *title;
@property NSString  *body;
@property NSDate    *date;
@property NSString  *location;
@property UIImage   *picture;

@end
