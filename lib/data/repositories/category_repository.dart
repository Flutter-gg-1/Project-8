import '../../integrations/supabase/supabase_client.dart';

class CategoryRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Category
  *
  * */
  addNewCategory({required String name}) async {
    try {
      final dataFound = await supabase.client
          .from("categories")
          .select("*")
          .match({"name": name}).select();

      if (dataFound.isNotEmpty) {
        print("there is data");
      } else {
        final response =
            await supabase.client.from("categories").upsert({"name": name});
        print(response);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  *
  * Tested
  * Update Category
  *
  * */

  updateCategory({required int id, required String name}) async {
    try {
      final dataFound = await supabase.client
          .from("categories")
          .select("*")
          .match({"name": name}).select();
      if (dataFound.isNotEmpty) {
        print("there is data");
      } else {
        final response = await supabase.client
            .from("categories")
            .update({"name": name}).eq("id", id);
        print(response);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  *
  * Tested
  * Delete Category
  *
  * */

  deleteCategory({required int id}) async {
    try {
      final dataFound = await supabase.client
          .from("products")
          .select("*")
          .eq("category_id", id)
          .select();

      if (dataFound.isNotEmpty) {
        print("there is data");
      } else {
        final response = await supabase.client
            .from("categories")
            .delete()
            .eq("id", id)
            .select();
        print(response);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  *
  * Tested
  * get all Categories
  *
  * */
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      final response = await supabase.client.from("categories").select("*");
      print(response);
      return response;
    } catch (e) {
      print(e.toString());

      return [];
    }
  }

  getUserCategories() async {
    try {
      List<Map<String, dynamic>> response =
          await supabase.client.rpc("get_distinct_category_names");
      return response;
    } catch (e) {
      print(e);
    }
  }
}