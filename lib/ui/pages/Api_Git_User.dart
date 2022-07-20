import 'package:bloc_app1/bloc/usersBloc.dart';
import 'package:bloc_app1/helper/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

// moi
class UserGitApi extends StatelessWidget {
  const UserGitApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserSearchBloc, UserSearchState>(
          builder: (context, state) {
            if (state is SearchUsersSuccessState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Users"),
                  Text("${state.currentpage.toString()}"
                      '/'
                      "${state.totalPages.toString()}"),
                ],
              );
            } else {
              return const Text("Users Page");
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                            ))),
                  )),
                  IconButton(
                      onPressed: () {
                        String keyword = textEditingController.text;
                        context.read<UserSearchBloc>().add(
                              SearchUsersEvent(
                                keyword: keyword,
                                page: 0,
                                pageSize: 10,
                              ),
                            );
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            BlocBuilder<UserSearchBloc, UserSearchState>(
                builder: (context, state) {
              String keyword = textEditingController.text;
              if (state is SearchUsersLodingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else if (state is SearchUsersErrorState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.ErrorMessage,
                      style: CustomThemes.errorTextStyle,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          UserSearchBloc userSearchBloc =
                              context.read<UserSearchBloc>();
                          userSearchBloc.add(userSearchBloc.currentEvent);
                        },
                        child: const Text("Try again!"))
                  ],
                );
              } else if (state is SearchUsersSuccessState) {
                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      context.read<UserSearchBloc>().add(SearchNextPageEvent(
                          keyword: state.keyword,
                          page: state.currentpage + 1,
                          pageSize: state.pagesize));
                    },
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state.users[index].avatarUrl),
                            ),
                            title: Text(state.users[index].login,
                                style: Theme.of(context).textTheme.headline6),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: null,
                              child: Text(
                                  state.users[index].score.floor().toString()),
                            ),
                          );
                        }),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 3,
                          );
                        },
                        itemCount: state.users.length),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
