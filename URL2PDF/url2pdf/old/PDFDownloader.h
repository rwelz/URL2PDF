//
//  PDFDownloader.h
//  URL2PDF
//
//  Created by Robert Welz on 19.03.17.
//
//

#import <Foundation/Foundation.h>
#import "WebKit/WebKit.h"

@interface PDFDownloader : NSObject <WKNavigationDelegate>
{
@private
    BOOL loadComplete;
    NSString *pageTitle;
}

@property (nonatomic,readwrite) BOOL loadComplete;
@property (nonatomic,readwrite, copy) NSString *pageTitle;

- (id)downloadURLs:(id)input parameters: (NSMutableDictionary *) parameters;

@end
