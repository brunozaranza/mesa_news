import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:timeago/timeago.dart' as timeAgo;

extension StringExtension on String {
  md5() => crypto.md5.convert(utf8.encode(this)).toString();

  String parseDateTimeAgo() {
    try {
      DateTime date = DateTime.parse(this);
      timeAgo.setLocaleMessages('pt_BR', timeAgo.PtBrMessages());
      return timeAgo.format(date, locale: "pt_BR", allowFromNow: true);
    } catch (e) {
      return this;
    }
  }
}
