//
//  DetailsViewController.h
//  TMDb-Api
//
//  Created by Zup Beta on 27/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) MoviePropertyObject *movieDetail;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleDesc;
@property (strong, nonatomic) IBOutlet UILabel *genreLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreDesc;
@property (strong, nonatomic) IBOutlet UILabel *actorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsDesc;
@property (strong, nonatomic) IBOutlet UILabel *directorLabel;
@property (strong, nonatomic) IBOutlet UILabel *directorDesc;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearDesc;
@property (strong, nonatomic) IBOutlet UILabel *overviewLabel;
@property (strong, nonatomic) IBOutlet UILabel *overviewDesc;

@end
