import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/data_sources/fake_post_datas_source.dart';
import 'data/repositories/post_repository.dart';
import 'logic/post_bloc.dart';
import 'front/post_screen.dart';
import 'logic/post_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instance
    final fakeDataSource = FakePostDataSource();
    final postRepository = PostRepository(fakeDataSource);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(postRepository)..add(LoadPosts()),
        ),
      ],
      child: MaterialApp(
        title: 'Post Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold), // Titre des posts en gras
            bodyMedium: TextStyle(fontWeight: FontWeight.normal), // Description normale
          ),
        ),
        home: PostScreen(),
      ),
    );
  }
}
