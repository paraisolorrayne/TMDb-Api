//
//  DetailsViewController.m
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "DetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "MovieMO.h"

static NSString *const kTMDbPosterPath = @"http://image.tmdb.org/t/p/w185/";
@interface DetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *posterFilm;
@property (strong, nonatomic) MovieMO *movie;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _overviewDesc.text = self.movieDetail.overview;
    _titleDesc.text = self.movieDetail.original_title;
    NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, _movieDetail.poster_path];
    NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
    [_posterFilm setImageWithURL:posterUrlComplete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)openTrailer:(id)sender {
    
    //url request to trailer
    /*
     api.themoviedb.org/3/movie/<movieid>/videos?api_key=<apikey>
     essa url retorna um json que contem:
     "results": [{
     "id": "58cfc8499251415a61037481",
     "iso_639_1": "en",
     "iso_3166_1": "US",
     "key": "XaE_9pfybL4",
     "name": "Official Trailer #2 [UK]",
     "site": "YouTube",
     "size": 1080,
     "type": "Trailer"
     pegar o campo key e setar na variavel trailer
     */
    NSString *trailer = @"RH3OxVFvTeg";
    
    NSURL *linkToAppURL = [NSURL URLWithString:[NSString stringWithFormat:@"youtube://watch/%@",trailer]];
    NSURL *linkToWebURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/watch/%@",trailer]];
    
    if ([[UIApplication sharedApplication] canOpenURL:linkToAppURL]) {
        // Can open the youtube app URL so launch the youTube app with this URL
        [[UIApplication sharedApplication] openURL:linkToAppURL];
    }
    else{
        // Can't open the youtube app URL so launch Safari instead
        [[UIApplication sharedApplication] openURL:linkToWebURL];
    }
}

-(void) saveInCoreData {
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movie"
                                              inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"original_title"
                                                                   ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    [request setSortDescriptors:sortDescriptors];
    
    NSError *Fetcherror;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&Fetcherror] mutableCopy];
    
    if (!mutableFetchResults) {
        NSLog(@"error handling code");
        // error handling code.
    }
    
    if ([[mutableFetchResults valueForKey:@"original_title"] containsObject:_movieDetail.original_title]) {
        //notify duplicates
        return;
    }
    else {
        //write your code to add data
    _movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
    _movie.original_title = _movieDetail.original_title;
    _movie.original_name = _movieDetail.original_name;
    _movie.overview = _movieDetail.overview;
    _movie.homepage = _movieDetail.homepage;
    NSError *error = nil;
    [context save:&error];
        if (error) {
        NSLog(@"%@", error);
        }
    }

    
}

- (IBAction)saveMovie:(id)sender {
    [self saveInCoreData];
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Success"
                                 message:@"Movie save"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //clear navigation stack
                                 NSArray *viewControllersFromStack = [self.navigationController viewControllers];
                                 for(UIViewController *currentVC in [viewControllersFromStack reverseObjectEnumerator]) {
                                     [currentVC.navigationController popViewControllerAnimated:NO];
                                 }
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                                 
                             }];
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
}


/* 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
