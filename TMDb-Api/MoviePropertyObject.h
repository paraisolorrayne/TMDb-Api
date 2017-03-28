//
//  MoviePropertyObject.h
//  TMDb-Api
//
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePropertyObject : NSObject

//OMDB key
@property (strong, nonatomic) NSString *titleMovie;
@property (strong, nonatomic) NSURL *posterMovieURL;
@property (strong, nonatomic) NSString *yearMovie;
@property (strong, nonatomic) NSString *directorMovie;
@property (strong, nonatomic) NSString *actorsMovie;
@property (strong, nonatomic) NSString *genreMovie;
@property (strong, nonatomic) NSString *runtimeMovie;
@property (strong, nonatomic) NSString *plotMovie;
@property (strong, nonatomic) NSString *typeValue;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *posterImgMovie;
@property (strong, nonatomic) NSString *totalResults;

//TMDB
@property (strong, nonatomic) NSString *poster_path;
@property (strong, nonatomic) NSString *overview; //equals plot
@property (strong, nonatomic) NSString *original_title;
@property (strong, nonatomic) NSString *tmdbID;
@property (strong, nonatomic) NSString *release_date;
@property (strong, nonatomic) NSString *genre_ids;
@property (strong, nonatomic) NSString *homepage;


- (instancetype)initWithData:(NSDictionary *) jsonDataObject;


@end
