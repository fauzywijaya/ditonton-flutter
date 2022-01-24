import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tv_show_dummy_object.dart';

void main() {
  test('should be a subclass of TVShow entity', () async {
    final result = testTvShowModel.toEntity();
    expect(result, testTvShow);
  });
}
