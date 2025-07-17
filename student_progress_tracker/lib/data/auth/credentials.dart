class Credentials{
  Map<String, String> data = {
  "10001": "pankaj@2025",
  "10002": "anjali#8821",
  "10003": "rohanM95!",
  "10004": "sneha_85ss",
  "10005": "aryan!cs12"
};

bool userFound(String id){
  return data.containsKey(id);
}

bool isCorrect(String id, String pass){
  return data[id]==pass;
}
}