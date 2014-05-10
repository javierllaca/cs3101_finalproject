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
        _stored = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.body = [aDecoder decodeObjectForKey:@"body"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.body forKey:@"body"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Title: %@, Body: %@, Date: %@",
            _title, _body, _date];
}

@end