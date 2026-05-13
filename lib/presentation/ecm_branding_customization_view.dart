import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmBrandingCustomizationView extends StatefulWidget {
  const EcmBrandingCustomizationView({super.key});

  @override
  State<EcmBrandingCustomizationView> createState() => _EcmBrandingCustomizationViewState();
}

class _EcmBrandingCustomizationViewState extends State<EcmBrandingCustomizationView> {
  int currentTab = 0;
  
  // Event Branding
  String eventName = "Tech Innovation Summit 2024";
  String eventTagline = "Shaping the Future of Technology";
  String primaryColorHex = "#2196F3";
  String secondaryColorHex = "#FFC107";
  String fontFamily = "Roboto";
  String logoUrl = "https://picsum.photos/200/100?random=1&keyword=logo";
  
  // Templates
  List<Map<String, dynamic>> templates = [
    {
      "id": 1,
      "name": "Modern Tech",
      "category": "Technology",
      "preview": "https://picsum.photos/300/200?random=1&keyword=tech",
      "primaryColor": "#2196F3",
      "secondaryColor": "#FFC107",
      "fontFamily": "Roboto",
      "isSelected": true,
    },
    {
      "id": 2,
      "name": "Corporate Professional",
      "category": "Business",
      "preview": "https://picsum.photos/300/200?random=2&keyword=business",
      "primaryColor": "#1565C0",
      "secondaryColor": "#37474F",
      "fontFamily": "Open Sans",
      "isSelected": false,
    },
    {
      "id": 3,
      "name": "Creative Design",
      "category": "Creative",
      "preview": "https://picsum.photos/300/200?random=3&keyword=creative",
      "primaryColor": "#E91E63",
      "secondaryColor": "#9C27B0",
      "fontFamily": "Poppins",
      "isSelected": false,
    },
    {
      "id": 4,
      "name": "Medical Conference",
      "category": "Healthcare",
      "preview": "https://picsum.photos/300/200?random=4&keyword=medical",
      "primaryColor": "#4CAF50",
      "secondaryColor": "#2E7D32",
      "fontFamily": "Lato",
      "isSelected": false,
    },
  ];

  // Brand Assets
  List<Map<String, dynamic>> brandAssets = [
    {
      "type": "Logo",
      "filename": "event_logo_primary.png",
      "size": "2.1 MB",
      "dimensions": "800x400",
      "uploadDate": "2024-06-15",
      "url": "https://picsum.photos/200/100?random=10&keyword=logo",
    },
    {
      "type": "Banner",
      "filename": "event_banner_main.jpg",
      "size": "3.5 MB",
      "dimensions": "1920x1080",
      "uploadDate": "2024-06-14",
      "url": "https://picsum.photos/400/200?random=11&keyword=banner",
    },
    {
      "type": "Icon",
      "filename": "event_icon.png",
      "size": "512 KB",
      "dimensions": "256x256",
      "uploadDate": "2024-06-13",
      "url": "https://picsum.photos/100/100?random=12&keyword=icon",
    },
    {
      "type": "Background",
      "filename": "event_background.jpg",
      "size": "4.2 MB",
      "dimensions": "1920x1080",
      "uploadDate": "2024-06-12",
      "url": "https://picsum.photos/400/300?random=13&keyword=background",
    },
  ];

  // Materials
  List<Map<String, dynamic>> materials = [
    {
      "name": "Registration Form",
      "type": "Form",
      "status": "Customized",
      "lastUpdated": "2024-06-18",
      "preview": "https://picsum.photos/200/300?random=20&keyword=form",
    },
    {
      "name": "Email Templates",
      "type": "Email",
      "status": "In Progress",
      "lastUpdated": "2024-06-17",
      "preview": "https://picsum.photos/200/300?random=21&keyword=email",
    },
    {
      "name": "Name Badges",
      "type": "Print",
      "status": "Ready",
      "lastUpdated": "2024-06-16",
      "preview": "https://picsum.photos/200/300?random=22&keyword=badge",
    },
    {
      "name": "Social Media Kit",
      "type": "Social",
      "status": "Customized",
      "lastUpdated": "2024-06-15",
      "preview": "https://picsum.photos/200/300?random=23&keyword=social",
    },
    {
      "name": "Mobile App Theme",
      "type": "App",
      "status": "Ready",
      "lastUpdated": "2024-06-14",
      "preview": "https://picsum.photos/200/300?random=24&keyword=app",
    },
    {
      "name": "Presentation Template",
      "type": "Presentation",
      "status": "In Progress",
      "lastUpdated": "2024-06-13",
      "preview": "https://picsum.photos/200/300?random=25&keyword=presentation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Branding & Customization",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Brand Setup", icon: Icon(Icons.palette)),
        Tab(text: "Templates", icon: Icon(Icons.design_services)),
        Tab(text: "Assets", icon: Icon(Icons.collections)),
        Tab(text: "Materials", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildBrandSetupTab(),
        _buildTemplatesTab(),
        _buildAssetsTab(),
        _buildMaterialsTab(),
      ],
    );
  }

