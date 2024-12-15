import '../models/post_model.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post postToAdd);
  Future<Post?> updatePost(Post updatedPost);
  Future<bool> deletePost(int id);
}

class FakePostDataSource implements PostDataSource {
  final List<Post> _fakePosts = [
    Post(id: 1, title: 'Post 1', description: 'desc'),
    Post(id: 2, title: 'Post 2', description: 'desc '),
  ];

  List<Post> getPosts() => List.unmodifiable(_fakePosts);

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.unmodifiable(_fakePosts);
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }


  @override
  Future<Post?> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost;
    } else {
      return null;
    }
  }

  @override
  Future<bool> deletePost(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    final initialLength = _fakePosts.length;
    _fakePosts.removeWhere((post) => post.id == id);
    return _fakePosts.length < initialLength;
  }
}
