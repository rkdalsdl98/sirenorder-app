import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';

class PaymentResult extends StatelessWidget {
  final Map<String, dynamic> result;
  final String type;
  const PaymentResult({
    super.key,
    required this.result,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1)).then((_) {
        String? orderUid = result['merchant_uid'];
        String? impUid = result['imp_uid'];
        bool payed = result['imp_success'] == "true";
        if (payed) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/",
            (_) => false,
            arguments: {
              "order_uid": orderUid,
              "imp_uid": impUid,
              "payed": payed,
              "type": type,
            },
          );
        } else {
          Navigator.pop(context);
          showSnackBarMessage(context, "결제를 취소하셨습니다.");
        }
      });
    });
    return const Scaffold(
      body: Center(child: LoadingIndicator()),
    );
  }
}
