class StudentsRawData {
  Map<String, dynamic> data = {
    "10001": {
      "name": "Pankaj Mishra",
      "class": 10,
      "coursesTaken": [
        "English",
        "Hindi",
        "Maths",
        "Science",
        "Social Science",
      ],
      "attendance": "92%",
      "upcomingTests": [
        {"subject": "English", "date": "20-07-2025"},
        {"subject": "Maths", "date": "23-07-2025"},
      ],
    },

    "10002": {
      "name": "Anjali Verma",
      "class": 9,
      "coursesTaken": ["English", "Maths", "Biology", "Computer Science"],
      "attendance": "88%",
      "upcomingTests": [
        {"subject": "Biology", "date": "21-07-2025"},
        {"subject": "Maths", "date": "24-07-2025"},
      ],
    },

    "10003": {
      "name": "Rohan Mehta",
      "class": 11,
      "coursesTaken": ["Physics", "Chemistry", "Maths", "English"],
      "attendance": "95%",
      "upcomingTests": [
        {"subject": "Physics", "date": "19-07-2025"},
        {"subject": "Chemistry", "date": "22-07-2025"},
      ],
    },

    "10004": {
      "name": "Sneha Kapoor",
      "class": 8,
      "coursesTaken": ["Maths", "English", "Social Science", "Hindi"],
      "attendance": "85%",
      "upcomingTests": [
        {"subject": "Social Science", "date": "20-07-2025"},
        {"subject": "Hindi", "date": "25-07-2025"},
      ],
    },

    "10005": {
      "name": "Aryan Singh",
      "class": 12,
      "coursesTaken": ["Maths", "Physics", "Computer Science", "English"],
      "attendance": "97%",
      "upcomingTests": [
        {"subject": "Computer Science", "date": "21-07-2025"},
        {"subject": "Maths", "date": "26-07-2025"},
      ],
    },
  };

  Map<String, dynamic> getAllStudentData() {
    return data;
  }

  Map<String, dynamic>? getUserById(String id){
    if(data.containsKey(id)) return data[id];
    return null;
  }
}
