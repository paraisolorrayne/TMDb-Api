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
static NSString *const kSearchMovieWithKey = @"search/movie?";
static NSString *const kSearchMoviePopular = @"movie/popular?";
static NSString *const kLanguageUS = @"&language=en-US&";
static NSString *const kLanguageBR = @"&language=pt-BR&";
static NSString *const kTMDbMovieSearchPath = @"search/movie";
static NSString *const kTMDbSearchParamQueryKey = @"query";
static NSString *const kTMDbSearchResultsKey = @"results";
static NSString *const kTMDbSearchResultsObjectIdKey = @"id";
static NSString *const kTMDbObjectIdKey = @"id";

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
        [_manager.requestSerializer setTimeoutInterval:45];
        self.manager.responseSerializer = [AFJSONResponseSerializer new];
    }
    return self;
}

- (void)fetchMovies:(NSString *)query success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
     NSString *completeUrl = [NSString stringWithFormat:@"%@%@%@&query=%@", kUrlBase, kSearchMovieWithKey, kApiKey, query];
    NSDictionary *params = @{@"results": query ?: NSNull.null};
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"%@", params);
        //results similar ao Search da OMDB na qual identifica onde começa a resposta do array de json
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

-(void)fetchPopular:(NSString *)page success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSString *completeUrl = [NSString stringWithFormat:@"%@%@%@%@%@", kUrlBase, kSearchMoviePopular, page, kLanguageBR, kApiKey];
    NSDictionary *params = @{@"results": page ?: NSNull.null};
    [self.manager GET:completeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"%@", params);
        //results similar ao Search da OMDB na qual identifica onde começa a resposta do array de json
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
