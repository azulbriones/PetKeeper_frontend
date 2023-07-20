import 'package:pet_keeper_front/features/adopt_pet/domain/entities/adopt_pet.dart';

abstract class AdoptPetRepository {
  Future<List<AdoptPet>> createPost(AdoptPet adoptPet);
  Future<List<AdoptPet>> getAllPosts();
  Future<AdoptPet> getPostDetail(int postId);
  Future<String> updatePost(AdoptPet adoptPet);
  Future<String> deletePost(int postId);
  Future<List<AdoptPet>> getPostByActualOwnerId(int actualOwnerId);
  Future<List<AdoptPet>> getPostByNewOwnerId(int rescuerId);
  Future<List<AdoptPet>> getPostsByAddress(String address);
  Future<List<AdoptPet>> getPostsByStatus(String status);
}
