import 'package:global/global.dart';

class WhatsAppContactUtils{
  static Future<void> openWhatsAppChat(String phone, String message) async {
    final Uri url = Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp';
    }
  }
}