  Widget _buildBrandSetupTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildEventInfoSection(),
          SizedBox(height: spMd),
          _buildColorSchemeSection(),
          SizedBox(height: spMd),
          _buildTypographySection(),
          SizedBox(height: spMd),
          _buildLogoSection(),
          SizedBox(height: spMd),
          _buildPreviewSection(),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Brand Settings",
              size: bs.md,
              onPressed: () {
                ss("Brand settings saved successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Event Name",
            value: eventName,
            onChanged: (value) {
              eventName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Event Tagline",
            value: eventTagline,
            onChanged: (value) {
              eventTagline = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color Scheme",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Primary Color",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(int.parse(primaryColorHex.substring(1), radix: 16) + 0xFF000000),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledBoldColor),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Hex Code",
                            value: primaryColorHex,
                            onChanged: (value) {
                              primaryColorHex = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Secondary Color",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(int.parse(secondaryColorHex.substring(1), radix: 16) + 0xFF000000),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledBoldColor),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Hex Code",
                            value: secondaryColorHex,
                            onChanged: (value) {
                              secondaryColorHex = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Predefined Color Schemes",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          QHorizontalScroll(
            children: [
              _buildColorSchemeOption("Blue & Orange", "#2196F3", "#FF9800"),
              _buildColorSchemeOption("Green & Teal", "#4CAF50", "#009688"),
              _buildColorSchemeOption("Purple & Pink", "#9C27B0", "#E91E63"),
              _buildColorSchemeOption("Indigo & Cyan", "#3F51B5", "#00BCD4"),
              _buildColorSchemeOption("Red & Deep Orange", "#F44336", "#FF5722"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeOption(String name, String primary, String secondary) {
    return GestureDetector(
      onTap: () {
        primaryColorHex = primary;
        secondaryColorHex = secondary;
        setState(() {});
        ss("Applied $name color scheme");
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: disabledBoldColor),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(int.parse(primary.substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
                SizedBox(width: spXs),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(int.parse(secondary.substring(1), radix: 16) + 0xFF000000),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographySection() {
    List<String> fontOptions = ["Roboto", "Open Sans", "Lato", "Poppins", "Montserrat", "Inter"];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Typography",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Primary Font Family",
            items: fontOptions.map((font) => {
              "label": font,
              "value": font,
            }).toList(),
            value: fontFamily,
            onChanged: (value, label) {
              fontFamily = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Text(
            "Font Preview",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  eventTagline,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "This is how your event text will appear with the selected font family.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Logo",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                width: 100,
                height: 60,
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledBoldColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    logoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QButton(
                      label: "Upload New Logo",
                      size: bs.sm,
                      onPressed: () {
                        ss("Logo upload functionality");
                      },
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Recommended: PNG format, 400x200px minimum",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Brand Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(int.parse(primaryColorHex.substring(1), radix: 16) + 0xFF000000),
                  Color(int.parse(secondaryColorHex.substring(1), radix: 16) + 0xFF000000),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Image.network(
                  logoUrl,
                  width: 80,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: spSm),
                Text(
                  eventName,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  eventTagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Choose a Template",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Select a pre-designed template that matches your event style",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: templates.map((template) {
              bool isSelected = template["isSelected"];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${template["preview"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${template["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(template["primaryColor"].substring(1), radix: 16) + 0xFF000000),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Color(int.parse(template["secondaryColor"].substring(1), radix: 16) + 0xFF000000),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${template["fontFamily"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: isSelected ? "Selected" : "Select Template",
                              size: bs.sm,
                              onPressed: () {
                                for (var t in templates) {
                                  t["isSelected"] = false;
                                }
                                template["isSelected"] = true;
                                
                                primaryColorHex = template["primaryColor"];
                                secondaryColorHex = template["secondaryColor"];
                                fontFamily = template["fontFamily"];
                                
                                setState(() {});
                                ss("Selected ${template["name"]} template");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Brand Assets",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Upload Asset",
                size: bs.sm,
                onPressed: () {
                  ss("Upload new brand asset");
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: brandAssets.map((asset) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${asset["url"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(100)),
                          ),
                          child: Text(
                            "${asset["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${asset["size"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${asset["filename"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${asset["dimensions"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${asset["uploadDate"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Download",
                            size: bs.sm,
                            onPressed: () {
                              ss("Downloading ${asset["filename"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Replace",
                            size: bs.sm,
                            onPressed: () {
                              ss("Replacing ${asset["filename"]}");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Branded Materials",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Customize event materials with your branding",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: materials.map((material) {
              Color statusColor;
              switch (material["status"]) {
                case "Ready":
                  statusColor = successColor;
                  break;
                case "Customized":
                  statusColor = primaryColor;
                  break;
                case "In Progress":
                  statusColor = warningColor;
                  break;
                default:
                  statusColor = disabledColor;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${material["preview"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${material["status"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${material["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: secondaryColor.withAlpha(100)),
                                ),
                                child: Text(
                                  "${material["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${material["lastUpdated"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Customize",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Customizing ${material["name"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Preview",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Previewing ${material["name"]}");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
