import '../data_sources/fake_post_datas_source.dart';
import '../models/post_model.dart';
import '../data_sources/fake_post_datas_source.dart';
import '../models/post_model.dart';

import '../data_sources/fake_post_datas_source.dart';
import '../models/post_model.dart';

class PostRepository {
  final FakePostDataSource dataSource;

  PostRepository(this.dataSource);

  Future<List<Post>> getPosts() async {
    return dataSource.getPosts();
  }


  Future<void> addPost(Post post) async {

    await dataSource.createPost(post);
  }

  Future<void> updatePost(Post post) async {
    await dataSource.updatePost(post);
  }

  Future<void> deletePost(int id) async {
    await dataSource.deletePost(id);
  }
}

