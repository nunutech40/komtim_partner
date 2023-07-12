import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/widgets/custom_button.dart';
import 'package:komtim_partner/presentation/widgets/custom_text_field.dart';

import 'dart:math';
import '../../../../common/enum_status.dart';
import '../../../../common/styles.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_desc_field.dart';
import '../bloc/profile_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoUpdatePage extends StatefulWidget {
  const ProfileInfoUpdatePage({Key? key}) : super(key: key);

  @override
  _ProfileInfoUpdatePageState createState() => _ProfileInfoUpdatePageState();
}

class _ProfileInfoUpdatePageState extends State<ProfileInfoUpdatePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfilePageDidload());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failed to load profile')),
            );
        }
      },
      builder: (context, state) {
        if (state.status == RequestStatus.success) {
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 11),
                    Center(
                      child: ProfileRow(
                        name: state.profileData?.fullname ?? 'Loading...',
                        id: state.profileData?.id.toString() ?? 'Loading...',
                      ),
                    ),
                    const SizedBox(height: 34.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'No. Telepon',
                      hint: '087****8',
                      onChanged: null,
                      onlyNumbers: true,
                      textValue: state.profileData?.noTelp ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'Username',
                      hint: 'kikoviano',
                      onChanged: null,
                      textValue: state.profileData?.username ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'Email',
                      hint: 'gerardus@gmail.com',
                      onChanged: null,
                      textValue: state.profileData?.email ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomDescriptionField(
                      isEnable: false,
                      label: 'Alamat',
                      hint: 'Jln, Somba No. 5 Salatiga, Jawa Tengah',
                      onChanged: null,
                      textValue: state.profileData?.address ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'Tanggal Bergabung',
                      hint: '01 Januari 2020',
                      onChanged: null,
                      textValue: state.profileData?.joinDate ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'Nama Bank',
                      hint: 'BRI',
                      onChanged: null,
                      textValue: state.profileData?.bankName ?? '',
                    ),
                    const SizedBox(height: 24.0),
                    CustomTextField(
                      isEnable: false,
                      label: 'Nomor Rekening',
                      hint: '2138393936753',
                      onChanged: null,
                      onlyNumbers: true,
                      textValue: state.profileData?.bankAccountNumber ?? '',
                    ),
                    const SizedBox(height: 32.0)
                  ],
                ),
              ),
            ),
          );
        } else {
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
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String name;
  final String id;

  const ProfileRow({Key? key, required this.name, required this.id})
      : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://placehold.jp/34A853/ffffff/150x150.png?text=${getInitials(name)}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(
          imageUrl: imageUrl,
        ),
        const SizedBox(height: 16.0),
        ProfileDetails(
          name: name,
          id: id,
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Simpan',
        onPressed: () {},
      ),
    );
  }
}
