class StringRes {
  StringRes._init();

  // language
  static const String kLangCodeBN = "bn";
  static const String kLangCountryBD = "BD";
  static const String kLangCodeEN = "en";
  static const String kLangCountryUS = "US";

  static const kClusterSystemAdmission = 'header_cluster_admission_system';
  static const kIdPasswordReset = 'ID/PASSWORD RESET';

  // drawer sub item
  static const kPrimaryEligibilityCheck = 'common_primary_eligibility_check';
  static const kRegistration = 'common_registration';
  static const kAdmidCardDownload = 'common_admit_card_download';
  static const kAdmissionTest = 'common_admission_notice';
  static const kResult = 'common_result';
  static const kAdmission = 'common_admission';

  // drawer item
  static const kDrawerNameNotice = 'common_notice';
  static const kDrawerNameHome = 'common_home';
  static const kDrawerNameInstructions = 'Instruction';
  static const kDrawerNameRevisedDate = 'common_revised_date';
  static const kDrawerSignIn = 'common_sign_in';
  static const kDrawerSignOut = 'common_sign_out';

  // drawer icon
  static const kDrawerNoticeIcon = 'assets/icons/drawer_notice.svg';
  static const kDrawerHomeIcon = 'assets/icons/homeicon.svg';
  static const kDrawerRevisedDateIcon = 'assets/icons/drawer_revised_date.svg';
  static const kDrawerSignInIcon = 'assets/icons/drawer_sign_in.svg';
  static const kDrawerInstructionIcon = 'assets/icons/drawer_instruction.svg';

  // primary eligibility success
  static const kIconInfoSuccess = 'assets/icons/info_success.svg';
  static const kIconInfoEmail = 'assets/icons/info_email.svg';
  static const kIconInfoMobile = 'assets/icons/info_mobile.svg';
  static const kIconInfoFailed = 'assets/icons/info_failed.svg';

  // admission step
  static const kEligibilityGuideText =
      'Check your primary eligibility to start\nthe registration process.\nDeadline: Sepetmber 01';
  static const kRegisrationGuideText =
      'Sign up -> Sign in -> Form fill-up ->\nPayment\nDeadline: Sepetmber 01';
  static const kAdmidCardDownlaodGuideText =
      'After completing registration,\nyou will be notified when admit card is available\nto download';
  static const kAdmissionTestGuideText =
      'Admission test will take place on\nSeptember 24. If date changes you\nwill be notified';
  static const kResultGuideText =
      'You’ll get result through app, mobile\nSMS and email ';
  static const kAdmissionGuideText =
      'You’ll get admission related info and\ninstructions through app, mobile SMS\nand email ';

  // images
  static const kImgPathAppBg = 'assets/images/app_bg.png';
  static const kImgPathSignInBg = 'assets/images/sign_in_bg.png';
  static const kImgPathLanding = 'assets/images/landing.png';
  static const kImagePathTitleEn = 'assets/images/title_en.png';
  static const kImagePathTitleBn = 'assets/images/title_bn.png';
  static const String kNoUserCreated = "No user has been created yet";
}

