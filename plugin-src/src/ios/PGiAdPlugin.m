

#import "PGiAdPlugin.h"

@interface PGiAdPlugin () {}

@end

@implementation PGiAdPlugin

-(void)init:(CDVInvokedUrlCommand*)command
{
    NSLog(@"PGiAdPlugin init");
    
    Class adBannerViewClass = NSClassFromString(@"ADBannerView");
    if (adBannerViewClass && !_bannerView)
    {
        _bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        _bannerView.delegate = self;
        [[[super webView] superview] addSubview:_bannerView];
    }

}

-(void)showAd:(CDVInvokedUrlCommand*)command
{
    if (!_bannerView)
    {
        [self init:NULL];
        [self layoutAnimated:NO];
    }
}

-(void)hideAd:(CDVInvokedUrlCommand*)command
{
    // TODO:
}

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = [[super webView] superview].bounds;
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded)
    {
        contentFrame.size.height -= _bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        [super webView].frame = contentFrame;
        [[super webView] layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}


#pragma mark -
#pragma ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    // TODO: notify js
    NSLog(@"Banner view has loaded a banner");
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError*)error
{
    // TODO: hide the frame, and notify js
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    if (!willLeave)
    {
        // TODO: dispatch event and suspend any services that might conflict with the advertisement
    }
    else {
        // TODO: dispatch event
    }
    return YES;
}

@end
