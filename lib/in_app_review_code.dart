enum ReviewCode {
  noError,
  storeNotFound,
  invalidRequest,
  internalError,
  appNotReleased,
  ratingSubmitted,
  commentSubmitted,
  signInStatusInvalid,
  conditionsNotMet,
  commentingDisabled,
  commentingNotSupported,
  cancel
}

class ReviewCodeExt {
  static ReviewCode fromString(String? str) {
    if (str == "NO_ERROR") {
      return ReviewCode.noError;
    } else if (str == "STORE_NOT_FOUND") {
      return ReviewCode.storeNotFound;
    } else if (str == "INVALID_REQUEST") {
      return ReviewCode.invalidRequest;
    } else if (str == "INTERNAL_ERROR") {
      return ReviewCode.internalError;
    } else if (str == "APP_NOT_RELEASED") {
      return ReviewCode.appNotReleased;
    } else if (str == "RATING_SUBMITTED") {
      return ReviewCode.ratingSubmitted;
    } else if (str == "COMMENT_SUBMITTED") {
      return ReviewCode.commentSubmitted;
    } else if (str == "SIGN_IN_STATUS_INVALID") {
      return ReviewCode.signInStatusInvalid;
    } else if (str == "CONDITIONS_NOT_MET") {
      return ReviewCode.conditionsNotMet;
    } else if (str == "COMMENTING_DISABLED") {
      return ReviewCode.commentingDisabled;
    } else if (str == "COMMENTING_NOT_SUPPORTED") {
      return ReviewCode.commentingNotSupported;
    } else if (str == "CANCEL") {
      return ReviewCode.cancel;
    } else {
      throw UnsupportedError("unsupported type = $str");
    }
  }
}
