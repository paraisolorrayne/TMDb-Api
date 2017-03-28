//
//  CarouselFilmView.m
//  TMDb-Api
//
//  Created by Zup Beta on 28/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "CarouselFilmView.h"

@implementation CarouselFilmView
+(instancetype) instanceFromXIB {
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"carouselFilmView" owner:self options:nil];
    CarouselFilmView *cellView = subviewArray.firstObject;
    return cellView;
}
@end
