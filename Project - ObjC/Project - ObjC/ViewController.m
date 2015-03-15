

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "JavaScript.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JavaScript *javaScript = [JavaScript shared];
    
    [javaScript load];
    [javaScript update];
    sleep(1);
    [javaScript update];
    sleep(1);
    [javaScript update];
}


@end

