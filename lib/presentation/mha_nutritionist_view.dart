import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaNutritionistView extends StatefulWidget {
  const MhaNutritionistView({Key? key}) : super(key: key);

  @override
  State<MhaNutritionistView> createState() => _MhaNutritionistViewState();
}

class _MhaNutritionistViewState extends State<MhaNutritionistView> {
  String searchQuery = "";
  String selectedSpecialty = "All";
  bool mealPlanningOnly = false;

  List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": "All"},
    {"label": "Weight Management", "value": "Weight"},
    {"label": "Sports Nutrition", "value": "Sports"},
    {"label": "Clinical Nutrition", "value": "Clinical"},
    {"label": "Pediatric Nutrition", "value": "Pediatric"},
    {"label": "Diabetes Management", "value": "Diabetes"},
    {"label": "Heart Health", "value": "Heart"},
  ];

  List<Map<String, dynamic>> nutritionists = [
    {
      "id": 1,
      "name": "Dr. Rachel Green",
      "specialty": "Weight Management",
      "experience": "8 years",
      "rating": 4.9,
      "reviewCount": 234,
      "image": "https://picsum.photos/150/150?random=1&keyword=nutritionist",
      "clinic": "Healthy Living Nutrition Center",
      "location": "Wellness District",
      "consultationFee": 65,
      "mealPlanning": true,
      "nextAvailable": "Today 3:00 PM",
      "status": "Available",
      "specializations": ["Weight Loss", "Metabolic Health", "Lifestyle Coaching"],
      "certifications": ["RD", "CDE", "CSSD"],
    },
    {
      "id": 2,
      "name": "Dr. Mark Thompson",
      "specialty": "Sports Nutrition",
      "experience": "12 years",
      "rating": 4.8,
      "reviewCount": 189,
      "image": "https://picsum.photos/150/150?random=2&keyword=nutritionist",
      "clinic": "Athletic Performance Nutrition",
      "location": "Sports Medicine Center",
      "consultationFee": 80,
      "mealPlanning": true,
      "nextAvailable": "Tomorrow 9:00 AM",
      "status": "Available",
      "specializations": ["Athletic Performance", "Muscle Building", "Endurance"],
      "certifications": ["CSSD", "CISSN", "NASM"],
    },
    {
      "id": 3,
      "name": "Dr. Lisa Chang",
      "specialty": "Clinical Nutrition",
      "experience": "15 years",
      "rating": 4.9,
      "reviewCount": 312,
      "image": "https://picsum.photos/150/150?random=3&keyword=nutritionist",
      "clinic": "Medical Nutrition Therapy Clinic",
      "location": "University Hospital",
      "consultationFee": 75,
      "mealPlanning": false,
      "nextAvailable": "Monday 10:30 AM",
      "status": "Available",
      "specializations": ["Medical Nutrition", "Gastrointestinal Health", "Renal Nutrition"],
      "certifications": ["RD", "CNSC", "CSR"],
    },
    {
      "id": 4,
      "name": "Dr. Sarah Martinez",
      "specialty": "Pediatric Nutrition",
      "experience": "10 years",
      "rating": 4.8,
      "reviewCount": 156,
      "image": "https://picsum.photos/150/150?random=4&keyword=nutritionist",
      "clinic": "Children's Nutrition Clinic",
      "location": "Pediatric Medical Center",
      "consultationFee": 70,
      "mealPlanning": true,
      "nextAvailable": "Today 5:00 PM",
      "status": "Available",
      "specializations": ["Childhood Obesity", "Picky Eating", "Growth Support"],
      "certifications": ["RD", "CSP", "IBCLC"],
    },
    {
      "id": 5,
      "name": "Dr. James Wilson",
      "specialty": "Diabetes Management",
      "experience": "18 years",
      "rating": 4.7,
      "reviewCount": 267,
      "image": "https://picsum.photos/150/150?random=5&keyword=nutritionist",
      "clinic": "Diabetes Care & Nutrition",
      "location": "Endocrinology Institute",
      "consultationFee": 85,
      "mealPlanning": true,
      "nextAvailable": "Wednesday 2:00 PM",
      "status": "Busy",
      "specializations": ["Type 1 Diabetes", "Type 2 Diabetes", "Prediabetes"],
      "certifications": ["RD", "CDE", "BC-ADM"],
    },
    {
      "id": 6,
      "name": "Dr. Emily Roberts",
      "specialty": "Heart Health",
      "experience": "14 years",
      "rating": 4.9,
      "reviewCount": 198,
      "image": "https://picsum.photos/150/150?random=6&keyword=nutritionist",
      "clinic": "Cardiovascular Nutrition Center",
      "location": "Heart Institute",
      "consultationFee": 78,
      "mealPlanning": true,
      "nextAvailable": "Tomorrow 1:30 PM",
      "status": "Available",
      "specializations": ["Heart Disease Prevention", "Cholesterol Management", "Hypertension"],
      "certifications": ["RD", "FAND", "CDCES"],
    },
  ];

  List<Map<String, dynamic>> get filteredNutritionists {
    return nutritionists.where((nutritionist) {
      bool matchesSearch = nutritionist["name"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          nutritionist["specialty"]
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      bool matchesSpecialty = selectedSpecialty == "All" ||
          nutritionist["specialty"].toString().contains(selectedSpecialty == "Weight" ? "Weight" :
              selectedSpecialty == "Sports" ? "Sports" :
              selectedSpecialty == "Clinical" ? "Clinical" :
              selectedSpecialty == "Pediatric" ? "Pediatric" :
              selectedSpecialty == "Diabetes" ? "Diabetes" :
              selectedSpecialty == "Heart" ? "Heart" : "");

      bool matchesMealPlanning = !mealPlanningOnly || (nutritionist["mealPlanning"] as bool);

      return matchesSearch && matchesSpecialty && matchesMealPlanning;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutritionists"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search nutritionists or specialties...",
              value: searchQuery,
              hint: "Enter nutritionist name or specialty",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Specialty",
                    items: specialties,
                    value: selectedSpecialty,
                    onChanged: (value, label) {
                      selectedSpecialty = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Meal Planning Available",
                        "value": true,
                        "checked": mealPlanningOnly,
                      }
                    ],
                    value: [
                      if (mealPlanningOnly)
                        {
                          "label": "Meal Planning Available",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      mealPlanningOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Text(
                "${filteredNutritionists.length} nutritionists found",
                style: TextStyle(
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Nutritionists List
            ...filteredNutritionists.map((nutritionist) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    // Nutritionist Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${nutritionist["image"]}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${nutritionist["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${nutritionist["specialty"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${nutritionist["experience"]} experience",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${nutritionist["rating"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${nutritionist["reviewCount"]} reviews)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: nutritionist["status"] == "Available"
                                ? successColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${nutritionist["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: nutritionist["status"] == "Available"
                                  ? successColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Clinic and Location
                    Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${nutritionist["clinic"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${nutritionist["location"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Specializations
                    Text(
                      "Specializations:",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (nutritionist["specializations"] as List).map((specialization) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: secondaryColor.withAlpha(50)),
                          ),
                          child: Text(
                            "$specialization",
                            style: TextStyle(
                              fontSize: 11,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Certifications
                    Text(
                      "Certifications:",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (nutritionist["certifications"] as List).map((certification) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: infoColor.withAlpha(50)),
                          ),
                          child: Text(
                            "$certification",
                            style: TextStyle(
                              fontSize: 11,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Consultation Info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: successColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "\$${nutritionist["consultationFee"]} per session",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${nutritionist["nextAvailable"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (nutritionist["mealPlanning"] as bool)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.restaurant_menu,
                                      color: warningColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Meal planning available",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Book Consultation",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "View Profile",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Empty State
            if (filteredNutritionists.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 64,
                      color: disabledColor,
                    ),
                    Text(
                      "No nutritionists found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search criteria or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
