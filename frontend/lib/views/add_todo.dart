import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../provider/todo_provider.dart';

TextEditingController titleController= TextEditingController();
TextEditingController descriptionController= TextEditingController();

addDataWidget(BuildContext context, TaskModel taskModel){
      titleController.text= taskModel.title==''?'': taskModel.title;
      descriptionController.text= taskModel.description==''?'':taskModel.description;

    return showModalBottomSheet(
          shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
           ),),
        context: context,
        builder:(context){
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 280,
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      hintText: 'Enter Title Here',
                    ),
                    autofocus: false,
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      hintText: 'Enter Description Here',
                    ),
                    autofocus: false,
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                      onPressed: taskModel.title==''?(){
                        if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                          Provider.of<TodoProvider>(context, listen: false)
                              .addData({
                            "name": titleController.text,
                            "description":descriptionController.text,
                            "terminated":taskModel.terminated,
                          }).whenComplete(() {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task added')));
                          });
                        }
                        else{
                        }
                      }:(){
                        context.read<TodoProvider>().updateData(taskModel.id, {
                          "name": titleController.text,
                          "description":descriptionController.text}).whenComplete((){
                            Navigator.pop(context);
                        });
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child:taskModel.title==''? Text("Submit", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),):
                          Text("Update", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          );
        });

}