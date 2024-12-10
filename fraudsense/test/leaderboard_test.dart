import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/cloud/cloud_services.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:mocktail/mocktail.dart';

class MockCloudServices extends Mock implements CloudServices {}

void main() {
  late CloudServices mockCloudServices;
  late CloudController cloudController;

  setUp(() {
    mockCloudServices = MockCloudServices();
    cloudController = CloudController(mockCloudServices);
  });

  test('Getting top users in order based on game score', () async {
    //mocking and returning a list of users with different game scores
    when(() => mockCloudServices.getAllUsers()).thenAnswer((_) async {
      return [
        UserDataModel.emptyData().copyWith(userName: 'user1', gameScore: 100),
        UserDataModel.emptyData().copyWith(userName: 'user2', gameScore: 200),
        UserDataModel.emptyData().copyWith(userName: 'user3', gameScore: 300),
      ];
    });

    final result = await cloudController.getTopUsers();

    expectLater(result.isSuccess, true);

    //expecting the first user in the list to be user3 with the most game score
    expectLater(
      result.data!.first.userName,
      'user3',
    );

    //expecting the last user in the list to be user1 with the least game score
    expectLater(
      result.data!.last.userName,
      'user1',
    );
  });
}
