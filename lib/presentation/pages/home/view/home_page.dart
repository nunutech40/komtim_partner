import 'package:flutter/material.dart';
import 'package:komtim_partner/common/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 182.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Maulana Bagus Satrio",
                              style: AppTypography.regular12
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'Leader / Talent',
                              style: AppTypography.semiBold16
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Image.asset(
                            'assets/images/ic-notif.png'), // replace with your asset path
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
