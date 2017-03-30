//
//  MovieMO.h
//  TMDb-Api
//
//  Created by Zup Beta on 30/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MovieMO : NSManagedObject
@property (strong, nonatomic) NSString *overview; //equals plot
@property (strong, nonatomic) NSString *original_title;
@property (strong, nonatomic) NSString *original_name;
@property (strong, nonatomic) NSString *homepage;
@property (strong, nonatomic) NSString *poster_path;
@end
