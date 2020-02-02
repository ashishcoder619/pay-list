import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_list/components/input.dart';
import 'package:pay_list/models/payment.dart';
import 'package:pay_list/models/paymentDB.dart';

class NewPayments extends StatefulWidget {
  @override
  _NewPaymentsState createState() => _NewPaymentsState();
}

class _NewPaymentsState extends State<NewPayments> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _valueController = new TextEditingController();

  void saveData() async {
    String title = this._titleController.text;
    String value = this._valueController.text;
    if (title == '' || value == '') return;

    Payment payment = new Payment(
      title: title,
      value: double.parse(value),
      date: DateTime.now().millisecondsSinceEpoch,
    );

    PaymentDB db = new PaymentDB();
    await db.create(payment);
    this._titleController.text = '';
    this._valueController.text = '';
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        title: Text(
          'New Payment',
          style: GoogleFonts.karla(
            fontSize: 21.0,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Input(
                  controller: this._titleController,
                  text: 'Title',
                  keyboard: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Input(
                  controller: this._valueController,
                  text: 'Value',
                  keyboard: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.save,
          size: 24.0,
          color: Colors.white,
        ),
        label: Text(
          'SAVE',
          style: GoogleFonts.karla(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        onPressed: this.saveData,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
