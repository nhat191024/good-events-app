import 'package:flutter_test/flutter_test.dart';
import 'package:sukientotapp/core/utils/phone_number_censor.dart';

void main() {
  group('PhoneNumberCensor', () {
    test('censors a plain Vietnamese phone number', () {
      expect(
        PhoneNumberCensor.censor('Liên hệ 0901234567 nhé'),
        'Liên hệ 090***** nhé',
      );
    });

    test('censors phone numbers containing separators', () {
      expect(
        PhoneNumberCensor.censor('Gọi 090 123 4567 hoặc 091-234-5678'),
        'Gọi 090***** hoặc 091*****',
      );
    });

    test('normalizes and censors the Vietnam country code', () {
      expect(
        PhoneNumberCensor.censor('Số của tôi là +84 90 123 4567'),
        'Số của tôi là 090*****',
      );
    });

    test('does not alter unrelated numeric content', () {
      expect(
        PhoneNumberCensor.censor('Đơn #123456 có giá 2.000.000đ'),
        'Đơn #123456 có giá 2.000.000đ',
      );
    });
  });
}
