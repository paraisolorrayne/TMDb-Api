//
//  HomeViewController.h
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlOption;
@property (strong, nonatomic) IBOutlet UIView *iCarouselView;
@property (strong, nonatomic) IBOutlet UILabel *popularLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *popularCollectionView;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResultsPop;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;
@end
