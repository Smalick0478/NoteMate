import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notemate/providers/admob_controller.dart';
import 'package:notemate/resources/auth_methods.dart';
import 'package:notemate/resources/firestore_methods.dart';
import 'package:notemate/screens/authentication/introduction_screen.dart';
import 'package:notemate/screens/functionalities/create_note.dart';
import 'package:notemate/widgets/delete_account_dialog.dart';
import 'package:notemate/widgets/notesRelated/notes_search.dart';
import 'package:notemate/widgets/reusedComponents/animation_transition.dart';
import 'package:notemate/widgets/foldersRelated/folders._tab.dart';
import 'package:notemate/widgets/notesRelated/notes_tab.dart';
import 'package:notemate/widgets/reusedComponents/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    admobcontroller.loadAd();
    super.initState();
  }

  final admobcontroller = Get.put(AdmobController());
  Future<Widget> _banner() async {
    await admobcontroller.bannerAd.value.dispose();
    await admobcontroller.loadBanner();

    return Container(
      alignment: Alignment.center,
      height: admobcontroller.bannerAd.value.size.height.toDouble(),
      width: admobcontroller.bannerAd.value.size.width.toDouble(),
      child: AdWidget(ad: admobcontroller.bannerAd.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15),
              child: FloatingActionButton(
                onPressed: () {
                  admobcontroller.interstitialAd?.show(); //!Interstital Ad Code
                  Navigator.of(context).push(FadeTrans(
                      translateTo: const CreateNote(),
                      duration: Duration(milliseconds: 800)));
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.add_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 20),
                    child: Text("NoteMate",
                        style: GoogleFonts.philosopher(fontSize: 30)),
                  ),
                  const Expanded(child: SizedBox()),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    itemBuilder: ((context) => [
                          // PopupMenuItem(
                          //   onTap: () async {
                          //     await FirestoreService().clearAllNotes();
                          //   },
                          //   value: 1,
                          //   child: const Text('Clear All notes'),
                          // ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(context, 'Search');
                            },
                            value: 1,
                            child: const Text('Search Notes'),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(context, 'Settings');
                            },
                            value: 1,
                            child: const Text('Settings'),
                          ),
                          // PopupMenuItem(
                          //     onTap: () async {
                          //       await AuthService().reloadUser();
                          //       await AuthService().signOut().then((value) {
                          //         if (value != null) {
                          //           CustomSnackBar.show(
                          //               context, value, Duration(seconds: 2));
                          //         }
                          //       });
                          //       FadeTrans(translateTo: IntroductionScreen());
                          //     },
                          //     value: 2,
                          //     child: const Text('Sign out')),
                          // PopupMenuItem(
                          //   onTap: () async {
                          //     Future.delayed(
                          //         Duration(seconds: 0),
                          //         (() => showDialog(
                          //             context: context,
                          //             builder: (dialogContext) {
                          //               return deleteAccountDialog();
                          //             })));
                          //   },
                          //   value: 3,
                          //   child: const Text(
                          //     'Delete Account',
                          //     style: TextStyle(
                          //         color: Colors.red,
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 5),
                      child: Icon(
                        Icons.more_horiz_outlined,
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              //!Banner Ad
              FutureBuilder(
                  future: _banner(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 50);
                    }
                    if (snapshot.data == null) {
                      return const SizedBox(height: 50);
                    }
                    return snapshot.data as Widget;
                  }),
              //!Banner Ad

              TabBar(
                //isScrollable: true,
                //labelColor: Colors.white,

                unselectedLabelColor: Colors.white54,
                controller: _tabController,
                splashFactory: NoSplash.splashFactory,

                tabs: [
                  Tab(
                    child: Text(
                      'All',
                      style: GoogleFonts.roboto(
                          letterSpacing: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Tab(
                      child: Text('Folder',
                          style: GoogleFonts.roboto(
                              letterSpacing: 1,
                              fontSize: 17,
                              fontWeight: FontWeight.w500))),
                ],
                indicator: MaterialIndicator(
                    color: Theme.of(context).tabBarTheme.labelColor!,
                    topLeftRadius: 2,
                    topRightRadius: 2,
                    horizontalPadding: 75),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: const [
                  NotesTab(),
                  FoldersTab(),
                ]),
              )
            ])));
  }
}
