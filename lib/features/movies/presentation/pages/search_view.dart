 
import 'package:movie_hive/core/utills/app_imports.dart';
import 'package:movie_hive/features/movies/presentation/controllers/search_movie_controller.dart';
 

class SearchView extends GetView<SearchMovieController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground, // AppColors.scaffoldBackground
      body: SafeArea(
        child: Column(
          children: [
            //   Search Bar 
            Padding(
              padding: EdgeInsets.all(15.w),
              child: TextField(
                controller: controller.searchTextController,
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: Colors.grey.shade600,
                cursorWidth: 1.2.w,
                cursorHeight: 18.h,
                onChanged: (val) => controller.searchText.value = val,
                decoration: InputDecoration(
                  hintText: "Search Movies...",
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 0.5.w,
                    ),
                  ),
                  fillColor: Colors.grey.shade900,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.sp,
                    color: Colors.grey,
                  ),
                  // Clear Button logic
                  suffixIcon: Obx(
                    () => controller.searchText.value.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 18.sp,
                              color: AppColors.textPrimary,
                            ),
                            onPressed: () => controller.clearSearch(),
                          )
                        : const SizedBox.shrink(),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade800,
                      width: 0.5.w,
                    ),
                  ),
                ),
              ),
            ),

            //   Results Area  
            Expanded(
              child: Obx(() {
               
                if (controller.isloadingSearch.value) {
                  return GridView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,  
                                      childAspectRatio: 0.65,  
                                      mainAxisSpacing: 15.h,
                                      crossAxisSpacing: 15.w,
                                    ),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                       return ShimmerLoader(height: double.infinity, width: double.infinity,);
                                    },
                                  );
                }

                 if (controller.iserror.value) {
                  return Center(
                    child: TextWidget(
                   text: controller.errorMessage.value,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500, 
                    fontSize: 16.sp,
                    maxLines: 3,
                    ),
                  );
                }

                 
                if (controller.searchText.value.isEmpty) {
                  return _buildMessage(
                    Icons.movie_creation_outlined,
                    "Search for your favorite movies",
                  );
                }

                if (controller.searchResult.isEmpty) {
                  return _buildMessage(
                    Icons.search_off,
                    "No movies found for '${controller.searchText.value}'",
                  );
                }
                  return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,  
                    childAspectRatio: 0.65,  
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 15.w,
                  ),
                  itemCount: controller.searchResult.length,
                  itemBuilder: (context, index) {
                    final movie = controller.searchResult[index];
                    return MovieGridCard(movie: movie);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildMessage(IconData icon, String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80.sp, color: Colors.grey.shade800),
          SizedBox(height: 10.h),
          TextWidget(
           text:  msg,
             color: AppColors.textSecondary, fontWeight: FontWeight.w500 ,fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}
