import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      actions: const [
        Icon(Icons.more_vert_rounded),
        SizedBox(width: 8,)
      ],
      leading: Icon(Icons.menu_rounded),

      title: Text(
        "Helply",
        style: GoogleFonts.bricolageGrotesque(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF313131),
        ),
      ),
      elevation: 0,

      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
