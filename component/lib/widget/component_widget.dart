import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DraggableComposeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Compose Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 239, 237, 244),
        ),
        body: QuadrantComponent(),
      ),
    );
  }
}

class QuadrantComponent extends StatefulWidget {
  @override
  _QuadrantComponentState createState() => _QuadrantComponentState();
}

class _QuadrantComponentState extends State<QuadrantComponent> {
  String show = "";
  Map<String, List<String>> quadrantItems = {
    'Quadrant 1': [],
    'Quadrant 2': [],
    'Quadrant 3': [],
    'Quadrant 4': [],
  };

  final List<String> draggableItems = [
    'i have Meeting',
    ' beacome a Developer',
    'become a Designer',
    'Manager'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background GIF
        Positioned.fill(
          child: Image.asset(
            'assets/rainforest.gif', // Add your GIF path here
            fit: BoxFit.cover,
          ),
        ),
        // Foreground Content
        Container(
          decoration: BoxDecoration(
              // If you still want to keep the static image option, uncomment the lines below:
              // image: DecorationImage(
              //   image: AssetImage('assets/background.jpg'),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: Column(
            children: [
              // Draggable Items at the Top
              Container(
                height: 70,
                color: Colors.grey.shade200
                    .withOpacity(0.7), // Semi-transparent background
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: draggableItems.length,
                  itemBuilder: (context, index) {
                    final item = draggableItems[index];
                    return Draggable<String>(
                      data: item,
                      feedback: DraggingItem(item: item),
                      childWhenDragging: Opacity(
                        opacity: 0.3,
                        child: DraggableItem(item: item),
                      ),
                      child: DraggableItem(item: item),
                    );
                  },
                ),
              ),
              // Quadrant Layout
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: show == "Quadrant 1"
                                  ? Lottie.asset(
                                      'assets/jsons/Animation-green.json',
                                      width: 150.0, // Adjust width
                                      height: 100.0,
                                    )
                                  : buildQuadrant('Quadrant 1'),
                            ),
                            Expanded(
                              child: show == "Quadrant 2"
                                  ? Lottie.asset(
                                      'assets/jsons/Animation-white.json',
                                      width: 100.0, // Adjust width
                                      height: 100.0,
                                    )
                                  : buildQuadrant('Quadrant 2'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: show == "Quadrant 3"
                                  ? Lottie.asset(
                                      'assets/jsons/Animation -yellow.json',
                                      width: 100.0, // Adjust width
                                      height: 100.0,
                                    )
                                  : buildQuadrant('Quadrant 3'),
                            ),
                            Expanded(
                              child: show == "Quadrant 4"
                                  ? Lottie.asset('assets/jsons/Animation.json',
                                      width: 100.0, height: 100.0)
                                  : buildQuadrant('Quadrant 4'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildQuadrant(String label) {
    return DragTarget<String>(
      onAcceptWithDetails: (data) {
        setState(() {
          show = label;
          quadrantItems[label]?.add(data.data);

          // Reset show after 12 seconds
          Future.delayed(Duration(seconds: 12), () {
            setState(() {
              show = "";
            });
          });
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: EdgeInsets.all(8.0),
          width: 160.0, // Smaller width for the circle
          height: 160.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 47, 220, 16),
            // borderRadius: BorderRadius.circular(1.0),
            border: Border.all(
              color: const Color.fromARGB(255, 219, 216, 225),
              width: 1,
            ),
          ),
          child: Center(
            child: quadrantItems[label]!.isEmpty
                ? Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Display the list of items in the quadrant
                      Column(
                        children: quadrantItems[label]!
                            .map((item) => Text(
                                  item,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Items: ${quadrantItems[label]!.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

// Widget for draggable item
class DraggableItem extends StatelessWidget {
  final String item;

  const DraggableItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          // Flower Icon
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(image: AssetImage('assets/flower.png'))),
          ),
          SizedBox(width: 8.0),
          // Task Name
          Text(
            item,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for dragging feedback
class DraggingItem extends StatelessWidget {
  final String item;

  const DraggingItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            // Flower Image
            Image.asset(
              'assets/flower.png', // Path to your custom flower image
              width: 20,
              height: 20,
            ),
            SizedBox(width: 8.0),
            Text(
              item,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
