import 'package:flutter/material.dart';
import 'package:flutter_application/routes/helpers/navigation_helper.dart';
import 'task_details.dart';
import '../../common/widgets/footer.dart';
import '../home/home.dart';
import '../orders/orders.dart';
import '../customers/customers.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});
  @override
  TodoState createState() => TodoState();
}

class TodoState extends State<Todo> {
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        NavigationHelper.safePush(context,Home());
        break;
      case 1:
        NavigationHelper.safePush(context,Todo());
        break;
      case 2:
        NavigationHelper.safePush(context,CustomerScreen());
        break;
      case 3:
        NavigationHelper.safePush(context,OrdersList());
        break;
      case 4:
      // NavigationHelper.safePush(context,Settings(),'/settings');
      // break;
    }
  }

  final List<String> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text("TO-DO List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _todos.isEmpty
                ? Center(child: Text('No tasks yet.'))
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetails(
                                  task: _todos[index],
                                  onDelete: () {
                                    setState(() {
                                      _todos.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _todos[index],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _addTodo, child: Text('Add')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        currentIndex: 1,
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}
