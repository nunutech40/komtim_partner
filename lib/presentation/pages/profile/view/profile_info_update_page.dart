import 'package:flutter/material.dart';
import 'package:komtim_partner/presentation/widgets/custom_button.dart';
import 'package:komtim_partner/presentation/widgets/custom_text_field.dart';

import 'dart:math';
import '../../../../common/styles.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import '../../../widgets/custom_desc_field.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 11),
              const Center(
                child: ProfileRow(
                  name: 'Nunu Nugraha',
                ),
              ),
              const SizedBox(height: 34.0),
              const CustomTextField(
                label: 'No. Telepon',
                hint: '087****8',
                onChanged: null,
                onlyNumbers: true,
              ),
              const SizedBox(height: 24.0),
              const CustomTextField(
                label: 'Username',
                hint: 'kikoviano',
                onChanged: null,
              ),
              const SizedBox(height: 24.0),
              const CustomTextField(
                label: 'Email',
                hint: 'gerardus@gmail.com',
                onChanged: null,
              ),
              const SizedBox(height: 24.0),
              const CustomDescriptionField(
                label: 'Alamat',
                hint: 'Jln, Somba No. 5 Salatiga, Jawa Tengah',
                onChanged: null,
              ),
              const SizedBox(height: 24.0),
              const CustomTextField(
                label: 'Tanggal Bergabung',
                hint: '01 Januari 2020',
                onChanged: null,
              ),
              const SizedBox(height: 24.0),
              const CustomTextField(
                label: 'Nama Bank',
                hint: 'BRI',
                onChanged: null,
              ),
              const SizedBox(height: 24.0),
              const CustomTextField(
                label: 'Nomor Rekening',
                hint: '2138393936753',
                onChanged: null,
                onlyNumbers: true,
              ),
              const SizedBox(height: 32.0),
              _SubmitButton(),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String name;

  const ProfileRow({Key? key, required this.name}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://placehold.jp/${getRandomColor().value.toRadixString(16)}/ffffff/150x150.png?text=${getInitials(name)}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ProfileAvatar(
          imageUrl: imageUrl,
        ),
        SizedBox(height: 16.0),
        ProfileDetails(
          name: name,
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
