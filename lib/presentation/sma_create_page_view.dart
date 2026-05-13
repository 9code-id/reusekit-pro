import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCreatePageView extends StatefulWidget {
  const SmaCreatePageView({super.key});

  @override
  State<SmaCreatePageView> createState() => _SmaCreatePageViewState();
}

class _SmaCreatePageViewState extends State<SmaCreatePageView> {
  String pageName = "";
  String pageDescription = "";
  String category = "Business";
  String website = "";
  String phone = "";
  String email = "";
  String address = "";
  String coverImage = "";
  String profileImage = "";
  List<String> services = [];
  String newService = "";
  Map<String, String> businessHours = {
    "monday": "9:00 AM - 6:00 PM",
    "tuesday": "9:00 AM - 6:00 PM",
    "wednesday": "9:00 AM - 6:00 PM",
    "thursday": "9:00 AM - 6:00 PM",
    "friday": "9:00 AM - 6:00 PM",
    "saturday": "Closed",
    "sunday": "Closed",
  };
  
  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "Business", "value": "Business"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Education", "value": "Education"},
    {"label": "Restaurant", "value": "Restaurant"},
    {"label": "Retail", "value": "Retail"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Non-profit", "value": "Non-profit"},
    {"label": "Government", "value": "Government"},
    {"label": "Other", "value": "Other"},
  ];

  final List<String> timeSlots = [
    "Closed",
    "12:00 AM - 1:00 AM",
    "1:00 AM - 2:00 AM",
    "2:00 AM - 3:00 AM",
    "3:00 AM - 4:00 AM",
    "4:00 AM - 5:00 AM",
    "5:00 AM - 6:00 AM",
    "6:00 AM - 7:00 AM",
    "7:00 AM - 8:00 AM",
    "8:00 AM - 9:00 AM",
    "9:00 AM - 10:00 AM",
    "9:00 AM - 5:00 PM",
    "9:00 AM - 6:00 PM",
    "10:00 AM - 6:00 PM",
    "24 Hours",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Page"),
        actions: [
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: _createPage,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Page Type Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: primaryColor.withAlpha(100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Create Business Page",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Connect with customers and promote your business on social media",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Basic Information Section
            Text(
              "Basic Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Page Images
            QImagePicker(
              label: "Cover Image",
              value: coverImage,
              hint: "Upload a cover image for your page",
              onChanged: (value) {
                coverImage = value;
                setState(() {});
              },
            ),

            QImagePicker(
              label: "Profile Image",
              value: profileImage,
              hint: "Upload a profile image/logo",
              onChanged: (value) {
                profileImage = value;
                setState(() {});
              },
            ),

            // Page Name
            QTextField(
              label: "Page Name",
              value: pageName,
              hint: "Enter your business/page name",
              validator: Validator.required,
              onChanged: (value) {
                pageName = value;
                setState(() {});
              },
            ),

            // Category
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: category,
              validator: Validator.required,
              onChanged: (value, label) {
                category = value;
                setState(() {});
              },
            ),

            // Description
            QMemoField(
              label: "Description",
              value: pageDescription,
              hint: "Describe what your page/business is about...",
              maxLines: 4,
              validator: Validator.required,
              onChanged: (value) {
                pageDescription = value;
                setState(() {});
              },
            ),

            // Contact Information Section
            Text(
              "Contact Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Website
            QTextField(
              label: "Website",
              value: website,
              hint: "https://yourwebsite.com",
              onChanged: (value) {
                website = value;
                setState(() {});
              },
            ),

            // Phone and Email
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Phone Number",
                    value: phone,
                    hint: "+1 (555) 123-4567",
                    onChanged: (value) {
                      phone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Email",
                    value: email,
                    hint: "contact@business.com",
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Address
            QTextField(
              label: "Address",
              value: address,
              hint: "123 Business St, City, State, ZIP",
              onChanged: (value) {
                address = value;
                setState(() {});
              },
            ),

            // Services Section
            Text(
              "Services/Products",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Add Service
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Add Service",
                    value: newService,
                    hint: "Enter service or product name",
                    onChanged: (value) {
                      newService = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Add",
                  size: bs.sm,
                  onPressed: _addService,
                ),
              ],
            ),

            // Services List
            if (services.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Services/Products",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: services.map((service) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                service,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  services.remove(service);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Business Hours Section
            Text(
              "Business Hours",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: businessHours.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "${entry.key.substring(0, 1).toUpperCase()}${entry.key.substring(1)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "",
                            items: timeSlots.map((slot) => {"label": slot, "value": slot}).toList(),
                            value: entry.value,
                            onChanged: (value, label) {
                              businessHours[entry.key] = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Page Guidelines
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Page Guidelines",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Use accurate business information\n• Upload high-quality images\n• Provide complete contact details\n• Follow community standards\n• Respect customer privacy",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

            // Page Preview
            if (pageName.isNotEmpty || pageDescription.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Page Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    // Mock Cover Image
                    if (coverImage.isNotEmpty)
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "Cover Image",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    
                    SizedBox(height: spSm),
                    
                    // Page Info
                    Row(
                      children: [
                        if (profileImage.isNotEmpty)
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.business,
                              color: Colors.white,
                            ),
                          ),
                        if (profileImage.isNotEmpty) SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (pageName.isNotEmpty)
                                Text(
                                  pageName,
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              if (category.isNotEmpty)
                                Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    if (pageDescription.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Text(
                        pageDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            // Create Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Page",
                size: bs.md,
                onPressed: _createPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addService() {
    if (newService.trim().isNotEmpty && !services.contains(newService.trim())) {
      services.add(newService.trim());
      newService = "";
      setState(() {});
    }
  }

  void _createPage() {
    if (pageName.isEmpty) {
      se("Please enter a page name");
      return;
    }
    
    if (pageDescription.isEmpty) {
      se("Please enter a page description");
      return;
    }

    ss("Page created successfully!");
    back();
  }
}
