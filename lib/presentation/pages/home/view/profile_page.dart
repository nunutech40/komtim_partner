import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';

import '../../../../common/enum_status.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_outline_button.dart';
import '../../../widgets/custom_tile.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24), // Add horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocListener<MainBloc, MainState>(
              listener: (context, state) {
                // Handle state changes here
                if (state.status == RequestStatus.success) {
                  AppRouter.router.go(PAGES.login.screenPath);
                } else if (state.status == RequestStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const ProfileRow(),
            ),
            const SizedBox(
              height: 32.0,
            ),
            CustomTile(
              title: 'Informasi',
              leadingIcon: Image.asset('assets/images/ic-profile-circle.png'),
              trailingIcon: Image.asset('assets/images/ic-arrow-right.png'),
              onTap: () {
                AppRouter.router.push(PAGES.profileInfo.screenPath);
              },
            ),
            CustomTile(
              title: 'Ubah Password',
              leadingIcon: Image.asset('assets/images/ic-security-safe.png'),
              trailingIcon: Image.asset('assets/images/ic-arrow-right.png'),
              onTap: () {},
            ),
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomOutlineButton(
                text: 'Logout',
                onPressed: () {
                  context
                      .read<MainBloc>()
                      .add(const LogoutButtonPressedEvent());
                },
                icon: Image.asset('assets/images/ic-logout.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(
          imageUrl:
              'https://via.placeholder.com/150', // replace with your image url
        ),
        SizedBox(width: 10),
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
      width: 60.0, // Set the desired width
      height: 60.0, // Set the desired height
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        const SizedBox(height: 5),
        Text(id, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
