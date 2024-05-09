import 'package:flutter/material.dart';
import 'package:nutriaid/pages/base_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.youtube.com/embed/uaFXMdTGV30'));
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Educational Section",
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          titleCard("Learn about healthy eating and nutrition"),
          for (var item in educationalItems) buildInfoCard(item),
          videoSection(),
        ],
      ),
    );
  }

  Widget titleCard(String text) => Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
              color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.green.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget buildInfoCard(Map<String, String> item) => Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
              color: Color.fromARGB(255, 230, 230, 230), width: 2.0),
        ),
        child: ExpansionTile(
          title: Text(item["title"]!,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item["content"]!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      );

  Widget videoSection() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: [
              Text(
                "Watch this video to learn more:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 200,
                child: WebViewWidget(controller: _controller),
              ),
            ],
          ),
        ),
      );

  List<Map<String, String>> educationalItems = [
    {
      "title": "Why is Healthy Eating Important?",
      "content":
          "Healthy eating is essential for maintaining overall health and well-being. It provides the body with vital nutrients, supports immune function, and helps in the management of body weight. A balanced diet rich in fruits, vegetables, whole grains, and lean proteins can reduce the risk of chronic diseases such as heart disease, diabetes, and cancer. Additionally, healthy eating enhances mental health, improves energy levels, and contributes to better sleep patterns. By making informed food choices, individuals can not only extend their life expectancy but also improve the quality of their daily lives. Emphasizing the importance of healthy eating is crucial for long-term health and well-being.\n\nCheck out this video:\n https://www.youtube.com/watch?v=yTQ0tBmLbns"
    },
    {
      "title": "What constitutes to healthy eating?",
      "content":
          "Healthy eating involves consuming a varied diet that includes a balance of different food groups, providing the body with a range of essential nutrients. It primarily consists of incorporating ample fruits and vegetables, whole grains, lean proteins, and healthy fats into daily meals. Limiting processed foods, reducing sugar intake, and avoiding excessive fats and salts are also key aspects of a healthy diet. Furthermore, healthy eating is not just about choosing the right foods, but also about consuming them in the right proportions and at appropriate times to maintain good metabolic health and energy balance. Overall, a healthy diet supports bodily functions and promotes longevity, enabling individuals to lead an active and healthy lifestyle."
    },
    {
      "title": "What is Nutrition?",
      "content":
          "Nutrition is the science that interprets the interaction of nutrients and other substances in food in relation to maintenance, growth, reproduction, health, and disease of an organism. It includes food intake, absorption, assimilation, biosynthesis, catabolism, and excretion. A good nutritional diet provides the necessary energy and nutrients required for optimal bodily function. It involves the essential macronutrients like carbohydrates, proteins, and fats, which provide energy, as well as micronutrients like vitamins and minerals, which support various critical physiological processes. Understanding nutrition is crucial for making informed dietary choices that help maintain an overall healthy lifestyle and prevent nutritional deficiencies and chronic diseases.\n\n Check out this video:\n https://www.youtube.com/watch?v=zhnpopBvfNQ"
    },
    {
      "title": "What are Macronutrients?",
      "content":
          "Macronutrients are the nutrients that the body requires in large amounts to maintain essential functions and provide energy. They include carbohydrates, proteins, and fats, each serving unique and vital roles in our health. Carbohydrates are the primary source of energy for the body, particularly for the brain and central nervous system. Proteins are crucial for the growth and repair of body tissues, and they also play an integral role in immune responses and hormone production. Fats are important for long-term energy storage, insulation, and protection of vital organs, and they assist in the absorption of fat-soluble vitamins. A balanced intake of these macronutrients is essential for maintaining overall health and supporting bodily functions.\n\n Check out this video: \n https://www.youtube.com/watch?v=smPR215SRzM"
    },
    {
      "title": "Why are Macronutrients important?",
      "content":
          "Macronutrients are crucial for numerous bodily functions and overall health. Carbohydrates are the body's main source of fuel, essential for brain function, and energy for muscles during both rest and active states. Proteins are vital for the growth, repair, and maintenance of tissues, the production of enzymes and hormones, and they play a critical role in immune system responses. Fats are not only a dense source of energy but also necessary for the structural components of cells, the absorption of certain vitamins, and the production of important hormones. Together, these macronutrients support metabolic processes, sustain physical activities, and ensure the proper functioning of all bodily systems, making their balanced consumption key to health and well-being."
    },
    {
      "title": "What are micronutrients?",
      "content":
          "Micronutrients are essential vitamins and minerals that the body requires in small quantities for proper functioning, growth, and development. Unlike macronutrients, which are needed in large amounts, micronutrients are needed only in tiny doses, yet they are crucial for good health. Vitamins such as vitamin A, C, D, E, and K, along with B-complex vitamins, play key roles in energy production, immune function, and blood clotting, among other functions. Minerals like calcium, potassium, iron, and zinc are vital for bone health, nerve signaling, oxygen transport in the blood, and the regulation of fluid balance in the body. While they do not provide energy themselves, micronutrients support the biochemical processes by which macronutrients are converted into usable energy, making them indispensable for all life stages.\n\n Check out this video: \n https://www.youtube.com/watch?v=gwGr4N1BcLI"
    },
    {
      "title": "Why are micronutrients important?",
      "content":
          "Micronutrients are vital for optimal health, supporting a myriad of physiological functions that maintain the body's overall well-being. They play crucial roles in strengthening the immune system, supporting proper brain function, ensuring bone health, and synthesizing DNA. Moreover, micronutrients act as antioxidants, protecting cells from damage caused by free radicals, which can lead to chronic diseases such as cancer and heart disease. They are also essential for the effective metabolism of macronutrients, ensuring that the body can convert fats, proteins, and carbohydrates into energy efficiently. Inadequate intake of micronutrients can lead to deficiencies, resulting in a range of health issues, from impaired immune function and skin disorders to bone malformations and neurological problems. Thus, ensuring an adequate intake of these essential vitamins and minerals is fundamental for maintaining health and preventing disease."
    },
    {
      "title": "Difference between Macronutrients and Micronutrients?",
      "content":
          "Macronutrients and micronutrients are both essential for the body, but they differ fundamentally in their roles and the quantities required. Macronutrients, which include carbohydrates, proteins, and fats, are needed in larger amounts because they provide the energy necessary to fuel all bodily functions and activities. They are the main source of calories in the diet. In contrast, micronutrients, comprising vitamins and minerals, are required in much smaller quantities. While they do not provide energy themselves, micronutrients facilitate the body's use of macronutrients and support various critical physiological functions such as enzyme reactions, hormone synthesis, and cellular function. Both types of nutrients are crucial for maintaining health, but they serve distinctly different purposes within the body's biological processes."
    },
    {
      "title": "Understanding Calories",
      "content":
          "Calories are a measure of how much energy food provides. An adult's recommended daily calorie intake varies depending on factors such as age, metabolism, and physical activity level, but generally ranges from 2000 to 2500 calories."
    },
    {
      "title": "How can I measure my calorie intake?",
      "content":
          "Measuring calorie intake is a crucial aspect of managing dietary habits and maintaining a healthy lifestyle. To accurately track how many calories you consume, you can use several methods. One effective approach is to keep a food diary, where you log every item you eat throughout the day, using either a traditional notebook or a mobile app specifically designed for calorie tracking. Many of these apps come equipped with large databases of foods, allowing for precise calorie counting and nutritional analysis. Additionally, reading food labels carefully for calorie information and serving sizes can help you gauge the amount of calories in packaged foods. For homemade meals, using digital kitchen scales to weigh ingredients and consulting nutritional databases or apps that provide caloric values based on weight can offer a more accurate calorie count. Regularly updating and reviewing your food diary can provide insights into your dietary patterns and help you make informed decisions to achieve your nutrition goals."
    },
    {
      "title": "What is Portion Control?",
      "content":
          "Portion control is about understanding how much food is healthy for you to eat. Overeating, even healthy foods, can lead to weight gain and related health issues. Measuring portions can help manage calorie intake and maintain a healthy diet."
    },
    {
      "title": "Portion Control for the Long Run",
      "content":
          "Implementing portion control as a long-term strategy for healthy eating is vital for maintaining a balanced diet and preventing overeating. Effective portion control involves being mindful of the amounts of food you consume at each meal, which can help manage calorie intake without the need to drastically change your diet. Using smaller plates, bowls, and utensils can naturally limit portion sizes and help the mind perceive sufficient servings despite smaller quantities. It's also beneficial to understand serving sizes recommended by nutrition guidelines and measure your food during the initial phases until you're able to visually gauge portions accurately. Regularly practicing portion control can lead to better metabolic health, weight management, and an overall reduction in the risk of chronic diseases associated with overeating and obesity. Over time, these habits can become second nature, contributing to a lifelong commitment to good health."
    },
  ];
}
