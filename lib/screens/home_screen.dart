import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/province_model.dart';
import 'package:elysia_app/providers/home_provider.dart';
import 'package:elysia_app/services/hive_service.dart';
import 'package:elysia_app/widgets/custom_card.dart';
import 'package:elysia_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String title = 'Home';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    // final theme = Theme.of(context);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!provider.isLoading) {
    //     provider.fetchProvinces();
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(provider.isGridView ? Icons.grid_on : Icons.list),
                      onPressed: () {
                        provider.toggleView();
                      },
                    ),
                  ],
                ),
              ),
              // Scrollable List/Grid View
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    if(provider.isLoading){
                      return Center(child: textLoader('Fetching content...'));
                    } else if (provider.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Failed to load data'),
                          const SizedBox(height: 8.0),
                          TextButton.icon(
                            icon: provider.isLoading
                                ? const SizedBox(
                                      width: 20, // Set the desired width
                                      height: 20, // Set the desired height
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                                      )
                                  )
                                : const Icon(Icons.heart_broken_outlined),
                              onPressed: () => provider.fetchProvinces(),
                              label: const Text('Try again')
                          )
                        ],
                      );
                    } else if (provider.provinces  == []) {
                      return const Center(child: Text('No data available'));
                    } else {
                      final List<Province> provinces = provider.provinces;

                      return provider.isGridView
                            ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                          ),
                          itemCount: provinces.length,
                          itemBuilder: (context, index) {
                            final province = provinces[index];
                            return InkWell(onTap: () => _showDetailModal(context, province), child:customCard(index, province.name, province.districts.length, province.image));
                          },
                        )
                            : ListView.builder(
                                  itemCount: provinces.length,
                                  itemBuilder: (context, index) {
                                    final province = provinces[index];
                                    return customList(index, province.name, province.districts.length, province.image, ()=>_showDetailModal(context, province));
                                  },
                            );
                        }
                  },
                ),
              )
            ],
          ),
    );
  }
}

void _showDetailModal(BuildContext context, Province province) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: province.image != null
                      ? Image.network(
                    province.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => fallbackThumbnail(),
                  )
                      : fallbackThumbnail(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Text(
                province.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                      'Districts: ${province.districts.length}',
                      style: const TextStyle(fontSize: 16, color: Colors.white54),
                    ),),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(), // Disable scroll for GridView
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      childAspectRatio: 3, // Adjust height of grid items
                    ),
                    itemCount: province.districts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(province.districts[index].name),
                      );
                    },
                  ),
                ),
              // Close button at the bottom
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),

      );
    },
  );
}
