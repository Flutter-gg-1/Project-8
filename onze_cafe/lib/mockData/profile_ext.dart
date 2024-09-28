import 'package:onze_cafe/mockData/mock_data.dart';

import '../model/profile.dart';

extension OffersExt on MockData {
  List<Profile> fetchProfiles() {
    return [
      Profile(
        id: '1',
        name: 'John',
        email: 'john_doe@example.com',
        phone: '0501231234',
      ),
      Profile(
        id: '2',
        name: 'Jane',
        email: 'jane_doe@example.com',
        phone: '0501112222',
      )
    ];
  }
}
