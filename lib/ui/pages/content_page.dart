import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misiontic_todo/domain/models/to_do.dart';
import 'package:misiontic_todo/ui/controllers/to_do.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<ContentPage> {
  late TextEditingController _textController;
  late ToDoController controller;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    controller = Get.find();
    // TODO: Obten los ToDos de la base de datos y actualiza el estado
    controller.initialize().then(
          (_) => controller.getAll().then(
            (value) {
              setState(() {
                controller.toDos = value;
              });
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de ToDos"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: "Nuevo To-Do",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final toDo = ToDo(content: _textController.text);
                        // TODO: 1. Guarda el todo en ToDoService.
                        // TODO: 2. Guarda el todo en todos.
                        // TODO: 3. Actualiza el estado.
                        controller.saveToDo(toDo: toDo).then((_) {
                          setState(() {
                            _textController.clear();
                            controller.toDos.add(toDo);
                          });
                        });
                      },
                      child: const Text("Aceptar"))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: controller.toDos.length,
                    itemBuilder: (ontext, index) {
                      final toDo = controller.toDos[index];
                      return ListTile(
                        leading: AbsorbPointer(
                          absorbing: toDo.completed,
                          child: IconButton(
                            icon: Icon(
                              toDo.completed
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color:
                                  toDo.completed ? Colors.green : Colors.grey,
                            ),
                            onPressed: () {
                              toDo.completed = true;
                              // TODO: 1. Actualiza el toDo en ToDoService.
                              // TODO: 2. Actualiza el toDo en todos.
                              // TODO: 3. Actualiza el estado.
                              controller.updateToDo(toDo: toDo).then((_) {
                                setState(() {
                                  controller.toDos[index]=toDo;
                                });
                              });
                            },
                          ),
                        ),
                        title: Text(toDo.content),
                        trailing: IconButton(
                          onPressed: () {
                            // TODO: 1. Elimina el toDo de ToDoService.
                            // TODO: 2. Elimina el toDo de todos.
                            // TODO: 3. Actualiza el estado.
                          controller.deleteToDo(toDo: toDo).then((_){
                            setState(() {
                              controller.toDos.removeAt(index);
                            });
                          });
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_sweep_rounded),
        onPressed: () {
          // TODO: 1. Elimina los ToDOs de ToDoService.
          // TODO: 2. Limpia todos
          // TODO: 3. Actualiza el estado.
          controller.deleteAll().then((_) {
            setState(() {
              controller.toDos.clear();
            });
          });

        },
      ),
    );
  }
}
