//
//  MoviePropertyObject.m
//  TMDb-Api
//
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "MoviePropertyObject.h"

@implementation MoviePropertyObject
- (instancetype)initWithData:(NSDictionary *)jsonDataObject {
    self = [super init];
    if (self) {
        //OMDb
        _runtimeMovie = jsonDataObject [@"Runtime"];
        _directorMovie = jsonDataObject[@"Director"];
        _actorsMovie = jsonDataObject [@"Actors"];
        _posterImgMovie = jsonDataObject [@"Poster"];
        _posterMovieUrl = [NSURL URLWithString:_posterImgMovie];
        
        //TMDb
        _poster_path = jsonDataObject[@"poster_path"];
        _overview = jsonDataObject[@"overview"];
        _original_title = jsonDataObject[@"original_title"];
        _original_name = jsonDataObject[@"original_name"];
        _tmdbID = jsonDataObject[@"imdb_id"];
        _release_date = jsonDataObject[@"release_date"];
        _genre_ids = jsonDataObject[@"genre_ids"];
        _homepage = jsonDataObject[@"homepage"];
        _genreId = jsonDataObject[@"id"];
        
    }
    return self;
}
@end
