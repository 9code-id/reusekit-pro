import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamSetupView extends StatefulWidget {
  const PmaTeamSetupView({super.key});

  @override
  State<PmaTeamSetupView> createState() => _PmaTeamSetupViewState();
}

class _PmaTeamSetupViewState extends State<PmaTeamSetupView> {
  final formKey = GlobalKey<FormState>();
  String teamName = "";
  String teamDescription = "";
  String inviteEmail = "";
  String selectedRole = "member";
  bool loading = false;
  int currentStep = 0;

  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "John Doe",
      "email": "john@company.com",
      "role": "Admin",
      "status": "Active",
      "avatar": "https://picsum.photos/100/100?random=1",
    },
  ];

  List<Map<String, dynamic>> pendingInvites = [];

  List<Map<String, dynamic>> roleItems = [
    {"label": "Team Member", "value": "member"},
    {"label": "Project Manager", "value": "manager"},
    {"label": "Admin", "value": "admin"},
  ];

  void _createTeam() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    currentStep = 1;
    setState(() {});

    ss("Team created successfully");
  }

  void _sendInvite() async {
    if (inviteEmail.isEmpty) {
      se("Please enter email address");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    pendingInvites.add({
      "email": inviteEmail,
      "role": selectedRole,
      "sentAt": DateTime.now(),
    });

    inviteEmail = "";
    loading = false;
    setState(() {});

    ss("Invitation sent successfully");
  }

  void _completeSetup() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Team setup completed successfully");
    await offAll(PmaHomeView());
  }

  Widget _buildCreateTeamStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.groups,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: spSm),
              Text(
                "Create Your Team",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Set up your team workspace for better collaboration",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(230),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Team Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Team Name",
                value: teamName,
                validator: Validator.required,
                hint: "e.g., Development Team, Marketing Squad",
                onChanged: (value) {
                  teamName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Team Description",
                value: teamDescription,
                hint: "Describe your team's purpose and goals",
                onChanged: (value) {
                  teamDescription = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Create Team",
            size: bs.md,
            onPressed: _createTeam,
          ),
        ),
      ],
    );
  }

  Widget _buildInviteMembersStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person_add,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: spSm),
              Text(
                "Invite Team Members",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Add team members to start collaborating on projects",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(230),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send Invitation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Email Address",
                value: inviteEmail,
                hint: "colleague@company.com",
                onChanged: (value) {
                  inviteEmail = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Role",
                items: roleItems,
                value: selectedRole,
                onChanged: (value, label) {
                  selectedRole = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Invitation",
                  size: bs.sm,
                  onPressed: _sendInvite,
                ),
              ),
            ],
          ),
        ),
        if (teamMembers.isNotEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...teamMembers.map((member) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: successColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${member["avatar"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${member["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${member["role"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        if (pendingInvites.isNotEmpty)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Invitations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...pendingInvites.map((invite) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: warningColor.withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${invite["email"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Role: ${invite["role"]} • Pending",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Complete Setup",
            size: bs.md,
            onPressed: _completeSetup,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Skip for Now",
            size: bs.sm,
            onPressed: _completeSetup,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentStep == 0 ? "Create Team" : "Invite Members"),
        centerTitle: true,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: currentStep == 0
                    ? _buildCreateTeamStep()
                    : _buildInviteMembersStep(),
              ),
            ),
    );
  }
}
