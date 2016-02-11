//
//  AOAWineViewController.m
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWineViewController.h"
#import "AOAWebViewController.h"


@implementation AOAWineViewController


-(id) initWithModel:(AOAWineModel *) aModel
{
    if(self = [super initWithNibName: nil
                              bundle: nil]){
        _model = aModel;
        self.title = self.model.name;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed: 0.5
                                                                        green: 0
                                                                         blue: 0.13
                                                                        alpha: 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions
-(IBAction)displayWeb:(id)sender{
    AOAWebViewController * webVC = [[AOAWebViewController alloc] initWithModel: self.model];
    
    [self.navigationController pushViewController:webVC animated:YES];

}


#pragma mark - Utility

-(void) syncModelWithView {
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    [self.notesLabel setNumberOfLines:0];
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString:self.model.grapes];
    [self displayRating:self.model.rating];
}

-(NSString *)arrayToString:(NSArray *) anArray
{
    NSString *repr = nil;
    
    if([anArray count] == 1) {
        repr = [@"100%" stringByAppendingString:[anArray lastObject]];
    } else {
        repr = [[anArray componentsJoinedByString:@", "]stringByAppendingString: @"."];
    }
    return repr;
}

-(void) displayRating:(int) aRating
{
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"glass.jpg"];
    
    for (int i = 0; i< aRating; i++) {
        [[self.ratingViews objectAtIndex: i]setImage:glass];
    }
}

-(void) clearRatings
{
    for (UIImageView *imageView in  self.ratingViews) {
        imageView.image = nil;
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

#pragma mark - SplitView Delegate

-(void) splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

-(void) splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}


-(void) wineryTableViewController:(AOAWineryTableViewController *) wineryVC
                  didSelectedWine: (AOAWineModel *) aWine
{
    self.model = aWine;
    self.title = aWine.name;
    
    [self syncModelWithView];
}

@end
