import 'package:pet_keeper_front/features/adopt_pet/data/datasources/api_datasource/adopt_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/repositories/adopt_pet_repository.dart';
import 'package:pet_keeper_front/features/stray_pet/data/datasources/api_datasource/stray_pet_remote_data_source.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/entities/stray_pet.dart';
import 'package:pet_keeper_front/features/stray_pet/domain/repositories/stray_pet_repository.dart';

class AdoptPetRepositoryImpl implements AdoptPetRepository {
  final AdoptPetRemoteDataSource adoptPetRemoteDataSource;

  AdoptPetRepositoryImpl({required this.adoptPetRemoteDataSource});
  @override
  Future<List<AdoptPet>> createPost(AdoptPet adoptPet) async {
    return await adoptPetRemoteDataSource.createPost(adoptPet);
  }

  @override
  Future<String> deletePost(int postId) async {
    return await adoptPetRemoteDataSource.deletePost(postId);
  }

  @override
  Future<List<AdoptPet>> getAllPosts() async {
    return await adoptPetRemoteDataSource.getAllPosts();
  }

  @override
  Future<List<AdoptPet>> getPostByActualOwnerId(int actualOwnerId) async {
    return await adoptPetRemoteDataSource.getPostByActualOwnerId(actualOwnerId);
  }

  @override
  Future<List<AdoptPet>> getPostByNewOwnerId(int newOwnerId) async {
    return await adoptPetRemoteDataSource.getPostByNewOwnerId(newOwnerId);
  }

  @override
  Future<AdoptPet> getPostDetail(int postId) async {
    return await adoptPetRemoteDataSource.getPostDetail(postId);
  }

  @override
  Future<List<AdoptPet>> getPostsByAddress(String address) async {
    return await adoptPetRemoteDataSource.getPostsByAddress(address);
  }

  @override
  Future<List<AdoptPet>> getPostsByStatus(String status) async {
    return await adoptPetRemoteDataSource.getPostsByStatus(status);
  }

  @override
  Future<String> updatePost(AdoptPet AdoptPet) async {
    return await adoptPetRemoteDataSource.updatePost(AdoptPet);
  }
}
