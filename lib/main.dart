import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() => runApp(new ToDoApp());

class ToDoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'To Do Application',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
       ),
      home: new ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  createState() => new _TodoListState();
}

class _TodoListState extends State<ToDoList> {
  
  List<String> _todoItems = [];

  void _addToDoItem(String task){
    if(task.length > 0){
      setState(()=> _todoItems.add(task));
    }
  }

  void _removeToDoItem(int index){
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveToDoItem(int index){
    showDialog(context: context,
    builder: (BuildContext context){
      return new AlertDialog(
        title: new Text('Mark "${_todoItems[index]}" as Completed?'+' This will remove this Item'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
            ),
         new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeToDoItem(index);
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'ToDo Task Deleted!'
                );
            }
            ),
        ]
      );
    }
    );
  }

 Widget _buildToDoList(BuildContext context){
   return Column(
     children: <Widget>[
       new Flexible(
         child: new ListView.builder(
          itemBuilder: (context,index){
            if(index < _todoItems.length){
            return _buildToDoItem(_todoItems[index], index);
           }    
          },
          ), 
         ),
         
       ],
    );    
 }

 Widget _buildToDoItem(String todoText, int index){
   return new ListTile(
     title: new Text(todoText),
     onLongPress: () => _promptRemoveToDoItem(index),
   );
 }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
          title: new Text('To Do List')
          ),
          body:_buildToDoList(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
            focusElevation: 7,
            onPressed:_pushAddToDoScreen,
            tooltip: 'Add Task',
            child: new Icon(Icons.add)
          ),
          
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
                DrawerHeader(
                  child: Text('To Do App Drawer Header'),
                  decoration: BoxDecoration(
                  color: Colors.teal,
                 )
                ),
              ListTile(
                title: Text('Add Items'),
                onTap: _pushAddToDoScreen,
              ),
              ListTile(
                title: Text('Remove Items'),
                subtitle: Text('Long Press on any item to remove it'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Check Status of Items'),
                subtitle: Text('If the item is in List, then it is Pending, else long press to mark it done'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                IconButton(
                icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ] 
            )
          )
      );
  }


 void _pushAddToDoScreen(){
  Navigator.of(context).push( 
    new MaterialPageRoute(
      builder: (context){
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val){
              _addToDoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
              hintText: 'Enter Tasks....',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );
}
}