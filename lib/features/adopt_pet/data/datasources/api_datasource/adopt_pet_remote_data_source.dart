import 'package:pet_keeper_front/features/adopt_pet/data/models/adopt_pet_model.dart';
import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

abstract class AdoptPetRemoteDataSource {
  Future<List<AdoptPetModel>> createPost(AdoptPet adoptPet);
  Future<List<AdoptPetModel>> getAllPosts();
  Future<AdoptPetModel> getPostDetail(int postId);
  Future<String> updatePost(AdoptPet adoptPet);
  Future<String> deletePost(int postId);
  Future<List<AdoptPetModel>> getPostByActualOwnerId(int actualOwnerId);
  Future<List<AdoptPetModel>> getPostByNewOwnerId(int newOwnerId);
  Future<List<AdoptPetModel>> getPostsByAddress(String address);
  Future<List<AdoptPetModel>> getPostsByStatus(String status);
}
