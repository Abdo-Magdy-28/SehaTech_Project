import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/services/search services/medicine/medicine_service.dart';
import 'package:grad_project/models/medicine/medicinemodel.dart';

abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  final List<MedicineModel> medicines;
  final int currentPage;
  final int totalResults;

  MedicineLoaded({
    required this.medicines,
    required this.currentPage,
    required this.totalResults,
  });
}

class MedicineError extends MedicineState {
  final String message;
  MedicineError(this.message);
}

//======================================================
class MedicineCubit extends Cubit<MedicineState> {
  final MedicineService service = MedicineService();

  MedicineCubit() : super(MedicineInitial());

  Future<void> searchMedicines({
    required String search,
    required String category,
    required int page,
    required int limit,
  }) async {
    emit(MedicineLoading());
    try {
      final medicines = await service.fetchMedicines(
        search: search,
        category: category,
        page: page,
        limit: limit,
      );

      emit(
        MedicineLoaded(
          medicines: medicines,
          currentPage: page,
          totalResults: medicines.length,
        ),
      );
    } catch (e) {
      emit(MedicineError(e.toString()));
    }
  }
}
