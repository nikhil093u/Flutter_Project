// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/routes/routes.dart';
import '../../common/widgets/footer.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});
  @override
  TodoState createState() => TodoState();
}

class TodoState extends State<Todo> {
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.home);

        break;
      case 1:
        Navigator.pushNamed(context, Routes.todo);

        break;
      case 2:
        Navigator.pushNamed(context, Routes.customers);

        break;
      case 3:
        Navigator.pushNamed(context, Routes.orders);

        break;
      case 4:
        Navigator.pushNamed(context, Routes.setting);

        break;
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
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "TO-DO List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins',

            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _todos.isEmpty
                ? Center(
                    child: Text(
                      'No tasks yet.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',

                        fontSize: 16,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GestureDetector(
                            onTap: () async {
                              final bool? deleted =
                                  await Navigator.pushNamed(
                                        context,
                                        '/taskdetails',
                                        arguments: _todos[index],
                                      )
                                      as bool?;

                              if (deleted == true) {
                                setState(() {
                                  _todos.removeAt(index);
                                });
                              }
                            },

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD3D3D3),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _todos[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Add new task',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _addTodo,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.blue;
                              }
                              return Colors.blue;
                            }),
                        elevation: MaterialStateProperty.all(3),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.9),
                        ),
                      ),

                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
