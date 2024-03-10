class InAppReviewParams {
  final AndroidParams androidParams;
  final IOSParams iosParams;

  InAppReviewParams({required this.androidParams, required this.iosParams});

  Map<String, dynamic> toMap() => {
        "android": androidParams.toMap(),
        "ios": iosParams.toMap(),
      };
}

enum AndroidMarket { appGallery, googlePlay }

class AndroidParams {
  final AndroidMarket market;

  AndroidParams({required this.market});

  Map<String, dynamic> toMap() => {"market": market.name};
}

class IOSParams {
  final String appStoreId;

  IOSParams({required this.appStoreId});

  Map<String, dynamic> toMap() => {"appStoreId": appStoreId};
}
