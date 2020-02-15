//
//  Photos.h
//  PhotoMonet Cube
//
//  Created by Michael on 12/14/14.
//  Copyright (c) 2014 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cube;

@interface Photos : NSManagedObject

@property (nonatomic, retain) NSNumber * cubeID;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSData * photo1;
@property (nonatomic, retain) NSData * photo2;
@property (nonatomic, retain) NSData * photo3;
@property (nonatomic, retain) NSData * photo4;
@property (nonatomic, retain) NSData * photo5;
@property (nonatomic, retain) NSData * photo6;
@property (nonatomic, retain) Cube *cube;

@end
