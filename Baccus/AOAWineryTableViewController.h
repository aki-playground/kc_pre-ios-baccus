//
//  AOAWineryTableViewController.h
//  Baccus
//
//  Created by Akixe on 8/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOAWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"


#define ROW_KEY @"row"
#define SECTION_KEY @"section"
#define LAST_WINE_KEY @"lastwine"

@class AOAWineryTableViewController;


@protocol AOAWineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController:(AOAWineryTableViewController *) wineryVC
                  didSelectedWine: (AOAWineModel *) aWine;

@end


@interface AOAWineryTableViewController : UITableViewController

@property (strong, nonatomic) AOAWineryModel * model;
@property (weak, nonatomic) id <AOAWineryTableViewControllerDelegate> delegate;

-(id) initWithModel: (AOAWineryModel *) aModel
              style: (UITableViewStyle) aStyle;
-(AOAWineModel *) lastSelectedWine;
@end


