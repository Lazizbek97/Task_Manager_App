import 'package:flutter/material.dart';
import 'package:task_manager/core/hive_boxes.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/search_page/search_result.dart';

class SearchPage extends SearchDelegate {
  List<TaskModel> my_tasks = Boxes.getTask().values.toList();
  TaskModel? new_result;
  int? task_index;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    task_index = my_tasks.indexOf(new_result!);

    return SearchResult(
      task: new_result!,
      index: task_index!,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<TaskModel> suggestions = my_tasks.where((element) {
      final result = element.title.toLowerCase().toString();
      final input = query.toLowerCase().toString();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              new_result = suggestions[index];
              query = suggestions[index].title;
              showResults(context);
            },
            title: Text(suggestions[index].title),
          );
        });
  }
}
