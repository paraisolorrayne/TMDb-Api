//
//  MoviePropertyObject.m
//  TMDb-Api
//
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "MoviePropertyObject.h"

@implementation MoviePropertyObject
- (instancetype)initWithData:(NSDictionary *)jsonDataObject
{
    self = [super init];
    
    if (self) {
        //OMDb
        _titleMovie = jsonDataObject[@"Title"];
        _yearMovie = jsonDataObject[@"Year"];
        _runtimeMovie = jsonDataObject [@"Runtime"];
        _genreMovie = jsonDataObject [@"Genre"];
        _directorMovie = jsonDataObject[@"Director"];
        _actorsMovie = jsonDataObject [@"Actors"];
        _plotMovie = jsonDataObject [@"Plot"];
        _typeValue = jsonDataObject [@"Type"];
        _imdbID = jsonDataObject [@"imdbID"];
        _totalResults = jsonDataObject [@"totalResults"];
        _posterImgMovie = jsonDataObject [@"Poster"];
        _posterMovieURL = [NSURL URLWithString:_posterImgMovie];
        
        //TMDb
        _poster_path = jsonDataObject[@"poster_path"];
        _poster_pathUrl = [NSURL URLWithString:_poster_path];
        _overview = jsonDataObject[@"overview"];
        _original_title = jsonDataObject[@"original_title"];
        _tmdbID = jsonDataObject[@"imdb_id"];
        _release_date = jsonDataObject[@"release_date"];
        _genre_ids = jsonDataObject[@"genre_ids"];
        _homepage = jsonDataObject[@"homepage"];
        
    }
    
    return self;
}
@end
