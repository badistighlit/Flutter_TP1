import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post_model.dart';
import '../logic/post_bloc.dart';
import '../logic/post_event.dart';

class EditPostScreen extends StatelessWidget {
  final Post post;

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: post.title);
    final TextEditingController contentController =
    TextEditingController(text: post.description);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<PostBloc>().add(
                UpdatePost(new Post(id: post.id, title: titleController.text, description: contentController.text))
                );
                Navigator.pop(context);
                context.read<PostBloc>().add(LoadPosts());

              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
