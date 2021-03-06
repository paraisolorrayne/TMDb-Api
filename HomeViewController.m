//
//  HomeViewController.m
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "HomeViewController.h"
#import "MovieMO.h"
#import "AppDelegate.h"

static NSString *const kTMDbPosterPath = @"http://image.tmdb.org/t/p/w185/";

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSArray <MovieMO *> *movies;
@end

@implementation HomeViewController

BOOL selectedSegmentA;
BOOL selectedSegmentB;
BOOL selectedSegmentC;

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    self.movies = [context executeFetchRequest:fetchRequest error:&error];
    if (!self.movies) {
        NSLog(@"Error fetching Movie objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    _menuView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    _load.hidden = NO;
    [self searchPopular];
    self.carousel.type = iCarouselTypeRotary;
    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    self.carousel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_carousel];
    [self.carousel reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)openSettings:(id)sender {

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //abre teclado
    [_searchBar becomeFirstResponder];
    [self connectInternet];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
-(NSString*)searchString: editString {
    NSString *str = [_searchBar.text stringByReplacingOccurrencesOfString:@" "
                                                              withString:@"+"];
    NSString *newString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSData *data = [newString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    _movieName = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return _movieName;
}

- (void)setupSearchBar {
    [_searchBar becomeFirstResponder];
    [self connectInternet];
}

-(void)connectInternet {
    [self searchString:_movieName];
    NSURL *scrpitURL = [NSURL URLWithString:@"https://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scrpitURL];
    if (data) {
        [_searchBar resignFirstResponder];
        if ([_movieName isEqualToString:@""]) {
            UIAlertController * view=   [UIAlertController
                                         alertControllerWithTitle:@"O nome do filme não foi digitado!"
                                         message:@"Digite um filme"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [view dismissViewControllerAnimated:YES completion:^{
                                     }];
                                 }];
            [view addAction:ok];
            [self presentViewController:view animated:YES completion:nil];
        } else if ([_movieName length] == 1 || [_movieName length] == 2) {
            UIAlertController * view=   [UIAlertController
                                         alertControllerWithTitle:@"Busca inválida"
                                         message:@"Digite o nome de um filme com mais de 3 caracteres!"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [view dismissViewControllerAnimated:YES completion:^{
                                     }];
                                 }];
            [view addAction:ok];
            [self presentViewController:view animated:YES completion:nil];
            NSLog(@"Digite uma busca com mais de 3 caracteres");
        } else {
            [self.carousel reloadData];
            [self searchMovie];
        }
    }
    else {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:[NSString stringWithFormat:@"Sem conexão com a Internet!@"]
                                     preferredStyle:UIAlertControllerStyleAlert];
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
    [_load startAnimating];
    [_searchBar resignFirstResponder];
    [[TMDbService defaultService]fetchMovies:_movieName success:^(NSArray<MoviePropertyObject*> *movieCollectionResults) {
        self.movieCollectionResults = [(self.movieCollectionResults ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResults];
        [_load stopAnimating];
        _load.hidesWhenStopped = TRUE;
        [self.carousel reloadData];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
}

-(void)searchTV {
    [self.carousel reloadData];
    [[TMDbService defaultService]fetchTV:^(NSArray<MoviePropertyObject*> *movieCollectionResultsPopular) {
        self.movieCollectionResults = [(self.movieCollectionResults ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResultsPopular];
        [self.carousel reloadData];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
}

-(void)searchPopular {
    _loading.hidden = NO;
    [_loading startAnimating];
    [[TMDbService defaultService]fetchPopular:^(NSArray<MoviePropertyObject*> *movieCollectionResultsPopular) {
        self.movieCollectionResultsPop = [(self.movieCollectionResultsPop ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResultsPopular];
        [self.popularCollectionView reloadData];
        [_loading stopAnimating];
        _loading.hidesWhenStopped = TRUE;
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
}

-(NSString *)selectGenre {
    [[TMDbService defaultService]captureGenreId:^(NSArray<MoviePropertyObject*> *movieCollectionGenreId) {
        self.movieCollectionResultsPop = [(self.movieCollectionResultsPop ?: @[]) arrayByAddingObjectsFromArray:movieCollectionGenreId];
        [_loading stopAnimating];
        _loading.hidesWhenStopped = TRUE;
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];
    return _movieCollectionResultsPop.firstObject.genreId;
    //error: property 'genreId' not found on object of type 'id _Nullable'
}

-(void)searchGenre {
    NSString *genreid = @"28";
    [[TMDbService defaultService]fetchGenre:genreid success:^(NSArray<MoviePropertyObject*> *movieCollectionResultsPopular) {
        self.movieCollectionResultsPop = [(self.movieCollectionResultsPop ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResultsPopular];
        [self.popularCollectionView reloadData];
        [_loading stopAnimating];
        _loading.hidesWhenStopped = TRUE;
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
    } ];

}

#pragma mark - Actions

- (IBAction)searchMovie:(id)sender {
    [self.carousel reloadData];
    [self connectInternet];
    [_searchBar resignFirstResponder];
}

- (IBAction)selectSegment:(id)sender {
    switch (self.segmentedControlOption.selectedSegmentIndex) {
        case 0:
            selectedSegmentA  = TRUE;
            [self.carousel setContentOffset:CGSizeZero];
            [self.carousel reloadData];
            break;
        case 1:
            selectedSegmentB = TRUE;
            [self.carousel setContentOffset:CGSizeZero];
            [self.carousel reloadData];
            [self searchTV];
            break;
        case 2:
            selectedSegmentC = TRUE;
            [self.carousel setContentOffset:CGSizeZero];
            [self.carousel reloadData];
            [self searchGenre];
            break;
        default:
            break;
    }
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    if (selectedSegmentA ) {
        return self.movies.count;
    } else return self.movieCollectionResults.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    CarouselFilmView *cellView = [CarouselFilmView instanceFromXIB];
    cellView.frame = CGRectMake(0, 0, carousel.bounds.size.width*0.8, 200);
    if (selectedSegmentA) {
        MovieMO *movie = self.movies [index];
        if (selectedSegmentC) {
            cellView.titleLabelFilm.text = [NSString stringWithFormat:@"%@", movie.original_name];
            selectedSegmentB = NO;
        } else {
            cellView.titleLabelFilm.text = [NSString stringWithFormat:@"%@", movie.original_title];
        }
        NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, movie.poster_path];
        NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
        [cellView.posterFilm cancelImageDownloadTask];
        cellView.posterFilm.image = [UIImage imageNamed:@"defaultImage"];
        if (!_movie.posterMovieUrl) {
            [cellView.posterFilm setImageWithURL:posterUrlComplete];
        }
        selectedSegmentA = NO;
    } else {
        _movie = self.movieCollectionResults[index];
        if (selectedSegmentB) {
            cellView.titleLabelFilm.text = [NSString stringWithFormat:@"%@", _movie.original_name];
            selectedSegmentB = NO;
        } else {
            cellView.titleLabelFilm.text = [NSString stringWithFormat:@"%@", _movie.original_title];
        }
        [cellView.posterFilm cancelImageDownloadTask];
        cellView.posterFilm.image = [UIImage imageNamed:@"defaultImage"];
        if (!_movie.posterMovieUrl) {
            NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, _movie.poster_path];
            NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
            [cellView.posterFilm setImageWithURL:posterUrlComplete];
        }
    }
    return cellView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(__unused NSInteger)index {
    DetailsViewController *movieDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Details"];
    MoviePropertyObject *movie = self.movieCollectionResults [index];
    movieDetailView.movieDetail = movie;
    [self.navigationController pushViewController:movieDetailView animated:YES];
}

- (void)removeItemAtIndex:(NSInteger)index animated:(BOOL)animated {
    index = _carousel.currentItemIndex;
    [_carousel removeItemAtIndex:index animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieCollectionResultsPop.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"popular" forIndexPath:indexPath];
    MoviePropertyObject *movie = self.movieCollectionResultsPop [indexPath.row];
    NSString *posterUrlcomplete = [NSString stringWithFormat:@"%@%@", kTMDbPosterPath, movie.poster_path];
    NSURL *posterUrlComplete = [NSURL URLWithString:posterUrlcomplete];
    [cell.posterCollection setImageWithURL:posterUrlComplete];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" segue para a tela de detalhes do filme");
    DetailsViewController *movieDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Details"];
    MoviePropertyObject *movie = self.movieCollectionResultsPop [indexPath.row];
    movieDetailView.movieDetail = movie;
    [self.navigationController pushViewController:movieDetailView animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
