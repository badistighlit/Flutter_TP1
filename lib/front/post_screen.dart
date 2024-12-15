import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/post_bloc.dart';
import '../../logic/post_event.dart';
import '../../logic/post_state.dart';
import 'add_post_screen.dart';
import 'edit_post_screen.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final posts = state.posts;

            if (posts.isEmpty) {
              return const Center(child: Text('No posts available'));
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Container(
                  // Appliquer une couleur de fond à chaque post
                  color: index.isEven ? Colors.lightBlue.shade50 : Colors.lightGreen.shade50,
                  child: ListTile(
                    title: Text(
                      post.title ?? 'Post sans titre',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      post.description ?? 'Post sans descriptioon',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<PostBloc>().add(DeletePost(post.id));
                      },
                    ),
                    onTap: () {
                      // boutton de navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPostScreen(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.error ?? 'ERREUR'));
          }

          return const Center(child: Text('No posts available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // boutton de navigation
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
