import 'package:in_app_review_kmp/in_app_review_code.dart';
import 'package:in_app_review_kmp/in_app_review_params.dart';

import 'in_app_review_platform_interface.dart';

class InAppReview {
  final InAppReviewPlatform _instance = InAppReviewPlatform.instance;

  Future<ReviewCode> launchInAppReview(InAppReviewParams params) => _instance
      .launchInAppReview(params: params)
      .then((value) => ReviewCodeExt.fromString(value));

  Future<ReviewCode> launchInMarketReview(InAppReviewParams params) => _instance
      .launchInMarketReview(params: params)
      .then((value) => ReviewCodeExt.fromString(value));
}
