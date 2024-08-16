import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/screens/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:elysia_app/providers/connect_provider.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.title});

  final String title;
  final String iconPath = AppConstants.elysiaIcon;

  @override
  Widget build(BuildContext context) {
    // final toastService = Provider.of<ToastService>(context, listen: false);
    final connectProvider = Provider.of<ConnectProvider>(context);
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectProvider.connectionSuccessful) {
        _showSuccessModal(context, connectProvider);
        connectProvider.resetConnectionState(); // Reset after showing the modal
      }
    });

    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(title),
      // ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  iconPath,
                  width: 64, // Adjust icon size as needed
                  height: 64,
                ),
                const SizedBox(height: 16), // Small gap
                ListTile(
                  title: Text('Roserah API', style: theme.textTheme.titleLarge, textAlign: TextAlign.center,),
                  subtitle: const Text(kReleaseMode ? 'Release Mode' : 'Dev Mode', style: TextStyle(color: Colors.amber), textAlign: TextAlign.center,),
                ),
                // const SizedBox(height: 8), // Small gap
                // const ListTile(
                //   title: Text('Connect to our online Server', textAlign: TextAlign.center,),
                //   subtitle: Text(kReleaseMode ? 'Release Mode' : 'Dev Mode', style: TextStyle(color: Colors.amber), textAlign: TextAlign.center,),
                // ),
                const SizedBox(height: 72), // Larger gap
                ElevatedButton.icon(
                      icon: connectProvider.isConnecting
                          ? const SizedBox(
                          width: 20, // Set the desired width
                          height: 20, // Set the desired height
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                          )
                            )
                          : const Icon(Icons.link),
                      label: Text(
                          connectProvider.isConnecting ? 'Connecting...' : 'Connect'),
                      onPressed: connectProvider.isConnecting
                          ? null
                          : () => connectProvider.connect(),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void _showSuccessModal(BuildContext context, ConnectProvider provider) {
  Map<String, dynamic>? data;

  if (!provider.connectionSuccessful) {
    // Optionally handle the case where connection was not successful
    return;
  } else {
    data = provider.data;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (BuildContext context) {
      return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        child: Wrap(
          children: <Widget>[
            Center(child: Image.asset(
              AppConstants.simmonsIcon,
              width: 48, // Adjust icon size as needed
              height: 48,
            ),),

            ListTile(
              title: Text('${data?['name']} Server'),
              subtitle: Text('Version ${data?['version'] ?? 'Unknown'}'),
            ),
            ListTile(
              title: const Text('Maintenance Mode'),
              subtitle: Text(data?["maintenance"] == 'true' ? 'Active' : 'Disabled'),
            ),
            ListTile(
              title: const Text('Cloud Provider'),
              subtitle: Text(data?["host"] ?? 'Restricted'),
            ),
            const ListTile(
              title:  Text('Host'),
              subtitle: Text(AppConstants.baseUrl),
            ),
            ListTile(
              title: const Text('Developer'),
              subtitle: Text(data?["creator"] ?? 'Unknown'),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const MainPage()));
                  },
                  child: const Text('Enter Server'),
                ),
              ),
            ),
          ]
        ),
      );
    },
  );
}