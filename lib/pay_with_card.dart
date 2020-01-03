import 'package:flutter/material.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
// import 'package:paystack_sdk/paystack_sdk.dart';

class PayWithCard extends StatelessWidget {
  PayWithCard(this.data);
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Image.asset('assets/images/blank-card.jpg',
                  // scale: 0.8,
                  height: 200,
                  width: 400,
                  // fit:BoxFit.fill
                  )
              ],
            ),
            RaisedButton(
              child: Text('Pay by Card'),
              textColor: Color(0xff17317f),
              color: Colors.yellow,
              onPressed: () {
                _pay();
              },
            )
          ],
        ),
      )
    );
  }
}

void _pay() {
  InAppPayments.setSquareApplicationId('sandbox-sq0idb-wfPyi4q17IXkBli8tHzYsQ');
  InAppPayments.startCardEntryFlow(
    onCardNonceRequestSuccess: _cardNonceRequestSuccess,
    onCardEntryCancel: _cardEntryCancel,
  );
}

void _cardEntryCancel() {
// cancelled
}

void _cardNonceRequestSuccess(CardDetails result) {
  print(result.nonce);

  InAppPayments.completeCardEntry(
    onCardEntryComplete: _cardEntryComplete,
  );
}

void _cardEntryComplete() {
  // success
  print('success...........................');
}