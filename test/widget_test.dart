import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('shows the portfolio home screen', (WidgetTester tester) async {
    final apiClient = ApiClient(
      client: MockClient((_) async => http.Response('[]', 200)),
    );
    await tester.pumpWidget(MyApp(apiClient: apiClient));

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('2506624940'), findsOneWidget);
  });
}
