import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/services/profile/update_service.dart';
import 'package:grad_project/widgets/profile/PopUpDialog.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:grad_project/services/Authservice.dart';
import 'package:grad_project/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profileinfo extends StatefulWidget {
  const Profileinfo({super.key});

  @override
  State<Profileinfo> createState() => _ProfileinfoState();
}

class _ProfileinfoState extends State<Profileinfo> {
  File? _profileImage;
  bool isSaving = false;
  // Phone number variables
  final TextEditingController phoneController = TextEditingController();
  PhoneNumber initialNumber = PhoneNumber(isoCode: 'EG');
  String phoneNumber = '';
  bool isPhoneValid = false;
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await AuthService().getUserData();
    if (user != null) {
      firstNameController.text = user.firstname;
      lastNameController.text = user.lastname;
      addressController.text = user.address;
      if (user.date != null && user.date.isNotEmpty) {
        try {
          final parsedDate = DateFormat('yyyy-MM-dd').parse(user.date);
          selectedDate = parsedDate;
          dateController.text = DateFormat('dd/MM/yyyy').format(parsedDate);
        } catch (e) {
          print("Error parsing date: $e");
        }
      }
      if (user.phone.isNotEmpty) {
        try {
          initialNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
            user.phone,
            'EG',
          );
          phoneNumber = initialNumber.phoneNumber ?? '';
        } catch (e) {
          print("Error parsing phone number: $e");
        }
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth > 600;

    // Responsive values
    final horizontalPadding = screenWidth * 0.05;
    final profileSize = isTablet ? 140.0 : (isSmallScreen ? 80.0 : 100.0);
    final iconSize = isTablet ? 80.0 : (isSmallScreen ? 48.0 : 60.0);
    final editIconSize = isTablet ? 24.0 : (isSmallScreen ? 14.0 : 18.0);
    final titleFontSize = isTablet ? 22.0 : (isSmallScreen ? 16.0 : 18.0);
    final labelFontSize = isTablet ? 16.0 : (isSmallScreen ? 12.0 : 14.0);
    final fieldFontSize = isTablet ? 16.0 : (isSmallScreen ? 12.0 : 14.0);
    final verticalSpacing = screenHeight * 0.02;
    final fieldPadding = isTablet ? 20.0 : (isSmallScreen ? 12.0 : 16.0);
    final borderRadius = isTablet ? 16.0 : 12.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: isTablet ? 28 : 24,
          ),
          onPressed: () => showCustomDialog(context),
        ),
        title: Text(
          'Personal Info',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xff111111), height: 1.0),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalSpacing,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 500 : double.infinity,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: verticalSpacing),
                          // Profile Picture
                          _buildProfilePicture(
                            profileSize: profileSize,
                            iconSize: iconSize,
                            editIconSize: editIconSize,
                          ),
                          SizedBox(height: verticalSpacing * 0.8),
                          // Delete Photo Button
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _profileImage = null;
                              });
                            },
                            icon: Icon(Icons.delete_outline, color: Colors.red),
                            label: Text(
                              'Delete photo',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                          SizedBox(height: verticalSpacing * 0.8),
                          // Form Fields
                          _buildLabeledField(
                            label: 'First Name',
                            hint: 'Youssef',
                            controller: firstNameController,
                            labelFontSize: labelFontSize,
                            fieldFontSize: fieldFontSize,
                            fieldPadding: fieldPadding,
                            borderRadius: borderRadius,
                            verticalSpacing: verticalSpacing,
                          ),
                          _buildLabeledField(
                            label: 'Last Name',
                            hint: 'Mostafa',
                            controller: lastNameController,
                            labelFontSize: labelFontSize,
                            fieldFontSize: fieldFontSize,
                            fieldPadding: fieldPadding,
                            borderRadius: borderRadius,
                            verticalSpacing: verticalSpacing,
                          ),
                          _buildDateField(
                            labelFontSize: labelFontSize,
                            fieldFontSize: fieldFontSize,
                            fieldPadding: fieldPadding,
                            borderRadius: borderRadius,
                            verticalSpacing: verticalSpacing,
                          ),
                          _buildLabeledField(
                            label: 'Address',
                            hint: 'Atreeb, Abdelhaleem mosque street',
                            controller: addressController,
                            labelFontSize: labelFontSize,
                            fieldFontSize: fieldFontSize,
                            fieldPadding: fieldPadding,
                            borderRadius: borderRadius,
                            verticalSpacing: verticalSpacing,
                          ),

                          _buildPhoneField(
                            labelFontSize: labelFontSize,
                            fieldFontSize: fieldFontSize,
                            fieldPadding: fieldPadding,
                            borderRadius: borderRadius,
                            verticalSpacing: verticalSpacing,
                            isTablet: isTablet,
                          ),
                          SizedBox(height: verticalSpacing * 2),
                          // Save Button
                          _buildSaveButton(
                            borderRadius: borderRadius,
                            fieldPadding: fieldPadding,
                            fontSize: labelFontSize + 2,
                          ),
                          SizedBox(height: verticalSpacing),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProfilePicture({
    required double profileSize,
    required double iconSize,
    required double editIconSize,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: profileSize / 2,
          backgroundColor: Colors.grey[200],
          backgroundImage: _profileImage != null
              ? FileImage(_profileImage!)
              : null,
          child: _profileImage == null
              ? Icon(Icons.person, size: iconSize, color: Colors.white)
              : null,
        ),
        Positioned(
          bottom: -editIconSize / 2,
          child: GestureDetector(
            onTap: _pickImageFromGallery,
            child: Container(
              padding: EdgeInsets.all(editIconSize * 0.35),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(Icons.edit, size: editIconSize, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildLabeledDate({
    required String label,
    required String hint,
    required TextEditingController controller, // add this
    required double labelFontSize,
    required double fieldFontSize,
    required double fieldPadding,
    required double borderRadius,
    required double verticalSpacing,
    VoidCallback? onTap, // add this
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelFontSize,
              color: const Color(0xFF4B4B4B),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: verticalSpacing * 0.4),
          GestureDetector(
            onTap: onTap,
            child: TextField(
              controller: controller,
              readOnly: true, // prevents manual typing but keeps normal look
              style: TextStyle(fontSize: fieldFontSize),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: fieldFontSize,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: fieldPadding,
                  vertical: fieldPadding,
                ),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hint,
    required double labelFontSize,
    required double fieldFontSize,
    required double fieldPadding,
    required double borderRadius,
    required double verticalSpacing,
    Widget? suffixIcon,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty) ...[
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: const Color(0xFF4B4B4B),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: verticalSpacing * 0.4),
          ],
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F6),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: fieldFontSize),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: fieldFontSize,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: fieldPadding,
                  vertical: fieldPadding,
                ),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final results = await showCalendarDatePicker2Dialog(
      dialogBackgroundColor: Colors.white,
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
      ),
      dialogSize: const Size(325, 350),
      value: selectedDate != null ? [selectedDate!] : [],
    );

    if (results != null && results.isNotEmpty) {
      setState(() {
        selectedDate = results.first;
        dateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(selectedDate!); // sync controller
      });
    }
  }

  Widget _buildDateField({
    required double labelFontSize,
    required double fieldFontSize,
    required double fieldPadding,
    required double borderRadius,
    required double verticalSpacing,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: TextStyle(
              fontSize: labelFontSize,
              color: const Color(0xFF4B4B4B),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: verticalSpacing * 0.4),
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: fieldPadding,
                vertical: fieldPadding,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F6),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                          : '02/07/2004',
                      style: TextStyle(
                        fontSize: fieldFontSize,
                        color: selectedDate != null
                            ? Colors.black87
                            : Colors.grey,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField({
    required double labelFontSize,
    required double fieldFontSize,
    required double fieldPadding,
    required double borderRadius,
    required double verticalSpacing,
    required bool isTablet,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone number',
            style: TextStyle(
              fontSize: labelFontSize,
              color: const Color(0xFF4B4B4B),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: verticalSpacing * 0.4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: fieldPadding),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F6),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: InternationalPhoneNumberInput(
              cursorColor: Colors.blue,
              onInputChanged: (PhoneNumber number) {
                setState(() {
                  phoneNumber = number.phoneNumber ?? '';
                });
                print('Phone Number: ${number.phoneNumber}');
              },
              onInputValidated: (bool isValid) {
                setState(() {
                  isPhoneValid = isValid;
                });
                print('Is Valid: $isValid');
              },
              selectorConfig: const SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
                leadingPadding: 0,
                trailingSpace: false,
                showFlags: false,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.always,
              selectorTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: fieldFontSize,
              ),
              textStyle: TextStyle(
                fontSize: fieldFontSize,
                color: Colors.black87,
              ),
              initialValue: initialNumber,
              textFieldController: phoneController,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputDecoration: InputDecoration(
                hintText: '000 000 0000',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: fieldFontSize,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: fieldPadding),
              ),
              searchBoxDecoration: InputDecoration(
                hintText: 'Search by country name or code',
                hintStyle: TextStyle(fontSize: fieldFontSize),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    setState(() => isSaving = true);

    try {
      final success = await updateMe(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phone: phoneNumber,
        address: addressController.text.trim(),
        dateOfBirth: selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            : null,
        imageFile: _profileImage,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Widget _buildSaveButton({
    required double borderRadius,
    required double fieldPadding,
    required double fontSize,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSaving ? null : _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: fieldPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: isSaving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
