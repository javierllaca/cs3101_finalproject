//
//  JLONote.m
//  Notes
//
//  Created by Javier Llaca on 4/22/14.
//  Copyright (c) 2014 Llaca. All rights reserved.
//

#import "JLONote.h"

@implementation JLONote

- (id)initWithTitle:(NSString *)title Body:(NSString *)body Image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _title = title;
        _body = body;
        _image = image;
        _date = [NSDate date];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Title: %@\nBody: %@\nDate: %@",
            _title, _body, _date];
}

@end