//
//  AOAWebViewController.m
//  Baccus
//
//  Created by Akixe on 7/2/16.
//  Copyright © 2016 Akixe. All rights reserved.
//

#import "AOAWebViewController.h"
#import "AOAWineryTableViewController.h"

@implementation AOAWebViewController


- (id) initWithModel:(AOAWineModel *) aModel{
    if (self = [super initWithNibName: nil
                               bundle: nil]) {
        _model = aModel;
        self.title =@"Web";
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    [self displayURL : self.model.wineCompanyWeb];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector: @selector(wineDidChange:)
                               name: NEW_WINE_NOTIFICATION_NAME
                             object: nil];
    
}

-(void) wineDidChange:(NSNotification *) notification
{
    NSDictionary *dict = [notification userInfo];
    AOAWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    
    self.model = newWine;
    [self displayURL: self.model.wineCompanyWeb];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate protocol
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView setHidden:YES];
}

#pragma mark - Utility
-(void) displayURL: (NSURL *) aURL {
    self.browser.delegate = self;
    [self.browser loadRequest: [NSURLRequest requestWithURL: aURL]];
}

@end
