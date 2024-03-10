package com.mikhailovskii.in_app_review

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.lifecycleScope
import com.mikhailovskii.inappreview.appGallery.AppGalleryInAppReviewInitParams
import com.mikhailovskii.inappreview.appGallery.AppGalleryInAppReviewManager
import com.mikhailovskii.inappreview.googlePlay.GooglePlayInAppReviewInitParams
import com.mikhailovskii.inappreview.googlePlay.GooglePlayInAppReviewManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.launch

class InAppReviewPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var activity: FlutterFragmentActivity? = null

    private val googlePlayInAppReviewManager by lazy {
        GooglePlayInAppReviewManager(GooglePlayInAppReviewInitParams(requireNotNull(activity)))
    }

    private val appGalleryInAppReviewManager by lazy {
        AppGalleryInAppReviewManager(AppGalleryInAppReviewInitParams(requireNotNull(activity)))
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "in_app_review")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "launchInAppReview" -> launchInAppReview(call, result)
            "launchInMarketReview" -> launchInMarketReview(call, result)

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterFragmentActivity
        (binding.lifecycle as HiddenLifecycleReference)
            .lifecycle
            .addObserver(LifecycleEventObserver { _, event ->
                if (event == Lifecycle.Event.ON_CREATE) {
                    appGalleryInAppReviewManager.init()
                }
            })
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity as FlutterFragmentActivity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun launchInAppReview(call: MethodCall, result: Result) {
        val params = call.argument<Map<String, String>>("android").orEmpty()
        val market = params["market"]
        if (market == "googlePlay") {
            launchGooglePlayInAppReview(result)
        } else if (market == "appGallery") {
            launchAppGalleryInAppReview(result)
        }
    }

    private fun launchInMarketReview(call: MethodCall, result: Result) {
        val params = call.argument<Map<String, String>>("android").orEmpty()
        val market = params["market"]
        if (market == "googlePlay") {
            launchGooglePlayInMarketReview(result)
        } else if (market == "appGallery") {
            launchAppGalleryInMarketReview(result)
        }
    }

    private fun launchGooglePlayInAppReview(result: Result) {
        val activity = requireNotNull(activity)
        activity.lifecycleScope.launch {
            googlePlayInAppReviewManager.requestInAppReview().collect {
                result.success(it.name)
            }
        }
    }

    private fun launchAppGalleryInAppReview(result: Result) {
        val activity = requireNotNull(activity)
        activity.lifecycleScope.launch {
            appGalleryInAppReviewManager.requestInAppReview()
                .collect {
                    result.success(it.name)
                }
        }
    }

    private fun launchGooglePlayInMarketReview(result: Result) {
        val activity = requireNotNull(activity)
        activity.lifecycleScope.launch {
            googlePlayInAppReviewManager.requestInMarketReview().collect {
                result.success(it.name)
            }
        }
    }

    private fun launchAppGalleryInMarketReview(result: Result) {
        val activity = requireNotNull(activity)
        activity.lifecycleScope.launch {
            appGalleryInAppReviewManager.requestInMarketReview()
                .collect {
                    result.success(it.name)
                }
        }
    }
}
