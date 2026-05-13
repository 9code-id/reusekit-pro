import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaEditProfileView extends StatefulWidget {
  const FwaEditProfileView({super.key});

  @override
  State<FwaEditProfileView> createState() => _FwaEditProfileViewState();
}

class _FwaEditProfileViewState extends State<FwaEditProfileView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "Alex Johnson";
  String email = "alex.johnson@email.com";
  String phone = "+1 (555) 123-4567";
  String bio = "Fitness enthusiast passionate about running and strength training. Always looking for new challenges!";
  String location = "San Francisco, CA";
  String dateOfBirth = "1990-08-15";
  String gender = "male";
  String height = "175";
  String weight = "70";
  String activityLevel = "moderate";
  String profileImage = "https://picsum.photos/150/150?random=1&keyword=person";
  
  List<String> goals = ["Lose 10 lbs", "Run 5K under 25 min", "Increase bench press"];
  String newGoal = "";
  
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              _saveProfile();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spLg,
            children: [
              // Profile Picture Section
              _buildProfilePictureSection(),
              
              // Basic Information
              _buildBasicInfoSection(),
              
              // Physical Information
              _buildPhysicalInfoSection(),
              
              // Fitness Information
              _buildFitnessInfoSection(),
              
              // Goals Section
              _buildGoalsSection(),
              
              // Bio Section
              _buildBioSection(),
              
              // Save Button
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Profile Picture",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    ss("Change profile picture feature");
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Tap to change profile picture",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
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
            label: "Full Name",
            value: fullName,
            validator: Validator.required,
            onChanged: (value) {
              fullName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: phone,
            hint: "+1 (555) 123-4567",
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Location",
            value: location,
            hint: "City, State/Country",
            onChanged: (value) {
              location = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Date of Birth",
            value: DateTime.parse(dateOfBirth),
            onChanged: (value) {
              dateOfBirth = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Gender",
            items: [
              {"label": "Male", "value": "male"},
              {"label": "Female", "value": "female"},
              {"label": "Other", "value": "other"},
              {"label": "Prefer not to say", "value": "not_specified"},
            ],
            value: gender,
            onChanged: (value, label) {
              gender = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhysicalInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Physical Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Height (cm)",
                  value: height,
                  validator: Validator.required,
                  onChanged: (value) {
                    height = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Weight (kg)",
                  value: weight,
                  validator: Validator.required,
                  onChanged: (value) {
                    weight = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Activity Level",
            items: [
              {"label": "Sedentary (little or no exercise)", "value": "sedentary"},
              {"label": "Light (1-3 days/week)", "value": "light"},
              {"label": "Moderate (3-5 days/week)", "value": "moderate"},
              {"label": "Active (6-7 days/week)", "value": "active"},
              {"label": "Very Active (2x/day or intense)", "value": "very_active"},
            ],
            value: activityLevel,
            onChanged: (value, label) {
              activityLevel = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessInfoSection() {
    List<Map<String, String>> fitnessGoals = [
      {"label": "Weight Loss", "value": "weight_loss"},
      {"label": "Weight Gain", "value": "weight_gain"},
      {"label": "Muscle Building", "value": "muscle_building"},
      {"label": "Endurance", "value": "endurance"},
      {"label": "Strength", "value": "strength"},
      {"label": "Flexibility", "value": "flexibility"},
      {"label": "General Fitness", "value": "general_fitness"},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Fitness Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            label: "Primary Fitness Goal",
            items: fitnessGoals,
            value: "weight_loss",
            onChanged: (index, label, value, item) {
              ss("Primary goal updated to $label");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Personal Goals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...goals.asMap().entries.map((entry) {
            int index = entry.key;
            String goal = entry.value;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      goal,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Remove this goal?");
                      if (isConfirmed) {
                        setState(() {
                          goals.removeAt(index);
                        });
                        ss("Goal removed");
                      }
                    },
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add New Goal",
                  value: newGoal,
                  hint: "Enter a new fitness goal",
                  onChanged: (value) {
                    newGoal = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  if (newGoal.trim().isNotEmpty) {
                    setState(() {
                      goals.add(newGoal.trim());
                      newGoal = "";
                    });
                    ss("Goal added successfully");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "About Me",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Bio",
            value: bio,
            hint: "Tell others about your fitness journey, interests, and what motivates you...",
            onChanged: (value) {
              bio = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Changes",
              size: bs.md,
              onPressed: () {
                _saveProfile();
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    back();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset",
                  size: bs.sm,
                  onPressed: () async {
                    bool isConfirmed = await confirm("Reset all changes? This will restore the original values.");
                    if (isConfirmed) {
                      _resetForm();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      loading = false;
      setState(() {});
      
      ss("Profile updated successfully");
      back();
    }
  }

  void _resetForm() {
    setState(() {
      fullName = "Alex Johnson";
      email = "alex.johnson@email.com";
      phone = "+1 (555) 123-4567";
      bio = "Fitness enthusiast passionate about running and strength training. Always looking for new challenges!";
      location = "San Francisco, CA";
      dateOfBirth = "1990-08-15";
      gender = "male";
      height = "175";
      weight = "70";
      activityLevel = "moderate";
      goals = ["Lose 10 lbs", "Run 5K under 25 min", "Increase bench press"];
      newGoal = "";
    });
    ss("Form reset to original values");
  }
}
