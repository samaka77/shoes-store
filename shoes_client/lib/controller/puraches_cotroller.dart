import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart' as getx;
import 'package:shoes_client/pages/home_page.dart';

class PurchesController extends getx.GetxController {
  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  final String _publishableKey =
      "pk_test_51R56zi2NR5UwNcLFHh0EttWdRkVovEifh0OEQRSl0ajRrqfupO8IQL2J2JWofkJ22XogQFmIAJukAznDN7TJVbWq00l6eAtvYn";
  final String _secret =
      "sk_test_51R56zi2NR5UwNcLF3TQosnmQuvKeGCTD3gnROdokNfYdeC47SmNN7pGnOwGXv9e6jrVziNDnGh4fxybz9NY6yYie005GWOJDC6";
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    Stripe.publishableKey = _publishableKey;
    Stripe.instance.applySettings();
  }

  void submitOrder({
    required double price,
    required String item,
    required String description,
  }) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
    int amount,
    String currency,
  ) async {
    try {
      print("🔵 Creating Payment Intent with amount: $amount $currency");

      Response response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": amount, // ✅ يجب أن يكون عدد صحيح وليس نص
          "currency": currency,
          "payment_method_types[]": "card", // ✅ تصحيح المشكلة
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $_secret",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      print("✅ Payment Intent Created: ${response.data}");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        print("❌ Dio Error: ${e.response?.data}");
      }
      print("❌ Error creating payment intent: $e");
      return {};
    }
  }

  Future<void> makePayment() async {
    try {
      if (orderPrice == 0 || itemName.isEmpty || orderAddress.isEmpty) {
        getx.Get.snackbar("خطأ", "يرجى إدخال بيانات الطلب أولاً");
        return;
      }

      int amountInCents = (orderPrice * 100).toInt();
      if (amountInCents < 50) {
        getx.Get.snackbar("خطأ", "المبلغ لا يمكن أن يكون أقل من 0.50 دولار");
        return;
      }

      final paymentIntent = await _createPaymentIntent(
        amountInCents, // ✅ تحويل المبلغ إلى سنتات والتأكد من صحته
        "usd",
      );

      if (paymentIntent.isEmpty) {
        getx.Get.snackbar("خطأ", "تعذر إنشاء طلب الدفع");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent["client_secret"],
          merchantDisplayName: "Shoes Store",
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      showOrderSuccessDialog();

      getx.Get.snackbar(
        "نجاح",
        "تمت عملية الدفع بنجاح 🎉",
        colorText: Colors.green,
      );
    } catch (e) {
      if (e is StripeException) {
        print("❌ Stripe Error: ${e.error.localizedMessage}");
        getx.Get.snackbar(
          "خطأ",
          "فشلت عملية الدفع: ${e.error.localizedMessage}",
        );
      } else {
        print("❌ General Error: $e");
        getx.Get.snackbar("خطأ", "فشلت عملية الدفع: $e");
      }
    }
  }

  void showOrderSuccessDialog() {
    getx.Get.defaultDialog(
      title: "تم الشراء بنجاح",
      middleText: "تمت عملية الشراء بنجاح، سيتم توصيل الطلب إلى العنوان المدخل",
      confirm: ElevatedButton(
        onPressed: () {
          getx.Get.offAll(const HomePage());
        },
        child: const Text("حسنًا"),
      ),
    );
  }
}
