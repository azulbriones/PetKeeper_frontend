import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source_impl.dart';
import 'package:pet_keeper_front/features/adopt_pet/data/repositories/adopt_pet_repository_impl.dart';
// import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/create_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/delete_post_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_all_posts_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_by_actual_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/use_cases/get_post_detail_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source_impl.dart';
import 'package:pet_keeper_front/features/stray_pet/data/repositories/stray_pet_repository_impl.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/create_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/delete_stray_pet_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_all_stray_pets_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pet_by_id_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_location_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_lost_date_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_owner_id_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_rescuer_id_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_stray_pets_by_status_use_case.dart';
// import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/update_stray_pet_use_case.dart';

class UseCaseConfig {
  //STRAY PETS
  StrayPetRemoteDataSourceImpl? strayPetDatasourceImpl;
  StrayPetRepositoryImpl? strayPetRepositoryImpl;
  CreateStrayPetUseCase? createStrayPetUseCase;
  DeleteStrayPetUseCase? deleteStrayPetUseCase;
  GetAllStrayPetsUseCase? getAllStrayPetsUseCase;
  GetStrayPetByIdUseCase? getStrayPetByIdUseCase;
  //ADOPT PETS
  AdoptPetRemoteDataSourceImpl? adoptPetDatasourceImpl;
  AdoptPetRepositoryImpl? adoptPetRepositoryImpl;
  CreatePostUseCase? createAdoptPetUseCase;
  DeletePostUseCase? deleteAdoptPetUseCase;
  GetAllPostsUseCase? getAllAdoptPetsUseCase;
  GetPostDetailUseCase? getAdoptPetByIdUseCase;
  GetPostByActualOwnerIdUseCase? getPostByActualOwnerIdUseCase;
  // GetStrayPetByLocationUseCase? getStrayPetByLocationUseCase;
  // GetStrayPetsByLostDateUseCase? getStrayPetsByLostDateUseCase;
  GetStrayPetsByOwnerIdUseCase? getStrayPetsByOwnerIdUseCase;
  // GetStrayPetsByRescuerIdUseCase? getStrayPetsByRescuerIdUseCase;
  // GetStrayPetsByStatusUseCase? getStrayPetsByStatusUseCase;
  // UpdateStrayPetUseCase? updateStrayPetUseCase;

  UseCaseConfig() {
    //STRAY PETS
    strayPetDatasourceImpl = StrayPetRemoteDataSourceImpl();
    strayPetRepositoryImpl = StrayPetRepositoryImpl(
        strayPetRemoteDataSource: strayPetDatasourceImpl!);
    createStrayPetUseCase = CreateStrayPetUseCase(strayPetRepositoryImpl!);
    deleteStrayPetUseCase = DeleteStrayPetUseCase(strayPetRepositoryImpl!);
    getAllStrayPetsUseCase = GetAllStrayPetsUseCase(strayPetRepositoryImpl!);
    getStrayPetByIdUseCase = GetStrayPetByIdUseCase(strayPetRepositoryImpl!);
    getStrayPetsByOwnerIdUseCase =
        GetStrayPetsByOwnerIdUseCase(strayPetRepositoryImpl!);
    //ADOPT PETS
    adoptPetDatasourceImpl = AdoptPetRemoteDataSourceImpl();
    adoptPetRepositoryImpl = AdoptPetRepositoryImpl(
        adoptPetRemoteDataSource: adoptPetDatasourceImpl!);
    createAdoptPetUseCase = CreatePostUseCase(adoptPetRepositoryImpl!);
    deleteAdoptPetUseCase = DeletePostUseCase(adoptPetRepositoryImpl!);
    getAllAdoptPetsUseCase = GetAllPostsUseCase(adoptPetRepositoryImpl!);
    getAdoptPetByIdUseCase = GetPostDetailUseCase(adoptPetRepositoryImpl!);
    getPostByActualOwnerIdUseCase =
        GetPostByActualOwnerIdUseCase(adoptPetRepositoryImpl!);
    // getStrayPetByLocationUseCase =
    //     GetStrayPetByLocationUseCase(strayPetRepositoryImpl!);
    // getStrayPetsByLostDateUseCase =
    //     GetStrayPetsByLostDateUseCase(strayPetRepositoryImpl!);

    // getStrayPetsByRescuerIdUseCase =
    //     GetStrayPetsByRescuerIdUseCase(strayPetRepositoryImpl!);
    // getStrayPetsByStatusUseCase =
    //     GetStrayPetsByStatusUseCase(strayPetRepositoryImpl!);
    // updateStrayPetUseCase = UpdateStrayPetUseCase(strayPetRepositoryImpl!);
  }
}
