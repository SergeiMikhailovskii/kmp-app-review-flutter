import 'package:in_app_review_kmp/in_app_review_params.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'in_app_review_method_channel.dart';

abstract class InAppReviewPlatform extends PlatformInterface {
  InAppReviewPlatform() : super(token: _token);

  static final Object _token = Object();

  static InAppReviewPlatform _instance = MethodChannelInAppReview();

  static InAppReviewPlatform get instance => _instance;

  static set instance(InAppReviewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> launchInAppReview({required InAppReviewParams params});

  Future<String?> launchInMarketReview({required InAppReviewParams params});
}
