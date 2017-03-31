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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveLanguage {
    if (_ptSelect.enabled) {
        
    } else if (_enSelect.enabled) {
        
    } else if (_frSelect.enabled) {
        
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
