import 'package:nguru/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUrlLauncher{

   static Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '${MyStrings.couldNotLaunch}: $url';
    }
  }

 static Future<void> sendEmail(
      {String? email, String subject = "", String body = ""}) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await canLaunch(mail)) {
      await launch(mail);
    } else {
      throw Exception(MyStrings.unableTOOpenTheMail);
    }
  }
}