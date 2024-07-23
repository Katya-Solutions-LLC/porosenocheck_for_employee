import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/app_scaffold.dart';
import '../../../utils/common_base.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.about,
      body: Column(
        children: [
          ListView.separated(
            itemCount: aboutPages.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (aboutPages[index].name.isEmpty || aboutPages[index].url.isEmpty) {
                return const SizedBox();
              } else {
                return SettingItemWidget(
                  title: aboutPages[index].name,
                  onTap: () {
                    commonLaunchUrl(aboutPages[index].url, launchMode: LaunchMode.externalApplication);
                  },
                  titleTextStyle: primaryTextStyle(),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  // leading: commonLeadingWid(imgPath: Assets.iconsIcLock, icon: Icons.lock_outline_sharp, color: primaryColor),
                );
              }
            },
            separatorBuilder: (context, index) => commonDivider,
          ),
        ],
      ),
    );
  }
}
/* 
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarBrightness: Brightness.light));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: 'About',
      body: AnimatedScrollView(
        crossAxisAlignment: CrossAxisAlignment.center,
        listAnimationType: ListAnimationType.FadeIn,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        children: [
          commonDivider,
          16.height,
          Text(APP_NAME, style: boldTextStyle(size: 20, color: context.primaryColor)),
          16.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(getStringAsync(ConfigurationKeyConst.SITE_DESCRIPTION), style: primaryTextStyle(), textAlign: TextAlign.justify),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (HELP_LINE_NUMBER.isNotEmpty)
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Image.asset(Assets.profileIconsIcCall, height: 22, color: context.primaryColor),
                      8.height,
                      Text(locale.value.call, style: secondaryTextStyle(), textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(
                  () {
                    launchCall(HELP_LINE_NUMBER);
                  },
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              if (INQUIRY_SUPPORT_EMAIL.isNotEmpty)
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Image.asset(Assets.profileIconsIcMessage, height: 22, color: primaryColor),
                      8.height,
                      Text(locale.value.email, style: secondaryTextStyle(), textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(
                  () {
                    launchMail(INQUIRY_SUPPORT_EMAIL);
                  },
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
            ],
          ),
          36.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(16),
                decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                child: Column(
                  children: [
                    Image.asset(Assets.profileIconsIcShare, height: 22, color: primaryColor),
                    8.height,
                    Text(locale.value.share, style: secondaryTextStyle(), textAlign: TextAlign.center),
                  ],
                ),
              ).onTap(
                () async {
                  if (isIOS) {
                    Share.share('${locale.value.share} $APP_NAME ${locale.value.app}\n\n$appStoreAppBaseURL');
                  } else {
                    Share.share('${locale.value.share} $APP_NAME ${locale.value.app}\n\n$playStoreBaseURL${await getPackageInfo().then((value) => value.packageName.validate())}');
                  }
                },
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ],
          ),
          36.height,
        ],
      ),
    );
  }
}
 */
