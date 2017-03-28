//
//  CarouselFilmView.h
//  TMDb-Api
//
//  Created by Zup Beta on 28/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselFilmView : UIView <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *posterFilm;
@property (strong, nonatomic) IBOutlet UILabel *titleLabelFilm;
+(instancetype) instanceFromXIB;
@end
