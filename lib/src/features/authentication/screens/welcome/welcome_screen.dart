import 'package:babi_cakes_mobile/src/service/global_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/constants/sizes.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/signup/signup_screen.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';
import '../../../../utils/animations/fade_in_animation/animation_design.dart';
import '../../../../utils/animations/fade_in_animation/fade_in_animation_controller.dart';
import '../../../../utils/animations/fade_in_animation/fade_in_animation_model.dart';
import '../login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late bool isShowWelcome = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _redirectWelcomeToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.animationIn();
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: tPrimaryColor,
        body: Stack(
          children: [
            TFadeInAnimation(
              durationInMs: 1200,
              animate: TAnimatePosition(
                bottomAfter: 0,
                bottomBefore: -100,
                leftBefore: 0,
                leftAfter: 0,
                topAfter: 0,
                topBefore: 0,
                rightAfter: 0,
                rightBefore: 0,
              ),
              child: isShowWelcome ? Container(
                padding: const EdgeInsets.all(tDefaultSize),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Hero(
                                tag: 'welcome-image-tag',
                                child: Image(
                                    image: const AssetImage(tSplashImage),
                                    height: height * 0.6)),
                            Column(
                              children: [
                                Text(tWelcomeTitle,
                                    style: Theme.of(context).textTheme.headline2),
                                Text(tWelcomeSubTitle,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => Get.to(() => const LoginScreen()),
                                    child: Text(tLogin.toUpperCase()),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => Get.to(() => const SignUpScreen()),
                                    child: Text(tSignup.toUpperCase()),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                    ),
                  ],
                ),
              ) : Container(),
            ),
          ],
        ),
      ),
    );
  }

  _redirectWelcomeToDashboard() {
    GlobalService.getWelcome().then((value) => {
      if(value) {
        Get.to(() => const LoginScreen())
      }
    });

    GlobalService.saveWelcome();
  }
}
