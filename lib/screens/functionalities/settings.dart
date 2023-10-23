import 'package:flutter/material.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:notemate/resources/firestore_methods.dart';
import 'package:notemate/screens/authentication/introduction_screen.dart';
import 'package:notemate/utils/colors.dart';
import 'package:notemate/widgets/delete_account_dialog.dart';
import 'package:notemate/widgets/reusedComponents/animation_transition.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = "1.0.0"; // default value

  @override
  void initState() {
    super.initState();
    //_fetchAppVersion();
  }

  // Future<void> _fetchAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _appVersion = packageInfo.version;
  //   });
  // }

  // final Uri url = Uri.parse('https://creatasy.de');
  // Future<void> _launchURL() async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Settings'),
            pinned: true,
            expandedHeight: 150.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              tooltip: 'Go Back',
              onPressed: () {
                Navigator.pushNamed(context, 'Home page');
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SettingsSection(name: 'About', children: [
                  ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: Color.fromARGB(255, 247, 235, 127),
                    ),
                    title: const Text(
                      'Help Center',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {
                      Navigator.of(context).pushNamed('Help Screen'),
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Color.fromARGB(255, 123, 237, 126),
                    ),
                    title: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {
                      Navigator.of(context).pushNamed('Privacy Policy'),
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.library_books,
                      color: Color.fromARGB(255, 152, 137, 249),
                    ),
                    title: const Text(
                      'Terms & Conditions',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {
                      Navigator.of(context).pushNamed('Terms & Conditions'),
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline,
                        color: Color.fromARGB(255, 247, 235, 127)),
                    title: const Text(
                      'App Version',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Version $_appVersion',
                      style: TextStyle(color: Colors.white),
                    ), // using the state variable here
                    enableFeedback: false,
                  ),
                ]),
                SettingsSection(
                  name: 'App Settings',
                  children: [
                    ListTile(
                      leading: const Icon(Icons.error_outline_outlined,
                          color: Colors.red),
                      title: const Text(
                        'Clear All Notes',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Careful! This Will Remove All Notes',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: (() async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are You Sure?'),
                              content:
                                  Text('This action will clear all notes.'),
                              icon: Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await FirestoreService().clearAllNotes();
                                    CustomSnackBarColored.show(
                                      context,
                                      'Deleted',
                                      'All Notes Deleted Successfully',
                                      const Duration(seconds: 3),
                                      CustomTheme.dangerColor,
                                    );
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                    ListTile(
                      leading: const Icon(Icons.error_outline_outlined,
                          color: Colors.red),
                      title: const Text(
                        'Delete Account',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      onTap: (() async {
                        Future.delayed(
                            Duration(seconds: 0),
                            (() => showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return deleteAccountDialog();
                                })));
                      }),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.logout_outlined, color: Colors.red),
                      title: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: (() async {
                        await AuthService().reloadUser();
                        await AuthService().signOut().then((value) {
                          if (value != null) {
                            CustomSnackBar.show(
                                context, value, Duration(seconds: 2));
                          }
                        });
                        FadeTrans(translateTo: IntroductionScreen());
                      }),
                    ),
                    // if (widget.isDynamicColorAvailable)
                    //   ListTile(
                    //     leading: const Icon(Icons.color_lens),
                    //     title: const Text('Use System Colors'),
                    //     trailing: Switch(
                    //       value: _useDynamicColors,
                    //       onChanged: (bool value) {
                    //         toggleDynamicColors(value);
                    //       },
                    //     ),
                    //     onTap: () {
                    //       toggleDynamicColors(
                    //  //          !_useDynamicColors); // toggle the value when the ListTile is tapped
                    //     },
                    //   ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

class SettingsSection extends StatelessWidget {
  final String name;
  final List<Widget> children;

  const SettingsSection({
    Key? key,
    required this.name,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(name,
                style: TextStyle(
                  color: CustomTheme.titleColor,
                ))),
        ...children,
      ],
    );
  }
}
