import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_outline_button_1.dart';

class ConfirmationDialog extends StatelessWidget {
  final void Function()? onYesPressed;
  final void Function()? onNoPressed;

  const ConfirmationDialog({
    Key? key,
    this.onYesPressed,
    this.onNoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Dialog corner radius
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the color here
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/images/ic-alert.png', // Replace with your image url
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Anda yakin ingin keluar dari akun anda?', // Replace with your text
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: CustomOutlineButton1(
                        text: 'Tidak',
                        onPressed:
                            onNoPressed ?? () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: CustomButton(
                        text: 'Iya',
                        onPressed:
                            onYesPressed ?? () => Navigator.of(context).pop(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context,
      {void Function()? onYesPressed, void Function()? onNoPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onYesPressed: onYesPressed,
          onNoPressed: onNoPressed,
        );
      },
    );
  }
}
