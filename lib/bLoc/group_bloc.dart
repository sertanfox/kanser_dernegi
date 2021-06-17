import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial());

  @override
  Stream<GroupState> mapEventToState(
    GroupEvent event,
  ) async* {
    if (event is GetToChatRoom) {
        yield GroupFound();
    } else if (event is Error ) {
        yield GroupErrorState();
    }
    else{
      yield GroupNoResultMessage(' .......');
    }

  }
}
