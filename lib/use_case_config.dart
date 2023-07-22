import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source_impl.dart';
import 'package:pet_keeper_front/features/adopt_pet/data/repositories/adopt_pet_repository_impl.dart';
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source_impl.dart';
import 'package:pet_keeper_front/features/stray_pet/data/repositories/stray_pet_repository_impl.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/create_post_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/delete_post_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_all_posts_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_post_by_owner_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_post_detail_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_address_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_resucer_id_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_by_status_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/get_posts_losted_date_use_case.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/use_cases/update_post_use_case.dart';

class UseCaseConfig {
  StrayPetRemoteDataSourceImpl? strayPetDatasourceImpl;
  StrayPetRepositoryImpl? strayPetRepositoryImpl;
  CreatePostUseCase? createPostUseCase;
  DeletePostUseCase? deletePostUseCase;
  GetAllPostsUseCase? getAllPostsUseCase;
  GetPostDetailUseCase? getPostDetailUseCase;
  GetPostsByAddressUseCase? getPostsByAddressUseCase;
  GetPostsByLostedDateUseCase? getPostsByLostedDateUseCase;
  GetPostsByOwnerIdUseCase? getPostsByOwnerIdUseCase;
  GetPostsByRescuerIdUseCase? getPostsByRescuerIdUseCase;
  GetPostsByStatusUseCase? getPostsByStatusUseCase;
  UpdatePostUseCase? updatePostUseCase;

  AdoptPetRemoteDataSourceImpl? adoptPetRemoteDataSourceImpl;
  AdoptPetRepositoryImpl? adoptPetRepositoryImpl;
  // CreatePostUseCase? createPostUseCase;
  // DeletePostUseCase? deletePostUseCase;
  // GetAllPostsUseCase? getAllPostsUseCase;
  // GetPostDetailUseCase? getPostDetailUseCase;
  // GetPostsByAddressUseCase? getPostsByAddressUseCase;
  // GetPostsByLostedDateUseCase? getPostsByLostedDateUseCase;
  // GetPostsByOwnerIdUseCase? getPostsByOwnerIdUseCase;
  // GetPostsByRescuerIdUseCase? getPostsByRescuerIdUseCase;
  // GetPostsByStatusUseCase? getPostsByStatusUseCase;
  // UpdatePostUseCase? updatePostUseCase;

  UseCaseConfig() {
    strayPetDatasourceImpl = StrayPetRemoteDataSourceImpl();
    strayPetRepositoryImpl = StrayPetRepositoryImpl(
        strayPetRemoteDataSource: strayPetDatasourceImpl!);
    createPostUseCase = CreatePostUseCase(strayPetRepositoryImpl!);
    deletePostUseCase = DeletePostUseCase(strayPetRepositoryImpl!);
    getAllPostsUseCase = GetAllPostsUseCase(strayPetRepositoryImpl!);
    getPostDetailUseCase = GetPostDetailUseCase(strayPetRepositoryImpl!);
    getPostsByAddressUseCase =
        GetPostsByAddressUseCase(strayPetRepositoryImpl!);
    getPostsByLostedDateUseCase =
        GetPostsByLostedDateUseCase(strayPetRepositoryImpl!);
    getPostsByOwnerIdUseCase =
        GetPostsByOwnerIdUseCase(strayPetRepositoryImpl!);
    getPostsByRescuerIdUseCase =
        GetPostsByRescuerIdUseCase(strayPetRepositoryImpl!);
    getPostsByStatusUseCase = GetPostsByStatusUseCase(strayPetRepositoryImpl!);
    updatePostUseCase = UpdatePostUseCase(strayPetRepositoryImpl!);
  }
}
