import 'package:flutter_test/flutter_test.dart';
import 'package:chili_pedia/main.dart';

void main() {
  testWidgets('ChiliCare App launches splash screen smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChiliCareApp());

    // Verify that the title and splash elements exist
    expect(find.text('ChiliCare'), findsOneWidget);
    expect(find.text('Buku Saku Pengendalian Hama & Penyakit Cabai'), findsOneWidget);
  });
}
