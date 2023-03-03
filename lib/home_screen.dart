import 'package:final_10/boxes/boxes.dart';
import 'package:final_10/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';


import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final titleController =TextEditingController();
  final dateController =TextEditingController();
  final amountController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive List"),),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_)
        {
          var data=box.values.toList().cast<NotesModel>();
          return ListView.builder(

            itemCount: box.length,
            itemBuilder: (context,index)
            {
              return Card(
                child:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].title.toString()),


                          Spacer(),
                          InkWell(
                              onTap: (){

                                _editMyDialog(data[index],data[index].title.toString(),  data[index].date.toString(),data[index].amount.toString());
                              },

                              child: Icon(Icons.edit)),
                          SizedBox(width: 10,),
                          InkWell(

                              onTap: (){

                                delete(data[index]);

                              },


                              child: Icon(Icons.delete)),
                        ],
                      ),
                      Text(data[index].date.toString()),
                      Text(data[index].amount.toString()),

                    ],
                  ),
                ) ,
              );
            },
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _showMyDialog();

        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel)async
  {


    await notesModel.delete();

  }

  Future<void> _editMyDialog(NotesModel notesModel ,String title,var date,var amount) async
  {
    titleController.text=title;
    dateController.text=date;
    amountController.text=amount;

    return showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text('Edit Notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,

                decoration: InputDecoration(

                    hintText: 'Enter title',

                    border: OutlineInputBorder()

                ),
              ),

              SizedBox(height: 20,)
              ,
              TextFormField(
                controller: dateController,

                decoration: InputDecoration(

                    hintText: 'Enter Description',

                    border: OutlineInputBorder()

                ),
              ),
              SizedBox(height: 20,)
              ,
              TextFormField(
                controller: amountController,

                decoration: InputDecoration(

                    hintText: 'Enter amount',

                    border: OutlineInputBorder()

                ),
              ),


            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){



          }, child: Text('Cancel')),

          TextButton(onPressed: () {

            notesModel.title=titleController.text.toString();

            notesModel.save();

            notesModel.date=dateController.text.toString();
            notesModel.save();


            notesModel.amount=amountController.text.toString();
            notesModel.save();





            Navigator.pop(context);


          }, child: Text('EDIT')),
        ],
      );

    });

  }

  Future<void> _showMyDialog() async
  {

    return showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text('Add Notes'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,

                decoration: InputDecoration(

                    hintText: 'Enter title',

                    border: OutlineInputBorder()

                ),
              ),

              SizedBox(height: 20,)
              ,
              TextFormField(
                controller: dateController,

                decoration: InputDecoration(

                    hintText: 'Enter date',

                    border: OutlineInputBorder()

                ),
              ),
              SizedBox(height: 20,),

              TextFormField(
                controller: amountController,

                decoration: InputDecoration(

                    hintText: 'Enter amount',

                    border: OutlineInputBorder()

                ),
              ),

            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){

            final data=NotesModel(title: titleController.text, date: dateController.text, amount:amountController.text);
            final box=Boxes.getData();
            box.add(data);
            // data.save();
            // print(box);
            titleController.clear();
            dateController.clear();
            amountController.clear();
            Navigator.pop(context);

          }, child: Text('Add')),

          TextButton(onPressed: (){
            Navigator.pop(context);


          }, child: Text('Cancel')),
        ],
      );

    });

  }
}
