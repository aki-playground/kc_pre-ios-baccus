//
//  AOAWebViewController.h
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOAWineModel.h"

@interface AOAWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) AOAWineModel * model;
@property (weak, nonatomic) IBOutlet UIWebView * browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

-(id) initWithModel:(AOAWineModel *) aModel;
@end
