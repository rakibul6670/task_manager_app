import 'package:flutter/material.dart';
import 'package:task_manager_app/routes/app_routes.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isUpdateProfileScreen;

  const TMAppBar({super.key, this.isUpdateProfileScreen});

  @override
  Widget build(BuildContext context) {
    //----------------------Got to Profile screen -------------
    void onTapProfileButton() {
      if (isUpdateProfileScreen == true) {
        return;
      }
      Navigator.pushNamed(context, AppRoutes.updateProfile);
    }

    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.green,
      //----------------User Profile ---------------------
      title: GestureDetector(
        onTap: onTapProfileButton,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 4,
            children: [
              //------------------User Profile Picture-----------------
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/134864638?v=4",
                ),
              ),
              //-------------------User Name and Email---------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-------------------User Name ------------
                  Text(
                    "Rakibul Hossain",
                    style: textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "rakibulpb6670@gmail.com",
                    style: textTheme.bodySmall!.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout, color: Colors.white),
        ),
      ],
    );
  }

  //------AppBar ke PreferenceWidget
  // ---------banale eta override korte hoy
  @override
  //-------------------kToolbarHeight holo default toolbar height -----------
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
