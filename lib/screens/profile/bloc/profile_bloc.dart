import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/network_utils/dio_helper.dart';
import 'package:project/network_utils/end_points.dart';
import 'package:project/screens/profile/profile_model.dart';
import 'package:project/shared/sharedpreferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileStates> {
  DioHelper dioHelper;
  ProfileModel profileModel;
  ProfileBloc({@required DioHelper dioHelper}) : super(ProfileInitialState());
  String name="";
  String email="";
  var phone="";
  int id=0;

  void profileFun()
  {

    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE).then((value) {
      print(value.data);
      profileModel=ProfileModel.fromJson(value.data[0]) ;
      emit(ProfileSuccessState(profileModel));
    }).catchError((error){
      emit(ProfileErrorState(error));});
    
  }

}
