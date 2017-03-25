//
//  TMDbService.h
//  TMDb-Api
//
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MoviePropertyObject.h"

@interface TMDbService : NSObject
+ (instancetype)defaultService;
- (void)fetchMovies:(NSString *)query success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error;
@end