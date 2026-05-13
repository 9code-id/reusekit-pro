import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaBusinessProfileView extends StatefulWidget {
  const RmaBusinessProfileView({super.key});

  @override
  State<RmaBusinessProfileView> createState() => _RmaBusinessProfileViewState();
}

class _RmaBusinessProfileViewState extends State<RmaBusinessProfileView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  // Business Information
  String businessName = "The Golden Spoon";
  String ownerName = "John Anderson";
  String businessType = "fine_dining";
  String taxId = "12-3456789";
  String licenseNumber = "FL-REST-2024-001";
  String description = "Fine dining restaurant specializing in contemporary American cuisine with locally sourced ingredients.";

  // Contact & Location
  String address = "123 Main Street";
  String city = "Miami";
  String state = "Florida";
  String zipCode = "33101";
  String phone = "(305) 555-0123";
  String email = "info@goldenspoon.com";
  String website = "www.goldenspoon.com";

  // Financial Information
  String bankName = "First National Bank";
  String accountNumber = "****1234";
  String routingNumber = "021000021";
  double averageMonthlyRevenue = 85000.0;
  int employeeCount = 25;

  // Social Media
  String facebookUrl = "facebook.com/goldenspoon";
  String instagramUrl = "instagram.com/goldenspoon";
  String twitterUrl = "twitter.com/goldenspoon";

  // Images
  String logoImage = "";
  String coverImage = "";
  List<String> galleryImages = [];

  final List<Map<String, dynamic>> businessTypes = [
    {"label": "Fine Dining", "value": "fine_dining"},
    {"label": "Casual Dining", "value": "casual_dining"},
    {"label": "Fast Food", "value": "fast_food"},
    {"label": "Fast Casual", "value": "fast_casual"},
    {"label": "Coffee Shop", "value": "coffee_shop"},
    {"label": "Bar & Grill", "value": "bar_grill"},
    {"label": "Bakery", "value": "bakery"},
    {"label": "Food Truck", "value": "food_truck"},
  ];

  Future<void> _saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate saving profile
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    loading = false;
    setState(() {});
    
    ss("Business profile updated successfully!");
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Business Name",
            value: businessName,
            hint: "Enter business name",
            validator: Validator.required,
            onChanged: (value) {
              businessName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Owner Name",
            value: ownerName,
            hint: "Enter owner's full name",
            validator: Validator.required,
            onChanged: (value) {
              ownerName = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Business Type",
            items: businessTypes,
            value: businessType,
            onChanged: (value, label) {
              businessType = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Business Description",
            value: description,
            hint: "Describe your business, cuisine, and what makes it special",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegalInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Legal & Licensing",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Tax ID / EIN",
            value: taxId,
            hint: "Enter federal tax identification number",
            validator: Validator.required,
            onChanged: (value) {
              taxId = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Business License Number",
            value: licenseNumber,
            hint: "Enter business license number",
            validator: Validator.required,
            onChanged: (value) {
              licenseNumber = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "This information is required for tax reporting and compliance purposes.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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

  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.contact_mail,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Contact & Location",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Street Address",
            value: address,
            hint: "Enter business address",
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: city,
                  hint: "City",
                  validator: Validator.required,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "State",
                  value: state,
                  hint: "State",
                  validator: Validator.required,
                  onChanged: (value) {
                    state = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "ZIP",
                  value: zipCode,
                  hint: "ZIP",
                  validator: Validator.required,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: phone,
                  hint: "Business phone",
                  validator: Validator.required,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: email,
                  hint: "Business email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Website",
            value: website,
            hint: "Business website URL",
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Financial Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Bank Name",
            value: bankName,
            hint: "Primary bank name",
            validator: Validator.required,
            onChanged: (value) {
              bankName = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Account Number",
                  value: accountNumber,
                  hint: "Bank account number",
                  validator: Validator.required,
                  onChanged: (value) {
                    accountNumber = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Routing Number",
                  value: routingNumber,
                  hint: "Bank routing number",
                  validator: Validator.required,
                  onChanged: (value) {
                    routingNumber = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QNumberField(
                  label: "Monthly Revenue (\$)",
                  value: averageMonthlyRevenue.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    averageMonthlyRevenue = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Employee Count",
                  value: employeeCount.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    employeeCount = int.tryParse(value) ?? 0;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "All financial information is encrypted and securely stored.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
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

  Widget _buildSocialMediaSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.share,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Social Media Presence",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Facebook URL",
            value: facebookUrl,
            hint: "facebook.com/yourrestaurant",
            onChanged: (value) {
              facebookUrl = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Instagram URL",
            value: instagramUrl,
            hint: "instagram.com/yourrestaurant",
            onChanged: (value) {
              instagramUrl = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Twitter URL",
            value: twitterUrl,
            hint: "twitter.com/yourrestaurant",
            onChanged: (value) {
              twitterUrl = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.photo_library,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Restaurant Images",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QImagePicker(
            label: "Logo Image",
            value: logoImage,
            hint: "Upload your restaurant logo",
            onChanged: (value) {
              logoImage = value;
              setState(() {});
            },
          ),
          QImagePicker(
            label: "Cover Image",
            value: coverImage,
            hint: "Upload a cover photo of your restaurant",
            onChanged: (value) {
              coverImage = value;
              setState(() {});
            },
          ),
          QMultiImagePicker(
            label: "Gallery Images",
            value: galleryImages,
            hint: "Upload photos of your food, interior, and atmosphere",
            maxImages: 10,
            onChanged: (value) {
              galleryImages = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Preview Profile",
              icon: Icons.preview,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                si("Opening profile preview");
              },
            ),
          ),
          Expanded(
            child: QButton(
              label: "Save Profile",
              icon: Icons.save,
              size: bs.sm,
              onPressed: _saveProfile,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Profile"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Opening profile settings");
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildBasicInfoSection(),
              _buildLegalInfoSection(),
              _buildContactSection(),
              _buildFinancialSection(),
              _buildSocialMediaSection(),
              _buildImagesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
