import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/post_repository.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    // Charger les posts
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError('Failed to load posts'));
      }
    });

    // CREE UN POST
    on<AddPost>((event, emit) async {
      try {
        await repository.addPost(event.post);
        // Recharger les posts après l'ajout
        final posts = await repository.getPosts();
        emit(PostLoaded(posts)); // Émettre les posts mis à jour
      } catch (e) {
        emit(PostError('Erreur pour créer un post'));
      }
    });

    // MAJ UN POST
    on<UpdatePost>((event, emit) async {
      try {

        await repository.updatePost(event.post);
        final posts = await repository.getPosts();
        emit(PostLoaded(posts)); // Émettre les posts mis à jour
      } catch (e) {
        emit(PostError('Erreur pour MAJ un post'));
      }
    });

    // DELETE POST
    on<DeletePost>((event, emit) async {
      try {

        await repository.deletePost(event.id);
        final posts = await repository.getPosts();
        emit(PostLoaded(posts)); // Émettre les posts mis à jour
      } catch (e) {
        emit(PostError('Erreur pour supp un post'));
      }
    });
  }
}
