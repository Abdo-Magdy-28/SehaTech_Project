import 'package:bloc/bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_state.dart';
import 'package:meta/meta.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit() : super(DoctorsInitial());
}
