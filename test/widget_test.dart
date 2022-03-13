import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/providers/jsonplaceholder_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';


final MockUser user = MockUser();
final MockPost post = MockPost();

class MockProvider extends Mock implements JsonPlaceholderProvider{
  @override
  Future<List<MockUser>> getUsers() async{
    return List.filled(10, user);
  }

  @override
  Future<List<MockPost>> getPostsByUsers(userId) async{
    return List.filled(10, post);
  }
}
@GenerateMocks([User,Post])
void main() {
  test('users', () async{
    var users = await MockProvider().getUsers();
    expect(users, List<MockUser>.generate(10, (index) => user));
  });

  test('posts', () async{
    var posts = await MockProvider().getPostsByUsers(1);
    expect(posts, List<MockPost>.generate(10, (index) => post));
  });
}
