import 'package:get/get.dart';

var selectedLanguage = english;

var english = "English";
var marathi = "Marathi";
var hindi = "Hindi";

/// for the Obsecure Value

bool password = true;

class LocalLanguageString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ///English.tr
        'en_US': {
          ///RegistrationForm Keys
          "rTitle": "Registration",
          "nameHint": "Full Name",
          "mobileHint": "Mobile Number (N.E.)",
          "emailHint": "Email ID",
          "genderText": "Gender",
          "maleRadioText": "Male",
          "femaleRadioText": "Female",
          "addressHint": "Address",
          "cityHint": "City",
          "villageHint": "Village",
          "grampanchayatHint": "Grampanchayat",
          "rButton": "Register",
          "existAccountText": "Already have an account?",

          ///Register Screen to get Otp Keys
          "login": "Login",
          "otpMessage": "We will send you One Time Password(OTP)",
          "mobileLable": "Mobile Number",
          "mobileHintText": "Enter Mobile Number",
          "getOtp": "Get OTP",
          "pasteTitle": "Paste Code",
          "pasteContent": "Do you want to paste code",

          ///Otp Verification  Keys
          "otp": "OTP",
          "ovMessage": "We have sent OTP on your number.",
          "otpNotReceivedText": "Didn\'t receive OTP?",
          "resendText": "Resend OTP",

          ///choose language Dialog Keys
          "english": "English",
          "marathi": "Marathi",
          "hindi": "Hindi",
          "chooseLanguage": "Choose Language",

          ///DashboardScreen Keys
          "projectTitle": "GRAM SUVIDHA",
          "gram": "GRAM",
          "suvidha": "SUVIDHA",
          "welcome": "Welcome",
          "enquiry_service": "Enquiry/Service",
          "request": "Request",
          "decision_proceedings": "Decisions &\nProceedings",
          "complaints": "Complaints",
          "addFamilyMember": "Add Family\nMember",
          "downloads": "Downloads",
          "myProfile": "My\nProfile",
          "grampachayatActivities": "Grampachayat Activities",
          "like": "Like",
          "comment": "Comment",
          "share": "Share",
          "loaderWaitText": "Please wait",

          ///Post Detail Screen Keys
          "postDetailAppBarTitle": "Post Details",
          "ediComment": "Edit comment",
          "enterCommentHint": "Enter comment",
          "deleteCommentTitle": "Do you want to delete this comment?",
          "commentLikeText": "People likes this",
          "noCommentMsg": "No comment Found!",

          ///Profile screen keys
          "profileAppBarTitle": "Profile",
          "updateProfileAppBarTitle": "Update Profile",
          "fullNameHint": "Please enter full name",
          "mobileText": "Please enter mobile number",
          "emailHintText": "Please enter emailId",
          "addressHintText": "Please enter address",

          ///Activity form keys
          "title": "Title",
          "description": "Description",
          "desHint": "Please enter description",
          "addPhotoBtn": "Add Photos",
          "activityAppBarTitle": "Post",
          "postBtn": "POST",
          "updateBtn": "UPDATE",
          "notificationAppBarText": "Notification",

          ///Activity form image delete popup keys
          "deleteTitle": "Delete Attachment",
          "contentTitle": "Do you want to delete attachment?",
          "cancelBtn": "Cancel",
          "okBtn": "Ok",

          ///Work history page keys
          "appBarTitle": "My Posts",
          "editBtn": "Edit",
          "deleteBtn": "Delete",
          "alert": "Alert",
          "popupContentTitle": "Do you want to delete this post?",

          ///Drawer Keys
          "home": "Home",
          "kyc": "KYC",
          "essentialSevicess": "Essential Services contacts",
          "gramPanchayatBodyInfo": "Gram panchayat Body Info",
          "shareLink": "Share app link",
          "activities": "Activities",
          "changeLanguage": "Change Language",
          "logout": "Logout",

          ///Logout Dialog Keys
          "logoutConfirmMessage": "Do you want to logout ?",
          "exitAppMsg": "Do you want to exit the app ?",
          "exitAppTitle": "Exit App",
          "yes": "YES",
          "no": "NO",

          ///Enquiry & Complain ServiceRequest Keys
          "typeOfEnquiry": "Type of Enquiry:",
          "typeOfComplain": "Types of Complaints:",
          "enquiryText": "Enquiry Text:",
          "status": "Status:",
          "date": "Date",
          "addEnquiry": "Add Enquiry",
          "addComplain": "Add Complaint",

          ///Enquire & Complain Form Keys
          "enquiryForm": "Enquiry Form",
          "complaintForm": "Complaints Form",
          "complainText": "Complaints Text",
          "location": "Location,",
          "listofAttachment": "List of Attachment",
          "choosePhoto": "Choose Photo",
          "submit": "Submit",

          ///Decisions and Proceedings Keys
          "decision_proceedings_title": "Decisions and Proceedings",

          ///Add Family Member Keys
          "addFamilyMemberTitle": "Add Family Member",
          "addUser": "Add User",

          ///Add User Keys
          "userName": "User Name",
          "userContact": "User Contact Number",
          "rollOfUser": "Roll Of User",
          "kycDocs": "KYC Documents",
          "docsName": "Document Name",

          ///Profile Keys
          "profile": "Profile",
          "city": "City:",
          "village": "Village:",

          ///Essential Service Keys
          "essentialServiceTitle": "Essential Service",

          ///Grampanchayat Body Information Keys
          "grampanchayatBodyInfoTitle": "Grampanchayat Body Information",

          ///Share App Keys
          "shareAppTitle": "Share app",
          "faceBook": "Facebook",
          "email": "Email",
          "whatsapp": "Whatsapp",
          "sms": "SMS",

          ///SnackBar messages Keys
          "copySnackBarMessage": "Copied to your clipboard !",
          "exitSnackBarMessage": "Press again to exit",
          "resendOtpSnackBarMsg": "Otp sent on your mobile",
          "loginSnackBarMsg": "Login Successful",
          "invalidOtpSnackBarMsg": "Please Enter Valid OTP",
          "invalidMobileSnackBarMsg": "Please Enter Registered Mobile\nNumber",
          "emptyMobileSnackBarMsg": "Enter Mobile Number",
          "emptyOtpSnackBarMsg": "Please Enter OTP",
          "logoutSnackBarMsg": "App Logout Successfull!",
          "postUpdateMsg": "Post Updated Successfully.",

          ///Update profile snack-bar keys
          "emptyName": "Please enter full name",
          "emptyEmail": "Please enter valid email",
          "emptyImage": "Please Select the Image to upload",
          "emptyMobile": "Please enter valid mobile number",

          ///Activity form snack-bar keys
          "emptyTitle": "Please enter title",
          "emptyDescription": "Please enter description",
          "exceedImageMsg": "Limit is reached!",
          "postSaveMsg": "Data saved successfully",

          ///comment add and delete msg keys
          "cmtStatus": "Status:",
          "cmtDeleteMsg": "Comment deleted successfully",
          "cmtAddedMsg": "Comment added successfully.",
          "emptyCommentTitle": "Message",
          "emptyCommentMsg": "Please enter the comment",
          "commentUpdateMsg": "Comment updated successfully",
          "postDeleteMsg": "Post Deleted Successfully",
          "postDeleteErrorMsg": "You can not delete this activity",
          "profileUpdateMsg": "Profile Updated Successfully!",
        },

        ///Marathi.tr
        'mr_IN': {
          ///RegistrationForm Keys
          "rTitle": "नोंदणी",
          "nameHint": "पूर्ण नाव",
          "mobileHint": "मोबाईल नंबर (एन.ई)",
          "emailHint": "ईमेल आयडी",
          "genderText": "लिंग",
          "maleRadioText": "पुरुष",
          "femaleRadioText": "महिला",
          "addressHint": "पत्ता",
          "cityHint": "शहर",
          "villageHint": "गाव",
          "grampanchayatHint": "ग्रामपंचायत",
          "rButton": "नोंदणी करा",
          "existAccountText": "आधीच खाते आहे?",

          ///Register Screen to get Otp Keys
          "login": "लॉगिन",
          "otpMessage": "आम्ही तुम्हाला वन टाइम पासवर्ड (OTP) पाठवू",
          "mobileLable": "मोबाईल नंबर",
          "mobileHintText": "मोबाईल नंबर टाका",
          "getOtp": "ओटीपी मिळवा",
          "pasteTitle": "पेस्ट कोड",
          "pasteContent": "तुम्हाला कोड पेस्ट करायचा आहे",

          ///Otp Verification  Keys
          "otp": "ओटीपी",
          "ovMessage": "आम्ही तुमच्या नंबरवर OTP पाठवला आहे.",
          "otpNotReceivedText": "OTP प्राप्त झाला नाही?",
          "resendText": "OTP पुन्हा पाठवा",

          ///choose language Dialog keys
          "english": "इंग्रजी",
          "marathi": "मराठी",
          "hindi": "हिंदी",
          "chooseLanguage": "भाषा निवडा",

          ///DashboardScreen keys
          "projectTitle": "ग्राम सुविधा",
          "gram": "ग्राम",
          "suvidha": "सुविधा",
          "welcome": "स्वागत",
          "enquiry_service": "चौकशी / सेवा",
          "request": "विनंती",
          "decision_proceedings": "निर्णय आणि\n कार्यवाही",
          "complaints": "तक्रारी",
          "addFamilyMember": "कुटुंब सदस्य\n जोडा",
          "downloads": "डाउनलोड",
          "myProfile": "माझे\nप्रोफाइल",
          "grampachayatActivities": "ग्रामपंचायत उपक्रम",
          "like": "लाइक",
          "comment": "कमेंट्स",
          "share": "शेअर",
          "loaderWaitText": "कृपया थांबा",

          ///Post Detail Screen Keys
          "postDetailAppBarTitle": "पोस्ट तपशील",
          "ediComment": "कंमेंट संपादित करा",
          "enterCommentHint": "कंमेंट प्रविष्ट करा",
          "deleteCommentTitle": "तुम्हाला ही कंमेंट हटवायची आहे का?",
          "commentLikeText": "लोकांना हे आवडले",
          "noCommentMsg": "एकही कंमेंट आढळली नाही!",

          ///Profile screen keys
          "profileAppBarTitle": "प्रोफाइल",
          "updateProfileAppBarTitle": "अपडेट प्रोफाइल",
          "fullNameHint": "कृपया पूर्ण नाव प्रविष्ट करा",
          "mobileText": "कृपया मोबाईल नंबर प्रविष्ट करा",
          "emailHintText": "कृपया ईमेल आयडी प्रविष्ट करा",
          "addressHintText": "कृपया पत्ता प्रविष्ट करा",

          ///Activity form keys
          "title": "शीर्षक",
          "description": "वर्णन",
          "desHint": "कृपया वर्णन प्रविष्ट करा",
          "addPhotoBtn": "फोटो जोडा",
          "activityAppBarTitle": "पोस्ट",
          "postBtn": "पोस्ट",
          "updateBtn": "अपडेट करा",
          "notificationAppBarText": "सूचना",

          ///Activity form image delete popup keys
          "deleteTitle": "संलग्नक हटवा",
          "contentTitle": "तुम्हाला संलग्नक हटवायचे आहे का?",
          "cancelBtn": "रद्द करा",
          "okBtn": "ठीक",

          ///Work history page keys
          "appBarTitle": "माझ्या पोस्ट",
          "editBtn": "संपादित करा",
          "deleteBtn": "हटवा",
          "alert": "अलर्ट",
          "popupContentTitle": "तुम्हाला ही पोस्ट हटवायची आहे का?",

          ///Drawer keys
          "home": "मुख्यपृष्ठ",
          "kyc": "केवायसी",
          "essentialSevicess": "अत्यावश्यक सेवा संपर्क",
          "gramPanchayatBodyInfo": "ग्रामपंचायतींची माहिती",
          "shareLink": "ॲप लिंक शेअर करा",
          "activities": "उपक्रम",
          "changeLanguage": "भाषा बदला",
          "logout": "लॉगआउट",

          ///Logout Dialog Keys
          "logoutConfirmMessage": "तुम्हाला लॉगआउट करायचे आहे का ?",
          "exitAppMsg": "तुम्हाला ॲपमधून बाहेर पडायचे आहे का",
          "exitAppTitle": "ॲपमधून बाहेर पडा",
          "yes": "होय",
          "no": "नाही",

          ///Enquiry & Complain ServiceRequest Keys
          "typeOfEnquiry": "चौकशीचा प्रकार:",
          "typeOfComplain": "तक्रारींचे प्रकार:",
          "enquiryText": "चौकशी मजकूर:",
          "status": "स्थिती:",
          "date": "तारीख",
          "addEnquiry": "चौकशी जोडा",
          "addComplain": "तक्रार जोडा",

          ///Enquire & Complain Form Keys
          "enquiryForm": "चौकशी फॉर्म",
          "complaintForm": "तक्रार फॉर्म",
          "complainText": "तक्रार मजकूर",
          "location": "स्थान",
          "listofAttachment": "संलग्न यादी",
          "choosePhoto": "फोटो निवडा",
          "submit": "जतन करा",

          ///Decisions and Proceedings keys
          "decision_proceedings_title": "निर्णय आणि कार्यवाही",

          ///Add Family Member Keys
          "addFamilyMemberTitle": "कुटुंब सदस्य जोडा",
          "addUser": "यूजर जोडा",

          ///Add User Keys
          "userName": "नाव",
          "userContact": "मोबाईल नंबर",
          "rollOfUser": "यूजर रोल",
          "kycDocs": "केवायसी कागदपत्रे",
          "docsName": "कागदपत्राचे नाव",

          ///Profile Keys
          "profile": "प्रोफाइल",
          "city": "शहर:",
          "village": "गाव:",

          ///Essential Service Keys
          "essentialServiceTitle": "आवश्यक सेवा",

          ///Grampanchayat Body Information Keys
          "grampanchayatBodyInfoTitle": "ग्रामपंचायत निगम माहिती",

          ///Share App Keys
          "shareAppTitle": "शेअर ॲप",
          "faceBook": "फेसबुक",
          "email": "ईमेल",
          "whatsapp": "व्हॉट्सॲप",
          "sms": "एसएमएस",

          ///SnackBar messages Keys
          "copySnackBarMessage": "तुमच्या क्लिपबोर्डवर कॉपी केले !",
          "exitSnackBarMessage": "बाहेर पडण्यासाठी पुन्हा दाबा",
          "resendOtpSnackBarMsg": "ओटीपी तुमच्या मोबाईलवर पाठवला",
          "loginSnackBarMsg": "यशस्वीरित्या लॉग इन केले आहे",
          "invalidOtpSnackBarMsg": "कृपया वैध ओटीपी प्रविष्ट करा",
          "invalidMobileSnackBarMsg":
              "कृपया नोंदणीकृत मोबाईल क्रमांक प्रविष्ट करा",
          "emptyMobileSnackBarMsg": "मोबाईल नंबर प्रविष्ट करा",
          "emptyOtpSnackBarMsg": "कृपया ओटीपी प्रविष्ट करा",
          "logoutSnackBarMsg": "ॲप लॉगआउट यशस्वी!",
          "postUpdateMsg": "पोस्ट यशस्वीरित्या अपडेट केली आहे.",

          ///Update profile snack-bar keys
          "emptyName": "कृपया पूर्ण नाव प्रविष्ट करा",
          "emptyEmail": "कृपया वैध ईमेल प्रविष्ट करा",
          "emptyImage": "कृपया अपलोड करण्यासाठी फोटो निवडा",
          "emptyMobile": "कृपया वैध मोबाइल नंबर प्रविष्ट करा",

          ///Activity form snack-bar keys
          "emptyTitle": "कृपया शीर्षक प्रविष्ट करा",
          "emptyDescription": "कृपया वर्णन प्रविष्ट करा",
          "exceedImageMsg": "मर्यादा संपली आहे!",
          "postSaveMsg": "माहिती यशस्वीरित्या जतन केली",

          ///comment add and delete msg keys
          "cmtStatus": "स्थिती:",
          "cmtDeleteMsg": "कंमेंट यशस्वीरित्या हटवली.",
          "cmtAddedMsg": "कंमेंट यशस्वीरित्या जोडली.",
          "emptyCommentTitle": "संदेश",
          "emptyCommentMsg": "कृपया कंमेंट प्रविष्ट करा",
          "commentUpdateMsg": "कंमेंट यशस्वीरित्या अपडेट केली",
          "postDeleteMsg": "पोस्ट यशस्वीरित्या हटवली",
          "postDeleteErrorMsg": "तुम्ही ही पोस्ट हटवू शकत नाही",
          "profileUpdateMsg": "प्रोफाइल यशस्वीरित्या अपडेट केले!",
        },

        ///Hindi.tr
        'hi_IN': {
          ///RegistrationForm Keys
          "rTitle": "रजिस्ट्रेशन",
          "nameHint": "पूरा नाम",
          "mobileHint": "मोबाइल नंबर (एन.ई.)",
          "emailHint": "ईमेल आईडी",
          "genderText": "लिंग",
          "maleRadioText": "पुरुष",
          "femaleRadioText": "महिला",
          "addressHint": "पता",
          "cityHint": "शहर",
          "villageHint": "गाँव",
          "grampanchayatHint": "ग्रामपंचायत",
          "rButton": "रजिस्टर करें",
          "existAccountText": "पहले से ही एक खाता है?",

          ///Register Screen to get Otp Keys
          "login": "लॉगिन",
          "otpMessage": "हम आपको वन टाइम पासवर्ड (OTP) भेजेंगे",
          "mobileLable": "मोबाइल नंबर",
          "mobileHintText": "मोबाइल नंबर दर्ज करें",
          "getOtp": "ओटीपी प्राप्त करें",
          "pasteTitle": "पेस्ट कोड",
          "pasteContent": "क्या आप कोड पेस्ट करना चाहते हैं",

          ///Otp Verification  Keys
          "otp": "ओटीपी",
          "ovMessage": "हमने आपके नंबर पर ओटीपी भेज दिया है.",
          "otpNotReceivedText": "ओटीपी प्राप्त नहीं हुआ?",
          "resendText": "OTP दोबारा भेजें",

          ///choose language Dialog keys
          "english": "अंग्रेज़ी",
          "marathi": "मराठी",
          "hindi": "हिंदी",
          "chooseLanguage": "भाषा चुनें",

          ///DashboardScreen keys
          "projectTitle": "ग्राम सुविधा",
          "gram": "ग्राम",
          "suvidha": "सुविधा",
          "welcome": "स्वागत",
          "enquiry_service": "पूछताछ / सेवा",
          "request": "अनुरोध",
          "decision_proceedings": "निर्णय और\n कार्यवाही",
          "complaints": "शिकायते",
          "addFamilyMember": "परिवार सदस्य\n जोड़ें",
          "downloads": "डाउनलोड",
          "myProfile": "मेरी\nप्रोफाइल",
          "grampachayatActivities": "ग्राम पंचायत की गतिविधियां",
          "like": "लाइक",
          "comment": "कमेंट्स",
          "share": "शेअर",
          "loaderWaitText": "कृपया प्रतीक्षा करें",

          ///Post Detail Screen Keys
          "postDetailAppBarTitle": "पोस्ट विवरण",
          "ediComment": "कमेंट संपादित करें",
          "enterCommentHint": "कमेंट दर्ज करें",
          "deleteCommentTitle": "क्या आपकी इस कमेंट को हटाने की चाहत है?",
          "commentLikeText": "लोगों को यह पसंद आया",
          "noCommentMsg": "कोई कमेंट नहीं मिली!",

          ///Profile screen keys
          "profileAppBarTitle": "प्रोफ़ाइल",
          "updateProfileAppBarTitle": "अपडेट प्रोफ़ाइल",
          "fullNameHint": "कृपया पूरा नाम दर्ज करें",
          "mobileText": "कृपया मोबाइल नंबर दर्ज करें",
          "emailHintText": "कृपया ईमेल आईडी दर्ज करें",
          "addressHintText": "कृपया पता दर्ज करें",

          ///Activity form keys
          "title": "शीर्षक",
          "description": "विवरण",
          "desHint": "कृपया विवरण दर्ज करें",
          "addPhotoBtn": "तस्वीरें जोडो",
          "activityAppBarTitle": "पोस्ट",
          "postBtn": "पोस्ट",
          "updateBtn": "अपडेट करें",
          "notificationAppBarText": "सूचना",

          ///Activity form image delete popup keys
          "deleteTitle": "अनुलग्नक हटाएँ",
          "contentTitle": "क्या आप अनुलग्नक हटाना चाहते हैं?",
          "cancelBtn": "रद्द करें",
          "okBtn": "ठीक",

          ///Work history page keys
          "appBarTitle": "मेरी पोस्टें",
          "editBtn": "संपादित करें",
          "deleteBtn": "हटाएं",
          "alert": "अलर्ट",
          "popupContentTitle": "क्या आप इस पोस्ट को डिलीट करना चाहते हैं?",

          ///Drawer keys
          "home": "होम",
          "kyc": "केवाईसी",
          "essentialSevicess": "आवश्यक सेवा संपर्क",
          "gramPanchayatBodyInfo": "ग्राम पंचायत निकाय की जानकारी",
          "shareLink": "ऐप लिंक शेयर करें",
          "activities": "गतिविधियाँ",
          "changeLanguage": "भाषा बदलें",
          "logout": "लॉगआउट",

          ///Logout Dialog Keys
          "logoutConfirmMessage": "क्या आप लॉगआउट करना चाहते हैं ?",
          "exitAppMsg": "क्या आप ऐप से बाहर निकलना चाहते हैं",
          "exitAppTitle": "ऐप से बाहर निकलें",
          "yes": "हाँ",
          "no": "नहीं",

          ///Enquiry & Complain ServiceRequest Keys
          "typeOfEnquiry": "पूछताछ का प्रकार:",
          "typeOfComplain": "शिकायतों के प्रकार:",
          "enquiryText": "पूछताछ पाठ:",
          "status": "स्थिति:",
          "date": "तारीख",
          "addEnquiry": "पूछताछ जोड़ें",
          "addComplain": "शिकायत जोड़ें",

          ///Enquire & Complain Form Keys
          "enquiryForm": "पूछताछ फॉर्म",
          "complaintForm": "शिकायत फॉर्म",

          "complainText": "शिकायत पाठ",
          "location": "स्थान",
          "listofAttachment": "अटैचमेंट की लिस्ट",
          "choosePhoto": "फोटो चुनें",
          "submit": "प्रस्तुत करे",

          ///Decisions and Proceedings keys
          "decision_proceedings_title": "निर्णय और कार्यवाही",

          ///Add Family Member Keys
          "addFamilyMemberTitle": "परिवार के सदस्य जोड़ें",
          "addUser": "यूजर जोड़ें",

          ///Add User Keys
          "userName": "नाम",
          "userContact": "मोबाइल नंबर",
          "rollOfUser": "यूजर रोल",
          "kycDocs": "केवाईसी दस्तावेज",
          "docsName": "दस्तावेज़ का नाम",

          ///Profile Keys
          "profile": "प्रोफाइल",
          "city": "शहर:",
          "village": "गाँव:",

          ///Essential Service Keys
          "essentialServiceTitle": "आवश्यक सेवा",

          ///Grampanchayat Body Information Keys
          "grampanchayatBodyInfoTitle": "ग्रामपंचायत निकाय जानकारी",

          ///Share App Keys
          "shareAppTitle": "शेयर ऐप",
          "faceBook": "फेसबुक",
          "email": "ईमेल",
          "whatsapp": "वॉट्सऐप",
          "sms": "एसएमएस",

          ///SnackBar messages Keys
          "copySnackBarMessage": "आपके क्लिपबोर्ड पर कॉपी किया गया !",
          "exitSnackBarMessage": "बाहर निकलने के लिए दोबारा दबाएं",
          "resendOtpSnackBarMsg": "ओटीपी आपके मोबाइल पर भेजा",
          "loginSnackBarMsg": "सफलतापूर्वक लॉग इन किया हैे",
          "invalidOtpSnackBarMsg": "कृपया मान्य ओटीपी दर्ज करें",
          "invalidMobileSnackBarMsg": "कृपया पंजीकृत मोबाइल नंबर दर्ज करें",
          "emptyMobileSnackBarMsg": "मोबाइल नंबर दर्ज करें",
          "emptyOtpSnackBarMsg": "कृपया ओटीपी दर्ज करें",
          "logoutSnackBarMsg": "ऐप लॉगआउट सफल!",
          "postUpdateMsg": "पोस्ट सफलतापूर्वक अपडेट किया है.",

          ///Update profile snack-bar keys
          "emptyName": "कृपया पूरा नाम दर्ज करें",
          "emptyEmail": "कृपया वैध ईमेल दर्ज़ करें",
          "emptyImage": "कृपया फोटो अपलोड करें",
          "emptyMobile": "कृपया वैध मोबाइल नंबर दर्ज करें",

          ///Activity form snack-bar keys
          "emptyTitle": "कृपया शीर्षक दर्ज करें",
          "emptyDescription": "कृपया विवरण दर्ज करें",
          "exceedImageMsg": "सिमा समाप्त हो गई है!",
          "postSaveMsg": "डेटा सफलतापूर्वक जतन किया",

          ///comment add and delete msg keys
          "cmtStatus": "स्थिति:",
          "cmtDeleteMsg": "कमेंट सफलतापूर्वक हटा दी गई.",
          "cmtAddedMsg": "कमेंट सफलतापूर्वक जोड़ी गई.",
          "emptyCommentTitle": "संदेश",
          "emptyCommentMsg": "कृपया कमेंट दर्ज करें",
          "commentUpdateMsg": "कमेंट सफलतापूर्वक अपडेट की गई",
          "postDeleteMsg": "पोस्ट सफलतापूर्वक हटा दी गई",
          "postDeleteErrorMsg": "आप इस पोस्ट को हटा नहीं सकते",
          "profileUpdateMsg": "प्रोफाइल को सफलतापूर्वक अपडेट किया गया!",
        }
      };
}
