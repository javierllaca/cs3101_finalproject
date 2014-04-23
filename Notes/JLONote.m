//
//  JLONote.m
//  Notes
//
//  Created by Javier Llaca on 4/22/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLONote.h"

@implementation JLONote

- (id)init
{
    self = [super init];
    if (self) {
        [self setDate:[NSDate date]];
    }
    return self;
}

- (void)attachPicture:(UIImage *) picture
{
    self.picture = picture;
}

@end