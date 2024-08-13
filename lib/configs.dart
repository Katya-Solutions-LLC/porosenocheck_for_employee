// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart';


const APP_NAME = 'Porosenocheck For Employee';
const DEFAULT_LANGUAGE = 'en';

///Live Url
const DOMAIN_URL = "https://apps.iqonic.design/pawlly";


const BASE_URL = '$DOMAIN_URL/api/';

const APP_PLAY_STORE_URL = '';
const APP_APPSTORE_URL = '';

const TERMS_CONDITION_URL = '$DOMAIN_URL/page/terms-conditions';
const PRIVACY_POLICY_URL = '$DOMAIN_URL/page/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'pitomec@rechain.email';
const DASHBOARD_AUTO_SLIDER_SECOND = 5;

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+79152568965';

///firebase configs
const FirebaseOptions firebaseConfig = FirebaseOptions(
  appId: "1:588768230555:android:3c63cf3f2a57a7708cda3e",
  apiKey: 'AIzaSyDSgPPS5TaQw4kLyTgbY7wb6Y3lYdLAjEE',
  projectId: 'porosenocheck-for-employee',
  messagingSenderId: '588768230555',
  storageBucket: 'porosenocheck-for-employee.appspot.com',
  iosBundleId: 'com.porosenocheck.employee',
);
