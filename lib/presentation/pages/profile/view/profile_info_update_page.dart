import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/widgets/custom_text_field.dart';

import '../../../../common/styles.dart';
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
      body: const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 24), // Add horizontal padding
          child: Column(
            children: [
              SizedBox(
                height: 11,
              ),
              Center(
                child: ProfileRow(),
              ),
              SizedBox(
                height: 34.0,
              ),
              CustomTextField(
                label: 'No. Telepon',
                hint: '087****8',
                onChanged: null,
                onlyNumbers: true,
              )
            ],
          )),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(
          imageUrl:
              'https://via.placeholder.com/150', // replace with your image url
        ),
        SizedBox(height: 16.0),
        ProfileDetails(
          name: 'Nunu Nugraha',
          id: '123456',
        ),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatar({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0, // Set the desired width
      height: 100.0, // Set the desired height
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final String name;
  final String id;

  const ProfileDetails({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: AppTypography.semiBold16,
        ),
        const SizedBox(height: 5),
        Text(id, style: AppTypography.regular12),
      ],
    );
  }
}
