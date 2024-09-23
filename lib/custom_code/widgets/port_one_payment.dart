// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';

class PortOnePayment extends StatefulWidget {
  const PortOnePayment({
    super.key,
    this.width,
    this.height,
    required this.pg,
    required this.amount,
    required this.productname,
    required this.buyerName,
    this.buyerEmail,
    required this.buyerAddress,
    required this.buyerPostcode,
    required this.buyerTel,
  });

  final double? width;
  final double? height;
  final String pg;
  final int amount;
  final String productname;
  final String buyerName;
  final String? buyerEmail;
  final String buyerAddress;
  final String buyerPostcode;
  final String buyerTel;

  @override
  State<PortOnePayment> createState() => _PortOnePaymentState();
}

class _PortOnePaymentState extends State<PortOnePayment> {
  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'iamport',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
          pg: 'html5_inicis', // PG사
          payMethod: 'card', // 결제수단
          name: widget.productname, // 주문명
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
          amount: widget.amount, // 결제금액
          buyerName: widget.buyerName, // 구매자 이름
          buyerTel: widget.buyerTel, // 구매자 연락처
          buyerEmail: widget.buyerEmail, // 구매자 이메일
          buyerAddr: widget.buyerAddress, // 구매자 주소
          buyerPostcode: widget.buyerPostcode, // 구매자 우편번호
          appScheme: 'saltwaterbetaver1', // 앱 URL scheme
          cardQuota: [2, 3] //결제창 UI 내 할부개월수 제한
          ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Navigator.pushReplacementNamed(
          context,
          '/result',
          arguments: result,
        );
      },
    );
  }
}
