//
//  SettingsViewController.m
//  TMDb-Api
//
//  Created by Zup Beta on 31/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *ptSelect;
@property (strong, nonatomic) IBOutlet UISwitch *enSelect;
@property (strong, nonatomic) IBOutlet UISwitch *frSelect;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveLanguage {
    if (_ptSelect.enabled) {
        _enSelect.enabled = YES;
        _frSelect.enabled = YES;
    } else if (_enSelect.enabled) {
        _ptSelect.enabled = YES;
        _frSelect.enabled = YES; 
    } else if (_frSelect.enabled) {
        _ptSelect.enabled = YES;
        _enSelect.enabled = YES;
    }
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
