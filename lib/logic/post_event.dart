import '../data/models/post_model.dart';

///  all Post events
abstract class PostEvent {}


class LoadPosts extends PostEvent {}


class AddPost extends PostEvent {
  final Post post;

  AddPost(this.post);
}


class UpdatePost extends PostEvent {
  final Post post;

  UpdatePost(this.post);
}


class DeletePost extends PostEvent {
  final int id;

  DeletePost(this.id);
}
