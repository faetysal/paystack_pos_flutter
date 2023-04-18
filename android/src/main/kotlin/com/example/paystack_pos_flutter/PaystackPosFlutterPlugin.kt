package com.example.paystack_pos_flutter

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.google.gson.Gson; 
import com.google.gson.annotations.SerializedName

class PaystackPosFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  private lateinit var channel : MethodChannel

  val TXN_RESULT_CODE = 14
  var act: android.app.Activity? = null
  private lateinit var result: Result
  val gson = Gson()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "paystack_pos_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    this.result = result
    if (call.method == "initPayment") {
      makePayment(call.argument("amount")!!)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    act = binding.activity
    binding.addActivityResultListener(this)
  }
  override fun onDetachedFromActivityForConfigChanges() {
    act = null;
  }
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    act = binding.activity
    binding.addActivityResultListener(this)
  }
  override fun onDetachedFromActivity() {
    act = null;
  }
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (resultCode == TXN_RESULT_CODE) {
      if (data != null) {
        val intent = data
        val paystackIntentResponse: PaystackIntentResponse
        val terminalResponse: TerminalResponse

        paystackIntentResponse = gson.fromJson(
          intent?.getStringExtra("com.paystack.pos.TRANSACT"),
          PaystackIntentResponse::class.java
        )

        terminalResponse = paystackIntentResponse.intentResponse
        val transactionResponse: TransactionResponse = gson.fromJson(
          terminalResponse.data,
          TransactionResponse::class.java
        )

        result.success(terminalResponse.data)
        return true
      } else {
        result.error("502", "Payment Failed", null)
      }
    }

    return false
  }

  private fun makePayment(amount: Int) {
    val txnRequest = TransactionRequest(
      amount = amount,
      offlineReference = null,
      supplementaryReceiptData = null,
      metadata = null
    )

    val txnIntent = Intent(Intent.ACTION_VIEW).apply {
      setPackage("com.paystack.pos")
      putExtra("com.paystack.pos.TRANSACT", gson.toJson(txnRequest))
    }

    act?.startActivityForResult(txnIntent, TXN_RESULT_CODE)
  }
}

data class PaystackIntentResponse (
  val intentKey: String,
  val intentResponseCode: Int,
  val intentResponse: TerminalResponse
)

data class TerminalResponse(
  val statusCode: String,
  val message: String,
  val data: String
)

data class TransactionRequest(
  val amount: Int,
  val offlineReference: String?,
  val supplementaryReceiptData: SupplementaryReceiptData?,
  val metadata: Map<String, Any>?
)

data class TransactionResponse(
  val id: String?,
  val amount: Int?,
  val reference: String?,
  val status: String?,
  val currency: String?,
  @SerializedName("country_code")
  val countryCode: String?,
  @SerializedName("paid_at")
  val paidAt: String?,
  val terminal: String?
)

data class SupplementaryReceiptData(
  val developerSuppliedText: String?,
  val developerSuppliedImageUrlPath: String?,
  val barcodeOrQrcodeImageText: String?,
  val textImageType: TextImageFormat?
)

enum class TextImageFormat {
  QR_CODE, 
  AZTEC_BARCODE
}
