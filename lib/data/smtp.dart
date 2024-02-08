import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmailNotification(String purpose, String userEmail) async {
  final smtpServer =
      // ignore: deprecated_member_use
      gmail('sabungan.katemaberly366@gmail.com', 'vcxqnvmdzkwgqibs');

  final currentDateTime = DateTime.now(); // Get current date
  final currentDate =
      DateFormat('yyyy-MM-dd').format(currentDateTime); // Get current date
  final currentTime =
      DateFormat('HH:mm:ss').format(currentDateTime); // Get current time
  final message = Message()
    ..from = const Address('sabungan.katemaberly366@gmail.com', 'Flutter')
    ..recipients.add(userEmail)
    ..subject = purpose == "login"
        ? 'Welcome Back Visitor'
        : "Welcome to Cemetery Record Information!"
    ..text = purpose == "signup"
        ? 'Greetings!\nYour account with Cemetery Record has been successfully created.\nYou are now part of our community to manage cemetery records.\nFeel free to explore and update information as needed\n\nDate: $currentDate\nTime: $currentTime\nLocation: Oroquieta City Memorial Garden'
        : 'Welcome back!\nYour login to Cemetery Record Information System was successful.\nIf you have any updates or inquiries regarding cemetery records, please proceed with confidence\n\nDate: $currentDate\nTime: $currentTime\nLocation: Oroquieta City Memorial Garden';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } catch (e) {
    print('Error sending email: $e');
  }
}
