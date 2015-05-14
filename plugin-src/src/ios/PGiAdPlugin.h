
#import <Cordova/CDVPlugin.h>
#import <iAd/iAd.h>

@interface PGiAdPlugin : CDVPlugin<ADBannerViewDelegate>
{
    ADBannerView* _bannerView;
}

-(void)init:(CDVInvokedUrlCommand*)command;
-(void)showAd:(CDVInvokedUrlCommand*)command;

@end
