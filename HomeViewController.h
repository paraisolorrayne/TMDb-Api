//
//  HomeViewController.h
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"
#import "TMDbService.h"
#import "MovieCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DetailsViewController.h"
#import <iCarousel/iCarousel.h>
#import "CarouselFilmView.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlOption;
@property (strong, nonatomic) IBOutlet UILabel *popularLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *popularCollectionView;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResultsPop;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResultsTV;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;
@property (strong, nonatomic) MoviePropertyObject *movie;
@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *load;


@end
