import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:sirenorder_app/model/order_model.dart';

class Payment extends StatefulWidget {
  final Map<String, dynamic> order;
  final String type;

  const Payment({
    super.key,
    required this.order,
    required this.type,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? storeCode, kakaopayCode;
  late OrderModel order;

  @override
  void initState() {
    super.initState();
    storeCode = dotenv.env["STORE_CODE"];
    kakaopayCode = dotenv.env["KAKAO_PAY_CODE"];

    order = OrderModel.fromJson(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    String orderId = 'mid_${DateTime.now().millisecondsSinceEpoch}';
    return order.amount <= 0
        ? const Center(child: Text("잘못된 접근입니다."))
        : ((storeCode == null) || (kakaopayCode == null)
            ? const Center(child: Text("오류"))
            : IamportPayment(
                userCode: storeCode!,
                initialChild: const Center(child: Text("로딩중...")),
                data: PaymentData(
                  pg: 'kakaopay.$kakaopayCode', // PG사
                  payMethod: 'card', // 결제수단
                  name: order.menuname, // 주문명
                  merchantUid: orderId, // 주문번호
                  amount: order.amount, // 결제금액
                  customData: order.customData == null
                      ? null
                      : {
                          "type": order.customData!.type,
                          "data": jsonEncode(order.customData!.data),
                        },
                  buyerName: order.buyerName, // 구매자 이름
                  buyerTel: order.buyerTel, // 구매자 연락처
                  buyerEmail: order.buyerEmail, // 구매자 이메일
                  buyerAddr: "매장수령", // 구매자 주소
                  buyerPostcode: "00000", // 구매자 우편번호
                  appScheme: 'example', // 앱 URL scheme
                ),
                callback: (Map<String, String> result) {
                  Navigator.pushReplacementNamed(
                    context,
                    "/payment-result",
                    arguments: {
                      "result": result,
                      "type": widget.type,
                    },
                  );
                },
              ));
  }
}
