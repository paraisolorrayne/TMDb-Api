//
//  ViewController.m
//  TMDb-Api
//
//  Created by Lorrayne Paraiso on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "ViewController.h"
#import "TMDbService.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *overwriteLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"";
    self.overwriteLabel.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchMovie:(id)sender {
    [self buscaFilme];
}

-(void)buscaFilme {
    NSString *filme = @"matrix";
    [[TMDbService defaultService]fetchMovies:filme success:^(NSArray<MoviePropertyObject*> *movieCollectionResults) {
        self.movieCollectionResults = [(self.movieCollectionResults ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResults];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
        NSLog(@"%@", _movieCollectionResults);
    } ];
    self.titleLabel.text = _movieCollectionResults.lastObject.original_title;
    self.overwriteLabel.text = _movieCollectionResults.lastObject.overview;
}

-(void)busca {
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=%3C%3Capi_key%3E%3E"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}

@end
