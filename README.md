# in_app_review_kmp

## What is it?
The Flutter plugin that uses [kmp-in-app-review](https://github.com/SergeiMikhailovskii/kmp-app-review) library
under the hood

## Which platforms are supported?
Android and iOS

## How to integrate?
1) Add the dependency to the pubspec.yaml:
```yaml
in_app_review_kmp: latest-version
```
2) Invoke flutter pub get
3) To launch in-app review call
   ```dart
   InAppReview().launchInAppReview(InAppReviewParams params)
   ```
4) To launch in-market review call
   ```dart
   InAppReview().launchInMarketReview(InAppReviewParams params)
   ```

### Note 1
InAppReviewParams is a class that encapsulates the data needed for the library to work with Android and iOS 
markets. Here's the description of these params:

```dart
class InAppReviewParams {
  final AndroidParams androidParams; // params for android markets
  final IOSParams iosParams; // params for ios markets
}

class AndroidParams {
   final AndroidMarket market; // currently supported markets - AndroidMarket.appGallery and AppGallery.googlePlay
}

class IOSParams {
   final String appStoreId; // id of the app in appstore
}
```