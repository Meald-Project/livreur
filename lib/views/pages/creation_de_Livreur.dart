import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/cin_info_create.dart';
import '../widgets/custom_button_create.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/full_name_field.dart';
import '../widgets/birth_date_field.dart';
import '../widgets/cin_front_image_picker.dart';
import '../widgets/cin_back_image_picker.dart';
import '../widgets/header.dart';
import '../widgets/region_dropdown_create.dart';

class CreationDeLivreur extends StatefulWidget {
  const CreationDeLivreur({super.key});

  @override
  _CreationDeLivreurState createState() => _CreationDeLivreurState();
}

class _CreationDeLivreurState extends State<CreationDeLivreur> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;
  XFile? _cinFrontImage;
  XFile? _cinBackImage;

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        switch (type) {
          case 'profile':
            _profileImage = image;
            break;
          case 'cinFront':
            _cinFrontImage = image;
            break;
          case 'cinBack':
            _cinBackImage = image;
            break;
        }
        print('Picked image: ${image.path}');
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(isSmallScreen: isSmallScreen),
              ProfileImagePicker(
                isSmallScreen: isSmallScreen,
                onTap: () => _pickImage('profile'),
                imagePath: _profileImage?.path,
              ),
              FullNameField(isSmallScreen: isSmallScreen),
              CinInfoRow(isSmallScreen: isSmallScreen),
              BirthDateField(isSmallScreen: isSmallScreen),
              RegionDropdown(isSmallScreen: isSmallScreen),
              CinFrontImagePicker(
                isSmallScreen: isSmallScreen,
                onTap: () => _pickImage('cinFront'),
                imagePath: _cinFrontImage?.path,
              ),
              CinBackImagePicker(
                isSmallScreen: isSmallScreen,
                onTap: () => _pickImage('cinBack'),
                imagePath: _cinBackImage?.path,
              ),
              const SizedBox(height: 40),
              CustomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
