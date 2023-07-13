import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';

import '../../../../common/enum_status.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/confirmation_dialog.dart';
import '../../../widgets/custom_outline_button.dart';
import '../../../widgets/custom_tile.dart';

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24), // Add horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<MainBloc, MainState>(
              listener: (context, state) {
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
              builder: (context, state) {
                return ProfileRow(
                    imageUrlNetwork: state.profileData?.photoProfileUrl,
                    name: state.profileData?.fullname ?? 'Nunu Nugraha',
                    id: state.profileData?.id.toString() ?? '0');
              },
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
              onTap: () {
                AppRouter.router.push(PAGES.changePassword.screenPath);
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomOutlineButton(
                text: 'Logout',
                onPressed: () {
                  final mainBloc = context.read<MainBloc>();
                  showLogoutConfirmation(context, mainBloc);
                },
                icon: Image.asset('assets/images/ic-logout.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLogoutConfirmation(BuildContext context, MainBloc mainBloc) {
    ConfirmationDialog.show(
      context,
      onYesPressed: () {
        mainBloc.add(const LogoutButtonPressedEvent());
        Navigator.of(context).pop();
      },
      onNoPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String name;
  final String id;
  final String? imageUrlNetwork;

  ProfileRow(
      {Key? key,
      required this.name,
      required this.id,
      required this.imageUrlNetwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(
          backgroundImage: imageUrlNetwork ??
              'https://placehold.jp/34A853/ffffff/150x150.png?text=${getInitials(name)}',
        ),
        const SizedBox(width: 10),
        ProfileDetails(
          name: name,
          id: id,
        ),
      ],
    );
  }

  String getInitials(String name) {
    final names = name.split(" ");
    if (names.length > 1) {
      final firstName = names[0];
      final lastName = names[names.length - 1];
      return "${firstName[0]}${lastName[0]}";
    } else {
      return name[0];
    }
  }

  Color getRandomColor() {
    final random = Random();
    final colorCode = random.nextInt(0xFFFFFF);
    return Color(colorCode).withOpacity(1.0);
  }
}

class ProfileAvatar extends StatelessWidget {
  final String backgroundImage;

  const ProfileAvatar({Key? key, required this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0, // Set the desired width
      height: 60.0, // Set the desired height
      child: CircleAvatar(
        backgroundImage: NetworkImage(backgroundImage),
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
        Text(id, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
