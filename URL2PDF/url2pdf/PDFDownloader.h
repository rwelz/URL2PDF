//
//  PDFDownloader.h
//  DownloadPDF
//
//  Created by Scott Garner on 5/23/12.
//  Modified by welz.willi@gmail.com (c) 1/27/17
//  Copyright (c) 2012 Project J38. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebKit/WebKit.h"

@interface PDFDownloader : NSObject <WebFrameLoadDelegate, WebResourceLoadDelegate> {
@private
    BOOL loadComplete;
    NSString *pageTitle;
}

@property (nonatomic,readwrite) BOOL loadComplete;
@property (nonatomic,readwrite, copy) NSString *pageTitle;

- (id)downloadURLs:(id)input parameters: (NSMutableDictionary *) parameters;

@end

