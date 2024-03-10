import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review_kmp/in_app_review_params.dart';

import 'in_app_review_platform_interface.dart';

class MethodChannelInAppReview extends InAppReviewPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('in_app_review');

  @override
  Future<String?> launchInAppReview({required InAppReviewParams params}) async {
    final status = await methodChannel.invokeMethod<String>(
      'launchInAppReview',
      params.toMap(),
    );
    return status;
  }

  @override
  Future<String?> launchInMarketReview({
    required InAppReviewParams params,
  }) async {
    final status = await methodChannel.invokeMethod<String>(
      'launchInMarketReview',
      params.toMap(),
    );
    return status;
  }
}
