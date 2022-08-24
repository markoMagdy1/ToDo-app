import 'package:flutter/material.dart';
import 'package:todo/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../archived_screen.dart';
import '../done_screen.dart';
import '../home_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());

 static AppCubit get(context)=>BlocProvider.of(context);

  List<Map> tasks=[];
  Database ?database ;
  int  currentIndex =0;
  List<Widget>currentBody=
  [
    homeScreen(),
    NewScreen(),
    SearchScreen(),
  ];

  List<String>screenTitle=
  [
    'Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  void changeBottomNavBar(index){
    currentIndex=index;
    emit(ChangeBottomNavBarState());
  }

  bool IsbottunSheetShown=false;
  Icon BSIcon=Icon(Icons.add) ;

 void changeBottomSheet({
   required bool isShow,
   required Icon FBIcon
})
 {
   IsbottunSheetShown=isShow;
   BSIcon=FBIcon;

   emit(ChangeBottomSheetState());
 }


 Future createDataBase ()async{
     openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version)
        {
          print('Database created');
          database.execute('CREATE TABLE tasks ( id INTEGER PRIMARY KEY , title TEXT, date TEXT , time TEXT , status TEXT )')
              .then((value) {
            print('table created');
          }).catchError((error){
            print(error.toString());
          });
        },
        onOpen : (database)
        async {
          await getDataBase(database).then((value){
            tasks=value;
            emit(GetDataBaseState());
            print('Tasks After Inserting $tasks');
          });
          print('DataBase opened');
          }).then((value) {
            database=value;
            emit(CreateDataBaseState());
     });

        }

  Future insertToDatabase ({
    required String title,
    required String time,
    required String date
  }) async{
    await database!.transaction((txn)
    async {
      await txn.rawInsert('INSERT INTO  tasks(time,status,title,date)VALUES("$time","Active","$title","$date")')
          .then((value) {
            print('$value is inserted successsfully');
           emit(InsertedInDataBase());
            getDataBase(database).then((value)  {
              tasks=value;
              emit(GetDataBaseState());});


      })
          .catchError((error){print(error.toString());});

    });


  }

  Future<List<Map>> getDataBase(database)async{
    return await database!.rawQuery('SELECT * FROM tasks');
  }


}