// message form code
final Map<String, String> messageEnFromCode = {
  'C1001': 'No data found',
  'C1002': 'Successfully found consignment carrier list',
  'C1003': 'Not found consignment carrier list or any data',
  'C1004': 'No country information found',
  'C1005': 'Successfully found country list',
  'C1006': 'Not found any country in list',
  'C1007': 'No district information found by division',
  'C1008': 'Successfully found district list by division ',
  'C1009': 'Not found any district by division',
  'C1010': 'No district information foun ',
  'C1011': 'An exception occurred while requesting district list:',
  'C1012': 'No division information found',
  'C1013': 'An exception occurred while getting user data list for count data',
  'C1014': 'Succesfully Found division list',
  'C1015': 'Not found division in list',
  'C1016': 'No hub information found by thana',
  'C1017': 'Successfully found hub list by thana',
  'C1018': 'An exception occurred while requesting hub list by thana ',
  'C1019': 'No hub information found',
  'C1020': 'Successfully found hub list ',
  'C1021': 'An exception occurred while requesting hub lis ',
  'C1022': 'No item category information found',
  'C1023': 'Successfully found item category',
  'C1024': 'An exception occurred while requesting item category ',
  'C1025': 'No item group list found by category',
  'C1026': 'Successfully item group list by category',
  'C1027':
      'An exception occurred while requesting item group list found by category',
  'C1028': 'No item group list found ',
  'C1029': 'Successfully found item group',
  'C1030': 'An exception occurred while requesting item group list found ',
  'C1031': 'No lot type list found',
  'C1032': 'Successfully found lot type',
  'C1033': 'An exception occurred while requesting lot type list found',
  'C1034': 'No measurement type information found',
  'C1035': 'Successfully measurement type found',
  'C1036': 'An exception occurred while requesting measurement type:',
  'C1037': 'No package type list found',
  'C1038': 'Successfully found package type in list',
  'C1039': 'An exception occurred while requesting package type list found ',
  'C1040': 'Successfully Save & Update Pickup Location',
  'C1041': 'An exception occurred while requesting pickup location with insert',
  'C1042': 'An exception occurred while requesting update profile information',
  'C1043': 'An exception occurred while requesting update profile information',
  'C1044': 'An exception occurred while sign up user',
  'C1045': 'No post office information found by district',
  'C1046': 'Successfully found post office list by district',
  'C1047':
      'An exception occurred while requesting post office list by district',
  'C1048': 'No request type information found',
  'C1049': 'Successfully found request type',
  'C1050': 'An exception occurred while requesting request type',
  'C1051': 'No service type found',
  'C1052': 'Successfully found service type list',
  'C1053': 'An exception occurred while requesting service type',
  'C1054': 'No thana information found by district',
  'C1055': 'Successfully fund thana list by district',
  'C1056': 'An exception occurred while requesting thana list by district',
  'C1057': 'An exception occurred while getting thana data list for count data',
  'C1058': 'No unit of measurement information found by measurement type',
  'C1059': 'Successfully found unit measurement list by measurement type ',
  'C1060':
      'An exception occurred while requesting unit of measurement information by measurement type',
  'C1061': 'No unit of measurement information found',
  'C1062': 'Successfully found unit measurement',
  'C1063':
      'An exception occurred while requesting unit of measurement information by measurement type',
  'C1064': 'Successfully Save & Update Pickup Location',
  'C1065': 'User request not valid to update pickup loaction',
  'C1066': 'An exception occurred while requesting update profile information',
  'C1067': 'An exception occurred while insert user pickup location',
  'C1068': 'An exception occurred while insert user pickup location',
  'C1069': 'Successfully Update Profile Information',
  'C1070': 'No profile information found',
  'C1071': 'An exception occurred while requesting update sign up data ',
  'C1072': 'An exception occurred while requesting update login data',
  'C1073': 'No weight charge found by requested weight and unit measurement',
  'C1074': 'Successfully found weight by requested weight ',
  'C1075':
      'An exception occurred while requesting weight charge by requested weight and unit measurement ',
  'C1076': 'No weight range list information found by unit measurement ',
  'C1077':
      'An exception occurred while requesting weight range list information by unit measurement ',
  'C1078': 'No weight range list found',
  'C1079': 'Successfully found weight range list',
  'C1080': 'An exception occurred while requesting weight range list found',
  'C1081': 'Password didn\'t match',
  'C1082': 'No User found',
  'C1083': 'Old password is wrong',
  'C1084': 'Internel error',
  'C1085': 'An exception occurred while requesting for get user info',
  'C1086': 'An exception occurred while requesting update password',
  'C1087': 'Password didn\'t match',
  'C1088': 'No User found',
  'C1089': 'Wrong OTP information',
  'C1090': 'Password reset successfully',
  'C1091': 'Internel error',
  'C1092': 'An exception occurred while requesting login information',
  'C1093': 'No User found',
  'C1094': 'Wrong OTP',
  'C1095': 'OTP Expired',
  'C1096': 'Internel error',
  'C1097': 'An exception occurred while requesting login information',
  'C1098': 'An exception occurred while requesting OTP information',
  'C1099': 'An exception occurred while requesting update OTP information',
  'C1100': 'Unable to send OTP',
  'C1101': 'OTP sent successfully',
  'C1102': 'An exception occurred while requesting login information',
  'C1103': 'An exception occurred while requesting for save OTP information ',
  'C1104': 'No found User',
  'C1105': 'No user found',
  'C1106': 'Password does not matched',
  'C1107': 'User is not active',
  'C1108': 'An exception occurred while requesting login and role information',
  'C1109': 'An exception occurred while inserting login log',
  'C1110': 'Successfully signout',
  'C1111': 'An exception occurred while updating login log ',
  'C1112': 'This mobile Number is already exists..',
  'C1113': 'This email already exists',
  'C1114': 'Sign up successfully completed',
  'C1115': 'Sign up not successfully completed',
  'C1116': 'An exception occurred while getting unauth user',
  'C1117': 'An exception occurred while getting unauth email',
  'C1118': 'An exception occurred while requesting cn request data count:',
  'C1119': 'An exception occurred while sign up user',
  'C1120': 'An exception occurred while sign up user pickup location',
  'C1121': 'Successfully Update Profile Information',
  'C1122': 'An exception occurred while requesting update profile information',
  'C1123': 'An exception occurred while requesting update profile information',
  'C1124': 'No Profile information found',
  'C1125': 'An exception occurred while requesting Profile information',
  'C1126': 'Pickup location not found',
  'C1127':
      'An exception occurred while requesting for pickup location information',
  'C1128': 'Successfully payment details by order',
  'C1129': 'No payment update detail information found',
  'C1130':
      'An exception occurred while requesting for payment detail information',
  'C1131': 'An exception occurred while requesting payment update information',
  'C1132': 'An exception occurred while counting total payment amount',
  'C1133': 'An exception occurred while counting total payment amount',
  'C1134': 'Successfully consignment request data saved.',
  'C1135': 'The consignment request data not saved.',
  'C1136': 'An exception occurred while requesting cn request data count:',
  'C1137': 'An exception occurred while requesting cn request data count:',
  'C1138': 'Total lot charge is not count',
  'C1139': 'Successfully consignment request data saved.',
  'C1140': 'The consignment request data not saved.',
  'C1141':
      'An exception occurred while requesting consignment request data count',
  'C1142': 'Total lot charge is not count',
  'C1143':
      'An exception occurred while requesting consignment request data count',
  'C1144': 'Successfully courier update details by order',
  'C1145': 'No courier update detail found',
  'C1146':
      'An exception occurred while requesting courier update detail information',
  'C1147': 'An exception occurred while requesting courier update information',
  'C1148': 'An exception occurred while counting total courier amount',
  'C1149': 'An exception occurred while counting total pending payment amount',
  'C1150': 'An exception occurred while counting total Failed payment amount',
  'C1151': 'Unable to upload file',
  'C1152': 'An exception occurred while storing file',
  'C1153': 'No consignment carrier list found',
  'C1154':
      'An exception occurred while requesting consignment carrier list found',
  'C1155': 'Successfully challan data updated.',
  'C1156': 'No challan data found by this challan id.',
  'C1157': 'No challan data found by this challan id.',
  'C1158': 'An exception occurred while getting challan id.',
  'C1159': 'An exception occurred while updating challan information.',
  'C1160': 'An exception occurred while updating challan information.',
  'C1161': 'No employee information found by user id',
  'C1162': 'An exception occurred while requesting agent by user.',
  'C1163': 'An exception occurred while requesting courier update information.',
  'C1164': 'Successfully payment details by order.',
  'C1165': 'No payment update detail information found',
  'C1166':
      'An exception occurred while requesting for payment detail information',
  'C1167': 'An exception occurred while requesting payment update information',
  'C1168': 'An exception occurred while counting total payment amount',
  'C1169': 'An exception occurred while counting total payment amount: ',
  'C1170': 'Successfully consignment request data saved.',
  'C1171': 'The consignment request data not saved.',
  'C1172':
      'An exception occurred while requesting consignment request data count',
  'C1173':
      'An exception occurred while requesting consignment request data count',
  'C1174': 'Successfully consignment request data saved.',
  'C1175': 'No consignment request found',
  'C1176': 'An exception occurred while requesting for sender data',
  'C1177': 'No consignment request found',
  'C1178': 'An exception occurred while requesting for receiver data',
  'C1179':
      'An exception occurred while requesting consignment request tracking data count',
  'C1180':
      'An exception occurred while tracking insert consignment request execute',
  'C1181': 'An exception occurred while challan information tracking execute',
  'C1182':
      'An exception occurred while requesting consignment challan data count',
  'C1183': 'No consignment list to send to carrier',
  'C1184': 'Successfully found consignment list to send to carrier by order',
  'C1185': 'An exception occurred while fetching consignment request',
  'C1186': 'An exception occurred while fetching consignment request',
  'C1187': 'Successfully consignment request data updated',
  'C1188': 'No consignment data found by this consignment request',
  'C1189': 'No consignment data found by this consignment request',
  'C1190': 'An exception occurred while requesting for consignment  ',
  'C1191': 'An exception occurred while requesting update profile information',
  'C1192':
      'An exception occurred while requesting update Payment status information',
  'C1193':
      'An exception occurred while requesting update lot status information',
  'C1194': 'An exception occurred while requesting update sender information',
  'C1195': 'An exception occurred while requesting update receiver information',
  'C1196': 'Successfully Uploaded Challan',
  'C1197': 'No challan information found',
  'C1198': 'An exception occurred while requesting for Upload Sender Invoice',
  'C1199': 'Successfully courier update details by order',
  'C1200': 'No courier update detail found',
  'C1201':
      'An exception occurred while requesting courier update detail information',
  'C1202': 'An exception occurred while requesting courier update information',
  'C1203': 'An exception occurred while counting total courier amount',
  'C1204': 'An exception occurred while counting total pending payment amount',
  'C1205': 'An exception occurred while counting total Failed payment amount',
  'C1206': 'Unable to upload file',
  'C1207': 'No courier consignment request information found',
  'C1208': 'Fail to fetch courier consignment request data while execute',
  'C1209': 'An exception occurred while executing consignment information',
  'C1210': 'An exception occurred while executing consignment lot information ',
  'C1211':
      'An exception occurred while executing consignment payment information',
  'C1212':
      'Successfully updated consignment lot request data under consignment request ',
  'C1213':
      'No lot information data found to update consignment lot information',
  'C1214': 'Fail to fetch courier consignment request data while execute',
  'C1215':
      'An exception occurred while requesting update lot information query execute',
  'C1216':
      'An exception occurred while requesting update lot information query execute',
  'C1217': 'Successfully payment status updated to paid',
  'C1218': 'No data found',
  'C1219': 'An exception occurred while requesting login information',
  'C1220': 'No information found',
  'C1221': 'No details information found',
  'C1222': 'Successfully found specific information of Lot by request ',
  'C1223': 'Action failed due to an error',
  'C1224': 'An exception occurred while requesting login information',
  'C1225': 'An exception occurred while requesting login information',
  'C1226': 'An exception occurred while getting sender agent id',
  'C1227': 'An exception occurred while getting sender hub id',
};
