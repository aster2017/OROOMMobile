import 'package:intl/intl.dart';

final cur = NumberFormat("#,##,###", "en_US");

formatAmount(int amt) {
  return cur.format(amt);
}
