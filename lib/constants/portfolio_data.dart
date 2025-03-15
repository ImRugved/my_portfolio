class PortfolioData {
  static const String name = 'Rugved Belkundkar';
  static const String title = 'Senior Flutter Developer';
  static const String email = 'rugvedbelkundkar@gmail.com';
  static const String phone = '+91 9545724774';
  static const String location = 'Pune, Maharashtra';
  static const String about = '''
Senior Flutter Developer with proven expertise in building user-friendly mobile applications. Successfully deployed 5+ apps on Play Store and Apple App Store. Results-driven Flutter developer creating effective mobile solutions with strong technical skills. Focused on building user-friendly experiences that support business goals and technical innovation.
''';

  static const List<String> roles = [
    'Senior Flutter Developer',
    'Mobile App Specialist',
    'Cross-Platform Developer',
  ];

  static const List<Map<String, dynamic>> socialLinks = [
    {
      'name': 'LinkedIn',
      'url': 'https://www.linkedin.com/in/imrugved',
      'icon': 'linkedin',
    },
    {
      'name': 'GitLab',
      'url': 'https://gitlab.com/ImRugved',
      'icon': 'gitlab',
    },
    {
      'name': 'Email',
      'url': 'mailto:rugvedbelkundkar@gmail.com',
      'icon': 'envelope',
    },
    {
      'name': 'Phone',
      'url': 'tel:9545724774',
      'icon': 'phone',
    },
  ];

  static const List<Map<String, dynamic>> skills = [
    {
      'category': 'Technical Skills',
      'items': [
        'Flutter',
        'Dart',
        'Firebase',
        'RESTful APIs',
        'GetX',
        'Provider',
        'BLoC',
        'MVC',
        'MVVM',
        'SQFlite',
        'Shared Preferences',
        'Hive',
        'Get Storage',
        'Phone Payment SDK',
        'Razorpay',
        'FCM',
        'Rive',
        'Lottie',
      ],
    },
    {
      'category': 'Tools & Platforms',
      'items': [
        'Android Studio',
        'VS Code',
        'Xcode',
        'GitLab',
        'GitHub',
        'Shorebird CI/CD',
        'Firebase Console',
        'Play Store',
        'App Store',
      ],
    },
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'CoreText - Medical Updates',
      'description':
          'Medical news application delivering concise 60-word articles to healthcare professionals with personalized content delivery based on user-selected interests.',
      'image': 'https://cdn-icons-png.flaticon.com/512/2382/2382461.png',
      'technologies': ['Flutter', 'Firebase', 'Web View', 'GetX'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.coretext',
      'appStore': 'https://apps.apple.com/app/id123456789',
      'category': 'healthcare',
    },
    {
      'title': 'Indrayani - Educational App',
      'description':
          'Educational app with timed multiple-choice exams, secure payment integration, and comprehensive exam functionality including timers and detailed scorecards.',
      'image': 'https://cdn-icons-png.flaticon.com/512/2436/2436874.png',
      'technologies': ['Flutter', 'Razorpay', 'Firebase'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.indrayani',
      'appStore': 'https://apps.apple.com/app/id223456789',
      'category': 'education',
    },
    {
      'title': 'WorksJoy (HRMS)',
      'description':
          'Employee attendance and HR management system using Flutter and Firebase, boosting productivity by 35% with features like real-time punch-in/out and leave management.',
      'image': 'https://cdn-icons-png.flaticon.com/512/2906/2906274.png',
      'technologies': ['Flutter', 'Firebase', 'Location'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.worksjoy',
      'appStore': 'https://apps.apple.com/app/id987654321',
      'category': 'management',
    },
    {
      'title': 'Nishchinta (Canteen Management)',
      'description':
          'Comprehensive canteen management system with dynamic menu management, real-time dashboards, and flexible ordering capabilities.',
      'image': 'https://cdn-icons-png.flaticon.com/512/1147/1147805.png',
      'technologies': ['Flutter', 'Firebase', 'Real-time'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.nishchinta',
      'appStore': 'https://apps.apple.com/app/id323456789',
      'category': 'management',
    },
    {
      'title': 'Parking Management App',
      'description':
          'Multi-platform parking management system with QR code vehicle tracking, reducing entry time by 30% and checkout times by 50%.',
      'image': 'https://cdn-icons-png.flaticon.com/512/708/708949.png',
      'technologies': ['Flutter', 'QR Code', 'Billing'],
      'liveUrl': '#',
      'category': 'utility',
    },
    {
      'title': 'Alleviz Meeting',
      'description':
          'Flutter meeting app with secure authentication, scheduling capabilities, and collaborative tools for meeting creation with real-time notifications.',
      'image': 'https://cdn-icons-png.flaticon.com/512/1968/1968641.png',
      'technologies': ['Flutter', 'Real-time', 'Scheduling'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.allevizmeeting',
      'appStore': 'https://apps.apple.com/app/id523456789',
      'category': 'utility',
    },
    {
      'title': 'Site Survey Application',
      'description':
          'Flutter site survey app with REST API integration, product catalog and PDF management using GetX and MVC patterns.',
      'image': 'https://cdn-icons-png.flaticon.com/512/4300/4300059.png',
      'technologies': ['Flutter', 'REST API', 'PDF'],
      'liveUrl': '#',
      'playStore':
          'https://play.google.com/store/apps/details?id=com.example.sitesurvey',
      'appStore': 'https://apps.apple.com/app/id623456789',
      'category': 'utility',
    },
  ];

  static const List<Map<String, dynamic>> experience = [
    {
      'title': 'Sr. Flutter Developer',
      'company': 'TechTrail Technologies Pvt. Ltd.',
      'location': 'Pune',
      'duration': 'Dec 2024 - Present',
      'description': [
        'Developed 3 innovative mobile applications across education, healthcare, and medical communication sectors',
        'Implemented scalable Flutter solutions using Provider/Getx state management',
        'Engineered robust CI/CD pipelines and multi-environment Flutter flavors, reducing deployment time by 35%',
        'Integrated native functionalities via Kotlin and Flutter platform channels',
        'Created high-performance applications with optimized code structures',
      ],
    },
    {
      'title': 'Jr. Flutter Developer',
      'company': 'Daccess Security Systems Pvt Ltd',
      'location': 'Pune',
      'duration': 'Mar 2024 - Dec 2024',
      'description': [
        'Developed 5 high-impact mobile applications with increased user engagement',
        'Implemented MVC/MVVM patterns and BloC/GetX state management',
        'Integrated Google Maps and REST APIs, improved location accuracy by 45%',
        'Developed secure authentication systems using Firebase Authentication',
        'Leveraged Firebase Storage and Cloud Messaging for real-time data synchronization',
      ],
    },
    {
      'title': 'Flutter Development Intern',
      'company': 'Biencaps Systems Private Limited',
      'location': 'Pune',
      'duration': 'Sep 2023 - Feb 2024',
      'description': [
        'Mastered Dart and Flutter framework with extensive skills in mobile development',
        'Implemented diverse features to enhance UX through hands-on projects',
        'Gained expertise in Firebase integration and design methodologies',
        'Worked on real-world projects and learned industry best practices',
        'Completed comprehensive Flutter Development course on Udemy',
      ],
    },
    {
      'title': 'Flutter & Dart Certification',
      'company': 'Udemy',
      'location': 'Online',
      'duration': 'Dec 2023 - Feb 2024',
      'description': [
        'Completed comprehensive Flutter Development course, mastering Flutter, state management techniques, and cross-platform mobile application development.',
      ],
    },
  ];

  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'Bachelor\'s degree in Electrical Engineering',
      'institution': 'TSSM\'s Bhivarabai Sawant College, Pune University',
      'location': 'Pune, Maharashtra',
      'duration': '2019 - 2023',
      'gpa': '8.18/10',
    },
  ];

  static const List<String> interests = [
    'Mobile App Development',
    'UI/UX Design',
    'Cross-Platform Development',
    'Firebase Integration',
    'State Management',
    'Performance Optimization',
  ];

  static const Map<String, String> aboutMe = {
    'title': 'Flutter Developer & Mobile App Specialist',
    'description1':
        'I\'m a Senior Flutter Developer with extensive experience in building user-friendly mobile applications for Android and iOS platforms. With a strong focus on clean code and optimal performance, I\'ve successfully deployed multiple apps on Play Store and Apple App Store, revolutionizing operational efficiency and increasing user engagement.',
    'description2':
        'I graduated with a Bachelor\'s degree in Electrical Engineering from TSSM\'s Bhivarabai Sawant College, Pune University with a CGPA of 8.18. My technical journey began with an internship at Biencaps Systems, where I mastered Flutter and Dart, and I\'ve since grown into a Senior Flutter Developer creating innovative solutions across various domains.',
  };
}
