import 'package:flutter/material.dart';

import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';

class ProfileInfoUpdatePage extends StatefulWidget {
  const ProfileInfoUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileInfoUpdatePageState createState() => _ProfileInfoUpdatePageState();
}

class _ProfileInfoUpdatePageState extends State<ProfileInfoUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Profile'),
        leading: IconButton(
          icon: Image.asset('assets/images/ic-arrow-left.png'),
          onPressed: () {
            AppRouter.router.pop();
          },
        ),
      ),
    );
  }
}
