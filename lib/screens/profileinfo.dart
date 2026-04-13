import 'package:flutter/material.dart';

class Profileinfo extends StatelessWidget {
  const Profileinfo({super.key});

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
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: isTablet ? 28 : 24,
          ),
          onPressed: () => Navigator.pop(context),
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
          child: Container(color: Color(0xff111111), height: 1.0),
        ),
      ),
      body: LayoutBuilder(
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
                    SizedBox(height: verticalSpacing * 1.2),
                    // Delete Photo Button
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: isTablet ? 24 : (isSmallScreen ? 16 : 20),
                      ),
                      label: Text(
                        'Delete photo',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: labelFontSize,
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacing * 1.5),
                    // Form Fields
                    _buildLabeledField(
                      label: 'First Name',
                      hint: 'Youssef',
                      labelFontSize: labelFontSize,
                      fieldFontSize: fieldFontSize,
                      fieldPadding: fieldPadding,
                      borderRadius: borderRadius,
                      verticalSpacing: verticalSpacing,
                    ),
                    _buildLabeledField(
                      label: 'Last Name',
                      hint: 'Mostafa',
                      labelFontSize: labelFontSize,
                      fieldFontSize: fieldFontSize,
                      fieldPadding: fieldPadding,
                      borderRadius: borderRadius,
                      verticalSpacing: verticalSpacing,
                    ),
                    _buildLabeledField(
                      label: 'Date of birth',
                      hint: '02/07/2004',
                      labelFontSize: labelFontSize,
                      fieldFontSize: fieldFontSize,
                      fieldPadding: fieldPadding,
                      borderRadius: borderRadius,
                      verticalSpacing: verticalSpacing,
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                        size: isTablet ? 24 : 20,
                      ),
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
                    // Save Button (optional - good for profile screens)
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
        Container(
          width: profileSize,
          height: profileSize,
          decoration: BoxDecoration(
            color: Colors.blue[600],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.person, size: iconSize, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: -editIconSize / 2,
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
      ],
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
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F6),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: fieldPadding),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '+2',
                        style: TextStyle(
                          fontSize: fieldFontSize,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                        size: isTablet ? 24 : 20,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: isTablet ? 28 : 24,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: fieldFontSize),
                    decoration: InputDecoration(
                      hintText: '000 000 0000',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: fieldFontSize,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: fieldPadding,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton({
    required double borderRadius,
    required double fieldPadding,
    required double fontSize,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: fieldPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
