import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_playground/core/viewmodels/home_page_view_model.dart';
import 'package:flutter_playground/widgets/add_new_task.dart';
import 'package:flutter_playground/widgets/task_list.dart';
import 'package:provider_architecture/provider_architecture.dart';


class HomePage extends StatelessWidget {
  const HomePage();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomePageViewModel>.withConsumer(
        viewModel: HomePageViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, _) => PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text("Taskly"),
            trailingActions: <Widget>[
              PlatformIconButton(
                icon: Icon(Icons.add),
                onPressed: () async{
                  final nTask = await showModalBottomSheet(
                  context: context,
                  builder: (_) => AddNewTask(isEditMode: false));
                  if(nTask!=null){
                    model.onAddTask(nTask);
                  }
                },
              ),
              PlatformIconButton(
                icon: Icon(Icons.brightness_2),
                onPressed: (){
                  model.toggleTheme(context);
                },
              )
            ],
          ),
          body: TaskList(tasks: model.taskList, onDelete: model.onDelete, onEdit: model.onEditTask, onToggle: model.onToggleCheck),
        ),
        );
  }
}
