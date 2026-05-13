import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact4View extends StatefulWidget {
  @override
  State<GrlContact4View> createState() => _GrlContact4ViewState();
}

class _GrlContact4ViewState extends State<GrlContact4View> {
  String name = '';
  String phone = '';
  String email = '';
  String company = '';
  String position = '';
  String notes = '';
  String selectedCategory = 'personal';
  String profileImage = '';
  bool isFavorite = false;
  DateTime? birthday;
  
  final formKey = GlobalKey<FormState>();
  
  List<String> socialLinks = [];
  List<String> tags = [];
  String newTag = '';
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Personal", "value": "personal"},
    {"label": "Work", "value": "work"},
    {"label": "Family", "value": "family"},
    {"label": "Friends", "value": "friends"},
    {"label": "Business", "value": "business"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Contact"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveContact();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: primaryColor.withAlpha(20),
                          backgroundImage: profileImage.isNotEmpty 
                              ? NetworkImage(profileImage)
                              : null,
                          child: profileImage.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: primaryColor,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // Handle image picker
                              profileImage = "https://picsum.photos/200/200?random=30&keyword=person";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [shadowSm],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Tap to add profile photo",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Basic Information
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Full Name",
                value: name,
                hint: "Enter full name",
                validator: Validator.required,
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Phone Number",
                      value: phone,
                      hint: "+1 (555) 123-4567",
                      validator: Validator.required,
                      onChanged: (value) {
                        phone = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Test call
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Email Address",
                value: email,
                hint: "contact@example.com",
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Category Selection
              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Favorite Toggle
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Mark as Favorite",
                          "value": true,
                          "checked": isFavorite,
                        }
                      ],
                      value: [
                        if (isFavorite)
                          {
                            "label": "Mark as Favorite",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isFavorite = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                  if (isFavorite)
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 24,
                    ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Work Information
              Text(
                "Work Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Company",
                value: company,
                hint: "Company name",
                onChanged: (value) {
                  company = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Position",
                value: position,
                hint: "Job title",
                onChanged: (value) {
                  position = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Birthday
              Text(
                "Personal Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QDatePicker(
                label: "Birthday (Optional)",
                value: birthday,
                onChanged: (value) {
                  birthday = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Tags Section
              Text(
                "Tags",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Add Tag",
                      value: newTag,
                      hint: "e.g. tech, client, friend",
                      onChanged: (value) {
                        newTag = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add",
                    size: bs.sm,
                    onPressed: () {
                      if (newTag.isNotEmpty && !tags.contains(newTag)) {
                        tags.add(newTag);
                        newTag = '';
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
              
              if (tags.isNotEmpty) ...[
                SizedBox(height: spMd),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tag,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              tags.remove(tag);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
              
              SizedBox(height: spMd),
              
              // Notes Section
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QMemoField(
                label: "Additional Notes",
                value: notes,
                hint: "Add any additional information about this contact",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              // Social Links Section
              Text(
                "Social Links",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              _buildSocialLinksSection(),
              
              SizedBox(height: spMd),
              
              // Preview Card
              Text(
                "Contact Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              _buildPreviewCard(),
              
              SizedBox(height: spMd),
              
              // Save Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Contact",
                  icon: Icons.save,
                  onPressed: () {
                    _saveContact();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinksSection() {
    return Column(
      children: [
        // LinkedIn
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.business,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "LinkedIn",
                value: socialLinks.length > 0 ? socialLinks[0] : '',
                hint: "linkedin.com/in/username",
                onChanged: (value) {
                  if (socialLinks.isEmpty) {
                    socialLinks.add(value);
                  } else {
                    socialLinks[0] = value;
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        // Twitter
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.alternate_email,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QTextField(
                label: "Twitter",
                value: socialLinks.length > 1 ? socialLinks[1] : '',
                hint: "@username",
                onChanged: (value) {
                  if (socialLinks.length < 2) {
                    socialLinks.add(value);
                  } else {
                    socialLinks[1] = value;
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviewCard() {
    if (name.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Column(
          children: [
            Icon(
              Icons.preview,
              size: 48,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "Contact Preview",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Fill in the name to see preview",
              style: TextStyle(
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: primaryColor.withAlpha(20),
                  backgroundImage: profileImage.isNotEmpty 
                      ? NetworkImage(profileImage)
                      : null,
                  child: profileImage.isEmpty
                      ? Icon(
                          Icons.person,
                          size: 30,
                          color: primaryColor,
                        )
                      : null,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isFavorite)
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 20,
                            ),
                        ],
                      ),
                      if (position.isNotEmpty)
                        Text(
                          position,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (company.isNotEmpty)
                        Text(
                          company,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.only(top: spXs),
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(selectedCategory).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedCategory.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: _getCategoryColor(selectedCategory),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Contact Info
            if (phone.isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],
            
            if (email.isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 16,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],
            
            if (birthday != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.cake,
                    size: 16,
                    color: primaryColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    birthday!.dMMMy,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],
            
            // Tags
            if (tags.isNotEmpty) ...[
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: tags.map((tag) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
            
            if (notes.isNotEmpty) ...[
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notes:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      notes,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if (formKey.currentState!.validate()) {
      // Simulate saving contact
      ss("Contact saved successfully!");
      back();
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'work':
        return primaryColor;
      case 'family':
        return successColor;
      case 'friends':
        return warningColor;
      case 'business':
        return infoColor;
      default:
        return secondaryColor;
    }
  }
}
