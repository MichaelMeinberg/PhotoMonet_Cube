//
//  Cube.h
//  PhotoMonet Cube
//
//  Created by Michael on 12/14/14.
//  Copyright (c) 2014 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photos;

@interface Cube : NSManagedObject

@property (nonatomic, retain) NSNumber * cubeID;
@property (nonatomic, retain) NSNumber * cubeName;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) Photos *photos;

@end
