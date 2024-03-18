import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:understudy_app/components/my_text_button.dart';
import 'package:understudy_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            print('Profile image tapped');
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            child: Icon(
              Icons.person_outline_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: SvgPicture.asset('assets/logos/understudy_logo.svg', width: MediaQuery.of(context).size.width / 3),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating button tapped');
          _showUploadOptionsModal(context);
        },
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add_circle_outline,
          size: 50,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Theme.of(context).colorScheme.tertiary, // Set the background color here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildBottomBarItem(
                icon: Icon(Icons.home, color: currentPageIndex == 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5), size: 30),
                label: 'home',
                index: 0),
            buildBottomBarItem(
                icon: Icon(Icons.receipt_long, color: currentPageIndex == 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5), size: 30),
                label: 'scenes',
                index: 1),
            const SizedBox(width: 30), // Placeholder for the FloatingActionButton
            buildBottomBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/blog_icon.svg",
                  height: 30,
                  color: currentPageIndex == 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                label: 'blog',
                index: 2),
            buildBottomBarItem(
                icon: Icon(Icons.settings, color: currentPageIndex == 3 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5), size: 30),
                label: 'settings',
                index: 3),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TEST - YOU'RE IN",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextButton(
                buttonText: 'Sign Out',
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
                padding: 12,
                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBarItem({required Widget icon, required String label, required int index}) {
    final color = currentPageIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5);

    return Expanded(
      // Use Expanded to evenly distribute space among items.
      child: TextButton(
        onPressed: () => setState(() => currentPageIndex = index),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // Reduces default padding
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimal space
          children: [
            Padding(padding: const EdgeInsets.only(bottom: 5.0), child: icon),
            Text(label, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void _showUploadOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildUploadOption(
                  context: context,
                  label: 'upload pdf',
                  imagePath: 'assets/background/upload_scene.png',
                  onTap: () => {print('upload pdf pressed'), Navigator.of(context).pop()},
                ),
                _buildUploadOption(
                  context: context,
                  label: 'scan script',
                  imagePath: 'assets/background/scan_script.png',
                  onTap: () => {print('scan script pressed'), Navigator.of(context).pop()},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadOption({
    required BuildContext context,
    required String label,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
