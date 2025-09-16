import 'package:flutter/material.dart';
import 'package:project_movie_app/core/styles/app_colors.dart';
import 'package:project_movie_app/core/styles/app_styles.dart';
import 'package:project_movie_app/core/utility/app_preferences/user_storage.dart';
import 'package:project_movie_app/core/routes/app_routes.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  int selectedAvatar = 1;

  final List<String> avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    phoneController = TextEditingController(text: widget.user['phone']);
    selectedAvatar = widget.user['avatarId'] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black12,
      appBar: AppBar(
        backgroundColor: AppColors.black21,
        title: Text("Update Profile", style: AppStyles.white20bold),
        leading: BackButton(color: AppColors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar Picker
            Text("Pick Avatar", style: AppStyles.white16Regular),
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage(avatars[selectedAvatar - 1]),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: avatars.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedAvatar = index + 1;
                      });
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(avatars[index]),
                      // highlight selected
                      foregroundColor: selectedAvatar == index + 1
                          ? AppColors.yellowF6
                          : Colors.transparent,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Name field
            TextField(
              controller: nameController,
              style: AppStyles.white16Regular,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                filled: true,
                fillColor: AppColors.black21,
                hintText: "Name",
                hintStyle: AppStyles.white16Regular,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Phone field
            TextField(
              controller: phoneController,
              style: AppStyles.white16Regular,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: Colors.white),
                filled: true,
                fillColor: AppColors.black21,
                hintText: "Phone",
                hintStyle: AppStyles.white16Regular,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),

            // Delete + Update Buttons
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redF8,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    UserStorage.clearUser();
                    Navigator.pushReplacement(context, AppRoutes.login);
                  },
                  child: Text("Delete Account", style: AppStyles.white16Regular),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowF6,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    final _ = {
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "email": widget.user['email'], // email ثابت
                      "avatarId": selectedAvatar,
                    };

                    await UserStorage.saveUser( name: nameController.text, email: widget.user['email'], avatarId: selectedAvatar );

                    Navigator.pop(context, true);
                  },
                  child: Text("Update Data", style: AppStyles.black16Regular),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}