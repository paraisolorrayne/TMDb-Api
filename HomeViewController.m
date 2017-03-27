//
//  HomeViewController.m
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "HomeViewController.h"
#import "TMDbService.h"
#import "MovieCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString *const kTMDbPosterPath = @"http://image.tmdb.org/t/p/w185/";

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSString *movieName;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchPopular];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectSegment:(id)sender {
    switch (self.segmentedControlOption.selectedSegmentIndex) {
        case 0:
            //aba favoritos exibe os filmes salvos
            self.popularLabel.text =@"Segment 1 selected.";
            break;
        case 1:
            //aba lançamentos exibe os filmes do ano
            self.popularLabel.text =@"Segment 2 selected.";
            break;
        case 2:
            //aba gêneros exibe os filmes por gênero
            self.popularLabel.text = @"Segment 3 selected.";;
            break;
        default:
            break;
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //abre teclado
    [_searchBar becomeFirstResponder];
    [self connectInternet];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}


- (void)setupSearchBar {
    self.navigationItem.titleView = _searchBar;
    _movieName = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //abre o teclado
    [_searchBar becomeFirstResponder];
    [self connectInternet];
}

-(void)connectInternet {
    NSURL *scrpitURL = [NSURL URLWithString:@"https://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scrpitURL];
    if (data) {
        _movieName = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //esconde teclado
        [_searchBar resignFirstResponder];
       
        if ([_searchBar.text  isEqual: @""]) {
           //vazio
        }
        _movieName = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self searchMovie];
        
    }
    else {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Sem conexão com a Internet!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:^{
                                     [self.view endEditing:YES];
                                     [_searchBar resignFirstResponder];
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }

    
}

-(void)searchMovie {
    [[TMDbService defaultService]fetchMovies:_movieName success:^(NSArray<MoviePropertyObject*> *movieCollectionResults) {
        self.movieCollectionResults = [(self.movieCollectionResults ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResults];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
    
}

-(void)searchPopular {
    NSString *pagina = @"1";
    [[TMDbService defaultService]fetchPopular:pagina success:^(NSArray<MoviePropertyObject*> *movieCollectionResultsPopular) {
        self.movieCollectionResultsPop = [(self.movieCollectionResultsPop ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResultsPopular];
        [self.popularCollectionView reloadData];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
}

- (IBAction)searchMovie:(id)sender {
    [self connectInternet];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieCollectionResultsPop.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"popular" forIndexPath:indexPath];
    
    MoviePropertyObject *movie = self.movieCollectionResultsPop [indexPath.row];
    NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, movie.poster_pathUrl];
    NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
    [cell.posterCollection setImageWithURL:posterUrlComplete];
    
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
        NSString *imageNameToLoad = [NSString stringWithFormat:@"%ld_full", (long)selectedIndexPath.row];
        UIImage *image = [UIImage imageNamed:imageNameToLoad];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.imageDetail = image;
    }
    */
}


@end
