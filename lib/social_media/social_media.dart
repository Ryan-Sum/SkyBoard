import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/social_media/twitter_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  List<TwitterAccount> accounts = [
    TwitterAccount("https://twitter.com/CollegeBoard", "College Board"),
    TwitterAccount("https://twitter.com/ACT", "ACT"),
    TwitterAccount("https://twitter.com/OfficialSAT", "SAT"),
    TwitterAccount(
        "https://twitter.com/USNewsEducation", "U.S. News Education"),
    TwitterAccount("https://twitter.com/FAFSA", "FAFSA"),
    TwitterAccount("https://twitter.com/MyBigFuture", "BigFuture"),
    TwitterAccount("https://twitter.com/CommonApp", "Common App")
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0x00000000).withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 19,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: AnimateGradient(
                primaryBegin: const Alignment(1, 0),
                primaryEnd: const Alignment(2, 0),
                secondaryBegin: const Alignment(0, 1),
                secondaryEnd: const Alignment(0, 2),
                primaryColors: const [
                  Color(0xffdd1f66),
                  Color(0xFFE6AC4A),
                  Color(0xff20c5dd),
                ],
                secondaryColors: const [
                  Color(0xffdd1f66),
                  Color(0xff20c5dd),
                  Color(0xFFE6AC4A),
                ],
                duration: const Duration(seconds: 20),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 128, 32, 16),
                  child: Text(
                      "Here are some important accounts to monitor while applying:",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          final Set<Factory<OneSequenceGestureRecognizer>>
                              gestureRecognizers = {
                            Factory(() => EagerGestureRecognizer())
                          };
                          final WebViewController controllerTwitter =
                              WebViewController()
                                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                ..setBackgroundColor(const Color(0x00000000))
                                ..setNavigationDelegate(NavigationDelegate())
                                ..loadRequest(Uri.parse(accounts[index].url));
                          return Scaffold(
                            appBar: CustomAppBar(),
                            body: WebViewWidget(
                              controller: controllerTwitter,
                              gestureRecognizers: gestureRecognizers,
                            ),
                          );
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x00000000).withOpacity(0.09),
                            offset: const Offset(0, 0),
                            blurRadius: 19,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(accounts[index].orgName),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
