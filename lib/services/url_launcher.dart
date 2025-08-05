import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService{
 static void launchURL(String url)async{
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
  static void sendMail(String mail) async {
   try {
      String uri = 'mailto:$mail';
    await launchUrl(Uri.parse(uri));
   } catch (e) {
     print(e);
   }
  }
   static void onPhone(String phone) {
    var phoneURL = Uri.parse("tel:$phone");
    launchUrl(phoneURL);
  }
}