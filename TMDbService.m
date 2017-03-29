//
//  TMDbService.m
//  TMDb-Api
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "TMDbService.h"
#import "MoviePropertyObject.h"

static NSString *const kUrlBase = @"https://api.themoviedb.org/3/";
static NSString *const kApiKey = @"api_key=625a7cbd9e0ae06da951620f6f0015d1";
static NSString *const kToken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjVhN2NiZDllMGFlMDZkYTk1MTYyMGY2ZjAwMTVkMSIsInN1YiI6IjU4ZDI4OWI3OTI1MTQxMWFmNDAyMDFmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PBEWV2bJThrDncjp314r3Ke_udps4Sp5UePZJ44iRGI";
static NSString *const kSearchMovie = @"search/movie?";
static NSString *const kSearchTV = @"search/tv";
static NSString *const kSearchMoviePopular = @"movie/popular?";
static NSString *const kSearchTVPopular = @"discover/tv?";
static NSString *const kLanguageUS = @"&language=en-US&";
static NSString *const kLanguageBR = @"&language=pt-BR&";
static NSString *const kTMDbMovieSearchPath = @"search/movie";
static NSString *const kTMDbSearchParamQueryKey = @"query";
static NSString *const kTMDbSearchResultsKey = @"results";
static NSString *const kTMDbSearchResultsObjectIdKey = @"id";


@interface TMDbService ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation TMDbService
+ (instancetype)defaultService {
    static TMDbService *__defaultService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultService = [[TMDbService alloc] init];
    });
    return __defaultService;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: kUrlBase] sessionConfiguration:nil];
        self.manager.requestSerializer = [AFJSONRequestSerializer new];
        [_manager.requestSerializer setTimeoutInterval:60];
        self.manager.responseSerializer = [AFJSONResponseSerializer new];
    }
    return self;
}

- (void)fetchMovies:(NSString *)query success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
     NSString *completeUrl = [NSString stringWithFormat:@"%@%@%@&query=%@", kUrlBase, kSearchMovie, kApiKey, query];
    NSDictionary *params = @{@"results": query ?: NSNull.null};
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"%@", params);
        NSArray *jsons = [response objectForKey: kTMDbSearchResultsKey];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];

}

-(void)fetchPopular:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@?1%@%@", kUrlBase, kSearchMoviePopular, kLanguageBR, kApiKey];
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSArray *jsons = [response objectForKey: kTMDbSearchResultsKey];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];
}

- (void)fetchTV:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@%@%@sort_by=popularity.desc&page=1&timezone=America/New_York&include_null_first_air_dates=false", kUrlBase, kSearchTVPopular, kApiKey, kLanguageBR];
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSArray *jsons = [response objectForKey: kTMDbSearchResultsKey];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];
    
}


-(void)captureGenreId:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSString *completeUrl = [NSString stringWithFormat:@"%@genre/movie/list?%@&language=%@", kUrlBase, kApiKey, kLanguageBR];
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSArray *jsons = [response objectForKey: kTMDbSearchResultsKey];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];
    
}

-(void)fetchGenre:(NSString *)idGenre success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSString *completeUrl = [NSString stringWithFormat:@"%@/discover/movie?%@&with_genres=%@", kUrlBase, kApiKey, idGenre];
    NSDictionary *params = @{@"results": idGenre ?: NSNull.null};
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"%@", params);
        NSArray *jsons = [response objectForKey: kTMDbSearchResultsKey];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];
}


@end
