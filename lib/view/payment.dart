import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? storeCode, kakaopayCode;

  @override
  void initState() {
    super.initState();
    storeCode = dotenv.env["STORE_CODE"];
    kakaopayCode = dotenv.env["KAKAO_PAY_CODE"];
  }

  @override
  Widget build(BuildContext context) {
    return (storeCode == null) || (kakaopayCode == null)
        ? const Center(child: Text("오류"))
        : IamportPayment(
            userCode: storeCode!,
            initialChild: const Center(child: Text("로딩중...")),
            data: PaymentData(
              pg: 'kakaopay.$kakaopayCode', // PG사
              payMethod: 'card', // 결제수단
              name: '아메리카노', // 주문명
              merchantUid:
                  'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
              amount: 100, // 결제금액
              buyerName: '홍길동', // 구매자 이름
              buyerTel: '01012345678', // 구매자 연락처
              buyerEmail: 'example@gmail.com', // 구매자 이메일
              buyerAddr: '서울시 강남구 신사동 661-16', // 구매자 주소
              buyerPostcode: '06060', // 구매자 우편번호
              appScheme: 'example', // 앱 URL scheme
            ),
            callback: (Map<String, String> result) {
              Navigator.pushReplacementNamed(
                context,
                '/',
                arguments: result,
              );
            },
          );
  }
}
