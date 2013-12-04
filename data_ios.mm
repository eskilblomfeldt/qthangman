#include "data.h"

//Much of the following Objective-C code is borrowed from:
//http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
//The above blog as lots of excellent advice on finding you way around
//the crazy world of Apple In App Purchases

#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
#define kUnlockVowelsProductId @"com.digia.qt.iosteam.qthangman.unlockvowels"
#define kVowelAProductId @"com.digia.qt.iosteam.qthangman.vowelA"
#define kVowelEProductId @"com.digia.qt.iosteam.qthangman.vowelE"
#define kVowelIProductId @"com.digia.qt.iosteam.qthangman.vowelI"
#define kVowelOProductId @"com.digia.qt.iosteam.qthangman.vowelO"
#define kVowelUProductId @"com.digia.qt.iosteam.qthangman.vowelU"


//Use a Catagory to add a localizedPrice method to SKProduct
@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end

@implementation SKProduct (LocalizedPrice)

- (NSString *)localizedPrice
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.priceLocale];
    NSString *formattedString = [numberFormatter stringFromNumber:self.price];
    [numberFormatter release];
    return formattedString;
}

@end

//This is the Singleton object for manageing In App Purchases
@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProduct *unlockVowels;
    SKProduct *vowelA;
    SKProduct *vowelE;
    SKProduct *vowelI;
    SKProduct *vowelO;
    SKProduct *vowelU;
    SKProductsRequest *productsRequest;
}

-(BOOL)canMakePurchases;
-(void)purchaseSingleVowel:(char)vowel;
-(void)purchaseUnlockVowels;

@end

@implementation InAppPurchaseManager

+(id)sharedInstance
{
    static InAppPurchaseManager *iAPManager = nil;
    @synchronized(self) {
        if (iAPManager == nil)
            iAPManager = [[self alloc] init];
    }
    return iAPManager;
}

-(id)init {
    if (self = [super init]) {
        [self requestProductData];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

-(void)purchaseSingleVowel:(char)vowel
{
    SKProduct *vowelProduct = nil;
    switch (vowel) {
        case 'A':
            vowelProduct = vowelA;
            break;
        case 'E':
            vowelProduct = vowelE;
            break;
        case 'I':
            vowelProduct = vowelI;
            break;
        case 'O':
            vowelProduct = vowelO;
            break;
        case 'U':
            vowelProduct = vowelU;
            break;
        default:
            break;
    }
    
    if (vowelProduct != nil) {
        SKPayment *payment = [SKPayment paymentWithProduct:vowelProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

-(void)purchaseUnlockVowels
{
    SKPayment *payment = [SKPayment paymentWithProduct:unlockVowels];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)requestProductData
{
    NSSet *productIds = [NSSet setWithObjects:kUnlockVowelsProductId, kVowelAProductId, kVowelEProductId, kVowelIProductId, kVowelOProductId, kVowelUProductId, nil];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    productsRequest.delegate = self;
    [productsRequest start];
}

//From SKProductsRuestDelegate
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    for (SKProduct *product in products)
    {
        //NSLog(@"Product title: %@" , product.localizedTitle);
        //NSLog(@"Product description: %@" , product.localizedDescription);
        //NSLog(@"Product price: %@" , product.localizedPrice);
        //NSLog(@"Product id: %@" , product.productIdentifier);
        if ([product.productIdentifier isEqualToString:kUnlockVowelsProductId]) {
            unlockVowels = product;
            [unlockVowels retain];
        } else if ([product.productIdentifier isEqualToString:kVowelAProductId]) {
            vowelA = product;
            [vowelA retain];
        } else if ([product.productIdentifier isEqualToString:kVowelEProductId]) {
            vowelE = product;
            [vowelE retain];
        } else if ([product.productIdentifier isEqualToString:kVowelIProductId]) {
            vowelI = product;
            [vowelI retain];
        } else if ([product.productIdentifier isEqualToString:kVowelOProductId]) {
            vowelO = product;
            [vowelO retain];
        } else if ([product.productIdentifier isEqualToString:kVowelUProductId]) {
            vowelU = product;
            [vowelU retain];
        }
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    [request release];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

-(void)recordTransaction:(SKPaymentTransaction *)transaction
{
    //if the product is non-consumable then we need to record the transaction
    if ([transaction.payment.productIdentifier isEqualToString:kUnlockVowelsProductId]) {
        //TODO: Save transaction of the UnlockVowel product
    }
}

-(void)provideContent:(NSString *)productId
{
    char vowel = 0;
    
    if ([productId isEqualToString:kVowelAProductId]) {
        vowel = 'A';
    } else if ([productId isEqualToString:kVowelEProductId]) {
        vowel = 'E';
    } else if ([productId isEqualToString:kVowelIProductId]) {
        vowel = 'I';
    } else if ([productId isEqualToString:kVowelOProductId]) {
        vowel = 'O';
    } else if ([productId isEqualToString:kVowelUProductId]) {
        vowel = 'U';
    }
    
    if (vowel != 0)
        Data::instance()->vowelBought(QChar(vowel));
}

-(void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    //TODO: send notificaiton
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

@end

void Data::buyVowel(const QChar &vowel) {
    InAppPurchaseManager *iAPManager = [InAppPurchaseManager sharedInstance];
    if ([iAPManager canMakePurchases]) {
        //buy a vowel
        [iAPManager purchaseSingleVowel:vowel.toLatin1()];
    } else {
        NSLog(@"Not able to make purchases.");
    }
}
