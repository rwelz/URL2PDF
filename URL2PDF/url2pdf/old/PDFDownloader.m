//
//  PDFDownloader.m
//  URL2PDF
//
//  Created by Robert Welz on 19.03.17.
//
//

#import "PDFDownloader.h"
#import "WebKit/WebKit.h"

@implementation PDFDownloader

@synthesize loadComplete;
@synthesize pageTitle;

- (id)downloadURLs:(id)input parameters: (NSMutableDictionary *) parameters
{
    // Retrieve Parameters
    
    NSString *savePath = [ parameters objectForKey:@"savePath"];
    int fileNameFrom = [[ parameters objectForKey:@"fileNameFrom"] intValue];
    
    int printOrientation = [[ parameters objectForKey:@"printOrientation"] intValue];
    BOOL printPaginate = [[ parameters objectForKey:@"printPaginate"] boolValue];
    BOOL printBackgrounds = [[ parameters objectForKey:@"printBackgrounds"] boolValue];
    
    BOOL loadImages = [[ parameters objectForKey:@"loadImages"] boolValue];
    BOOL enableJavaScript = [[ parameters objectForKey:@"enableJavaScript"] boolValue];
    
    // Paper Size
    
    NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
    NSSize pageSize = [printInfo paperSize];
    
    int printWidth;
    int printHeight;
    switch (printOrientation) {
        case 0:
            printWidth = pageSize.width;
            printHeight = pageSize.height;
            break;
        case 1:
            printWidth = pageSize.height;
            printHeight = pageSize.width;
            break;
    }
    
    // Webview
    
    NSRect frame = NSMakeRect(0,0,500,900);
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:theConfiguration];
    webView.navigationDelegate = self;
    
    
    // Window
    
    NSWindow * window = [[NSWindow alloc]
                         initWithContentRect:NSMakeRect(0,0,1024,768)
                         styleMask:NSWindowStyleMaskBorderless
                         backing:NSBackingStoreNonretained defer:NO];
    [window setContentView:webView];
    
    NSMutableArray *output = [NSMutableArray arrayWithCapacity:[input count]];
    NSEnumerator *enumerate = [input objectEnumerator];
    NSURL *curURL;
    
//    while (curURL = [enumerate nextObject])
//    {
//        bool isRunning;
//        [self setPageTitle:nil];
//        [self setLoadComplete:NO];
//        
//        NSURL *nsurl=[NSURL URLWithString:@"http://www.apple.com"];
//        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:curURL];
//        [webView loadRequest:nsrequest];
//        
//    }
    
    NSURL *nsurl=[NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    
    
    NSString *saveFilePath = @"/Users/rwelz/URL2PDF Output/out.pdf";
    
    //[self printWebView:webView fileName:saveFilePath paginate:printPaginate orientation:printOrientation];
    //[[window contentView] dataWithPDFInsideRect: [window contentLayoutRect]];
    [output addObject:saveFilePath];
    
    return output;
}

- (void)printWebView:(WKWebView *) webView fileName:(NSString *)filename paginate:(BOOL)printPaginate orientation:(int)printOrientation
{
//    NSView *printView = webView.superview;
//    
//    NSRect printRect = [printView frame];
//    
//    NSData *printData = [printView dataWithPDFInsideRect:printRect];
//    
//    [printData writeToFile:filename atomically:YES];
    
    //UIWebView *webView = (UIWebView*)webView;
    //NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    
    
}

#pragma mark WKWebView Delegates

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"Did start loading.");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    NSRect contentRect = [[webView window] contentLayoutRect];
    NSData *pdfData = [[[webView window] contentView] dataWithPDFInsideRect: [[webView window] contentLayoutRect]];
    NSString *saveFilePath = @"/Users/rwelz/URL2PDF Output/out.pdf";
    [pdfData writeToFile:saveFilePath atomically:YES];
    
    
    
//    NSRect printRect = [printView frame];
//    
//    NSData *printData = [printView dataWithPDFInsideRect:printRect];
//    
//    NSString *saveFilePath = @"/Users/rwelz/URL2PDF Output/out.pdf";
//    [printData writeToFile:saveFilePath atomically:YES];
    
    exit(EXIT_SUCCESS);
}

@end
