import 'package:bloc_app1/helper/Helper_Api_github/Http.dart';
import 'package:bloc_app1/models/gitHubModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//All input events in userBloc
abstract class UsersEvent {} // the main event

//1.
class SearchUsersEvent extends UsersEvent {
  final String keyword;
  final int page;
  final int? pageSize;
  SearchUsersEvent({required this.keyword, required this.page, this.pageSize});
}

//2. SearchNextPageEvent
class SearchNextPageEvent extends UsersEvent {
  final String keyword;
  final int page;
  final int? pageSize;
  SearchNextPageEvent(
      {required this.keyword, required this.page, this.pageSize});
}

//The User main State
abstract class UserSearchState {
  final List<User> users;
  final int currentpage;
  final int totalPages;
  final int pagesize;
  final String keyword;
  UserSearchState(
      {required this.users,
      required this.currentpage,
      required this.totalPages,
      required this.pagesize,
      required this.keyword});
}

// 1. about search Users
//initialstate as initState
class SearchUsersInitialState extends UserSearchState {
  SearchUsersInitialState()
      : super(
            currentpage: 0, keyword: "", pagesize: 0, totalPages: 0, users: []);
}

class SearchUsersSuccessState extends UserSearchState {
  SearchUsersSuccessState(
      {required super.users,
      required super.currentpage,
      required super.totalPages,
      required super.pagesize,
      required super.keyword});
}

class SearchUsersLodingState extends UserSearchState {
  SearchUsersLodingState(
      {required super.users,
      required super.currentpage,
      required super.totalPages,
      required super.pagesize,
      required super.keyword});
}

class SearchUsersErrorState extends UserSearchState {
  final String ErrorMessage;

  SearchUsersErrorState(
      {required super.users,
      required super.currentpage,
      required super.totalPages,
      required super.pagesize,
      required super.keyword,
      required this.ErrorMessage});
}
// 2. about a x event sates to put below

//Bloc
class UserSearchBloc extends Bloc<UsersEvent, UserSearchState> {
  // save Event
  late UsersEvent currentEvent;
  //End
  UserSearchBloc() : super(SearchUsersInitialState()) {
    on((SearchUsersEvent event, emit) async {
      currentEvent = event;
      print("***********Search**********" + event.page.toString());
      emit(SearchUsersLodingState(
          currentpage: state.currentpage,
          keyword: state.keyword,
          pagesize: state.pagesize,
          totalPages: state.totalPages,
          users: state.users));
      try {
        ListUSers listUSersSearched =
            await GitUsersRepository.searchUsers(event.keyword, 0, 20);
        int totalpages =
            (listUSersSearched.totalCount / event.pageSize!).floor();
        if (listUSersSearched.totalCount % event.pageSize! != 0) {
          totalpages = totalpages + 1;
        }
        emit(
          SearchUsersSuccessState(
              users: listUSersSearched.users,
              currentpage: event.page,
              totalPages: totalpages,
              pagesize: event.pageSize!,
              keyword: event.keyword),
        );
      } catch (e) {
        emit(SearchUsersErrorState(
            currentpage: state.currentpage,
            keyword: state.keyword,
            pagesize: state.pagesize,
            totalPages: state.totalPages,
            users: state.users,
            ErrorMessage: e.toString()));
      }
    });

    on((SearchNextPageEvent event, emit) async {
      currentEvent = event;
      print("*******Next**************" + event.page.toString());
      //
      try {
        ListUSers listUSersSearched = await GitUsersRepository.searchUsers(
            event.keyword, event.page, event.pageSize!);
        int totalpages =
            (listUSersSearched.totalCount / event.pageSize!).floor();
        if (listUSersSearched.totalCount % event.pageSize! != 0) {
          totalpages = totalpages + 1;
        }

        List<User> currentUsersList = [...state.users];
        currentUsersList.addAll(listUSersSearched.users);

        emit(
          SearchUsersSuccessState(
              users: currentUsersList,
              currentpage: event.page,
              totalPages: totalpages,
              pagesize: event.pageSize!,
              keyword: event.keyword),
        );
      } catch (e) {
        emit(SearchUsersErrorState(
            currentpage: state.currentpage,
            keyword: state.keyword,
            pagesize: state.pagesize,
            totalPages: state.totalPages,
            users: state.users,
            ErrorMessage: e.toString()));
      }
    });
  }
}
