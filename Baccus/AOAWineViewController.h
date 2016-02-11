//
//  AOAWineViewController.h
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOAWineModel.h"
#import "AOAWineryTableViewController.h"

@interface AOAWineViewController : UIViewController <UISplitViewControllerDelegate, AOAWineryTableViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;


@property (strong, nonatomic)  AOAWineModel *model;

-(id) initWithModel:(AOAWineModel *) aModel;


-(IBAction)displayWeb:(id)sender;

@end
