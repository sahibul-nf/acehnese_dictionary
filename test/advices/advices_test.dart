import 'package:acehnese_dictionary/src/advices/controller/advices_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Advices Test', () {
    var advicesController = AdvicesController();

    test('Test function getAdvices()', () {
      advicesController.getAdvices("lon");

      // expect(advicesController.advices.contains(element), matcher)
    });
  });
}
