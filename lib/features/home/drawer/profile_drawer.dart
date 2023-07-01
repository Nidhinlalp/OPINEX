import 'package:redite_clone/features/privacy_polycy/screens/privacy.dart';
import 'package:redite_clone/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../auth/controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                user.profilePic,
              ),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              'u/${user.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text('Chnge theme'),
              leading: const Icon(Icons.change_circle),
              trailing: Switch.adaptive(
                value: ref.watch(themeNotifierProvider.notifier).mode ==
                    ThemeMode.dark,
                onChanged: (value) => toggleTheme(ref),
              ),
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              leading: const Icon(
                Icons.privacy_tip_outlined,
              ),
              onTap: () {
                Routemaster.of(context).push(PrivacyPolicyPage.routName);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(
                Icons.logout,
                color: Pallete.redColor,
              ),
              onTap: () => logOut(ref),
            )
          ],
        ),
      ),
    );
  }
}
