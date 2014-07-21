//
//  QPhotoViewController.m
//  QuickDialog
//
//  Created by Francis Visoiu Mistrih on 18/07/2014.
//
//

#import "QPhotoViewController.h"

#import "MEPhotoDataItem.h"

@interface QPhotoViewController ()

@end

@implementation QPhotoViewController

+ (QRootElement *)buildWithImage:(UIImage *)image metadata:(NSDictionary *)metadata photoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type {
    QRootElement *root = [[QRootElement alloc] init];
    root.presentationMode = QPresentationModeModalFullScreen;
    root.controllerName = @"QPhotoViewController";
    root.grouped = YES;

    QSection *photoSection = [[QSection alloc] initWithTitle:@"Photo"];
    QPhotoElement *photo = [[QPhotoElement alloc] initWithImage:image];
    photo.height = 300;
    [photo setEnabled:type != PhotoSourceWeb]; //disable selection if the photo comes from web
    [photoSection addElement:photo];
    [root addSection:photoSection];

    QDynamicDataSection *dataSection = [[QDynamicDataSection alloc] initWithTitle:@"Informations"];
    [dataSection setKey:@"dataSection"];
    dataSection.bind = @"iterate:el";
    dataSection.elementTemplate = @{@"type":@"QLabelElement", @"bind":@"title:name, value:value"};
    NSMutableArray *data = [@[@{@"name":@"Date",@"value":[metadata[@"{TIFF}"][@"DateTime"] stringByReplacingOccurrencesOfString:@"+0000" withString:@""]},
                            @{@"name":@"Model",@"value":metadata[@"{TIFF}"][@"Model"]},
                            @{@"name":@"Version",@"value":metadata[@"{TIFF}"][@"Software"]},
                            ] mutableCopy];

    if (photoData.code)
        [data addObject:@{@"name":@"Code", @"value":photoData.code}];

    if (photoData.code)
        [data addObject:@{@"name":@"Marque", @"value":photoData.productBrand}];

    if (photoData.code)
        [data addObject:@{@"name":@"Produit", @"value":photoData.productName}];


    [dataSection bindToObject:@{@"el":data}];
    [root addSection:dataSection];

    return root;
}

- (QPhotoViewController *)initWithPhoto:(UIImage *)image metadata:(NSDictionary *)metadata photoData:(MEPhotoDataItem *)photoData type:(PhotoSource)type {
    QRootElement *root = [QPhotoViewController buildWithImage:image metadata:metadata photoData:photoData type:type];
    self = [super initWithRoot:root];
    if (self) {
        //do something
    }

    return self;
}

@end
