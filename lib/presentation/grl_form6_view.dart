import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm6View extends StatefulWidget {
  @override
  State<GrlForm6View> createState() => _GrlForm6ViewState();
}

class _GrlForm6ViewState extends State<GrlForm6View> {
  final formKey = GlobalKey<FormState>();
  
  String propertyTitle = "";
  String propertyDescription = "";
  String propertyPrice = "";
  String selectedPropertyType = "";
  String selectedListingType = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String bedrooms = "";
  String bathrooms = "";
  String sqftArea = "";
  String lotSize = "";
  String yearBuilt = "";
  String selectedCondition = "";
  String selectedFurnishing = "";
  String ownerName = "";
  String ownerEmail = "";
  String ownerPhone = "";
  List<String> propertyImages = [];
  String propertyVideo = "";
  String amenities = "";
  String nearbyFacilities = "";
  String parkingSpaces = "";
  String monthlyHOA = "";
  String propertyTaxes = "";
  bool petsAllowed = false;
  bool smokingAllowed = false;
  bool hasGarden = false;
  bool hasPool = false;
  bool hasGym = false;
  bool hasElevator = false;
  DateTime availableFrom = DateTime.now();
  bool immediateOccupancy = true;

  List<Map<String, dynamic>> propertyTypeItems = [
    {"label": "Single Family House", "value": "house"},
    {"label": "Apartment", "value": "apartment"},
    {"label": "Condo", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
    {"label": "Studio", "value": "studio"},
    {"label": "Duplex", "value": "duplex"},
    {"label": "Villa", "value": "villa"},
    {"label": "Land/Lot", "value": "land"},
  ];

  List<Map<String, dynamic>> listingTypeItems = [
    {"label": "For Sale", "value": "sale"},
    {"label": "For Rent", "value": "rent"},
    {"label": "For Lease", "value": "lease"},
  ];

  List<Map<String, dynamic>> conditionItems = [
    {"label": "Excellent", "value": "excellent"},
    {"label": "Very Good", "value": "very_good"},
    {"label": "Good", "value": "good"},
    {"label": "Fair", "value": "fair"},
    {"label": "Needs Renovation", "value": "renovation"},
  ];

  List<Map<String, dynamic>> furnishingItems = [
    {"label": "Fully Furnished", "value": "fully_furnished"},
    {"label": "Semi Furnished", "value": "semi_furnished"},
    {"label": "Unfurnished", "value": "unfurnished"},
  ];

  Future<void> _submitListing() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Property listing created successfully!");
      
      //navigateTo PropertyListView
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Property"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              si("Property preview will be available after saving");
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2E7D32).withAlpha(30),
                      Color(0xFF1976D2).withAlpha(30),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: Color(0xFF2E7D32).withAlpha(60)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Color(0xFF2E7D32),
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Property Listing",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          Text(
                            "Create a detailed listing for your property",
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
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Property Title",
                      value: propertyTitle,
                      validator: Validator.required,
                      hint: "Enter an attractive property title",
                      onChanged: (value) {
                        propertyTitle = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Property Description",
                      value: propertyDescription,
                      validator: Validator.required,
                      hint: "Describe the key features and highlights of your property",
                      onChanged: (value) {
                        propertyDescription = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Property Type",
                            items: propertyTypeItems,
                            value: selectedPropertyType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedPropertyType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Listing Type",
                            items: listingTypeItems,
                            value: selectedListingType,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedListingType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QNumberField(
                      label: selectedListingType == "rent" ? "Monthly Rent (\$)" : "Price (\$)",
                      value: propertyPrice,
                      validator: Validator.required,
                      onChanged: (value) {
                        propertyPrice = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Location Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Street Address",
                      value: address,
                      validator: Validator.required,
                      onChanged: (value) {
                        address = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QTextField(
                            label: "City",
                            value: city,
                            validator: Validator.required,
                            onChanged: (value) {
                              city = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "State",
                            value: state,
                            validator: Validator.required,
                            onChanged: (value) {
                              state = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "ZIP Code",
                            value: zipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.architecture,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Property Specifications",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Bedrooms",
                            value: bedrooms,
                            validator: Validator.required,
                            onChanged: (value) {
                              bedrooms = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Bathrooms",
                            value: bathrooms,
                            validator: Validator.required,
                            onChanged: (value) {
                              bathrooms = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Square Feet",
                            value: sqftArea,
                            validator: Validator.required,
                            onChanged: (value) {
                              sqftArea = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Lot Size (sq ft)",
                            value: lotSize,
                            onChanged: (value) {
                              lotSize = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Year Built",
                            value: yearBuilt,
                            onChanged: (value) {
                              yearBuilt = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Parking Spaces",
                            value: parkingSpaces,
                            onChanged: (value) {
                              parkingSpaces = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Condition",
                            items: conditionItems,
                            value: selectedCondition,
                            onChanged: (value, label) {
                              selectedCondition = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Furnishing",
                            items: furnishingItems,
                            value: selectedFurnishing,
                            onChanged: (value, label) {
                              selectedFurnishing = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Financial Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Monthly HOA (\$)",
                            value: monthlyHOA,
                            hint: "0 if no HOA",
                            onChanged: (value) {
                              monthlyHOA = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Annual Property Tax (\$)",
                            value: propertyTaxes,
                            onChanged: (value) {
                              propertyTaxes = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: secondaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Owner Contact Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Owner Name",
                      value: ownerName,
                      validator: Validator.required,
                      onChanged: (value) {
                        ownerName = value;
                        setState(() {});
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Owner Email",
                            value: ownerEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              ownerEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Owner Phone",
                            value: ownerPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              ownerPhone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              QMultiImagePicker(
                label: "Property Images",
                value: propertyImages,
                validator: (images) {
                  if (images == null || images.isEmpty) {
                    return "At least one property image is required";
                  }
                  return null;
                },
                hint: "Upload high-quality photos of your property",
                onChanged: (value) {
                  propertyImages = value;
                  setState(() {});
                },
              ),

              QImagePicker(
                label: "Property Video (Optional)",
                value: propertyVideo,
                hint: "Upload a virtual tour or property video",
                onChanged: (value) {
                  propertyVideo = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Amenities",
                value: amenities,
                hint: "List property amenities (pool, gym, garden, etc.)",
                onChanged: (value) {
                  amenities = value;
                  setState(() {});
                },
              ),

              QMemoField(
                label: "Nearby Facilities",
                value: nearbyFacilities,
                hint: "Schools, hospitals, shopping centers, transportation",
                onChanged: (value) {
                  nearbyFacilities = value;
                  setState(() {});
                },
              ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.rule,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Property Features & Rules",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Pets Allowed",
                          "value": "pets",
                          "checked": petsAllowed,
                        },
                        {
                          "label": "Smoking Allowed",
                          "value": "smoking",
                          "checked": smokingAllowed,
                        },
                        {
                          "label": "Garden/Yard",
                          "value": "garden",
                          "checked": hasGarden,
                        },
                        {
                          "label": "Swimming Pool",
                          "value": "pool",
                          "checked": hasPool,
                        },
                        {
                          "label": "Gym/Fitness Center",
                          "value": "gym",
                          "checked": hasGym,
                        },
                        {
                          "label": "Elevator",
                          "value": "elevator",
                          "checked": hasElevator,
                        }
                      ],
                      value: [
                        if (petsAllowed) {"label": "Pets Allowed", "value": "pets", "checked": true},
                        if (smokingAllowed) {"label": "Smoking Allowed", "value": "smoking", "checked": true},
                        if (hasGarden) {"label": "Garden/Yard", "value": "garden", "checked": true},
                        if (hasPool) {"label": "Swimming Pool", "value": "pool", "checked": true},
                        if (hasGym) {"label": "Gym/Fitness Center", "value": "gym", "checked": true},
                        if (hasElevator) {"label": "Elevator", "value": "elevator", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        petsAllowed = values.any((v) => v["value"] == "pets");
                        smokingAllowed = values.any((v) => v["value"] == "smoking");
                        hasGarden = values.any((v) => v["value"] == "garden");
                        hasPool = values.any((v) => v["value"] == "pool");
                        hasGym = values.any((v) => v["value"] == "gym");
                        hasElevator = values.any((v) => v["value"] == "elevator");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              if (selectedListingType == "rent")
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Availability",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                      
                      QSwitch(
                        label: "Immediate Occupancy",
                        items: [
                          {
                            "label": "Available Now",
                            "value": true,
                            "checked": immediateOccupancy,
                          }
                        ],
                        value: [
                          if (immediateOccupancy)
                            {
                              "label": "Available Now",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          immediateOccupancy = values.isNotEmpty;
                          setState(() {});
                        },
                      ),

                      if (!immediateOccupancy)
                        QDatePicker(
                          label: "Available From",
                          value: availableFrom,
                          onChanged: (value) {
                            availableFrom = value;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Color(0xFF1976D2).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: Color(0xFF1976D2).withAlpha(40)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Color(0xFF1976D2),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your property listing will be reviewed within 24 hours before going live. High-quality photos and detailed descriptions help attract more interested buyers/renters.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Listing",
                  size: bs.md,
                  onPressed: _submitListing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
