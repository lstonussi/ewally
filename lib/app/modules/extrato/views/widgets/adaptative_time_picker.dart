import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final String text;
  final Function(DateTime) onDateChange;
  AdaptativeDatePicker({this.selectedDate, this.text, this.onDateChange});

  _showDatePicker(BuildContext context) {
    showDatePicker(
            //Context recebido por herança
            context: context,
            initialDate: DateTime.now(),
            //Data mais antiga que o usuario pode selecionar
            firstDate: DateTime(2019),
            //Data atual é a data limite, não pode selecionar data no futuro
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      //Comunicação indireta
      onDateChange(value);
    });
    //locale: const Locale('pt', 'BR'));
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _showDatePicker(context),
                )
              ],
            ),
          );
  }
}
