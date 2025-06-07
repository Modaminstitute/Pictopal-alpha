final Map<String, String> syllableMap = {
  // Animals - One syllable
  'Cat': 'Cat',
  'Dog': 'Dog',
  'Pig': 'Pig',
  'Cow': 'Cow',
  'Bee': 'Bee',
  'Fish': 'Fish',

  // Animals - Two syllables
  'Rabbit': 'Rab-bit',
  'Monkey': 'Mon-key',
  'Tiger': 'Ti-ger',
  'Chicken': 'Chick-en',
  'Penguin': 'Pen-guin',
  'Dolphin': 'Dol-phin',

  // Animals - Three syllables
  'Elephant': 'El-e-phant',
  'Kangaroo': 'Kan-ga-roo',
  'Butterfly': 'But-ter-fly',
  'Dinosaur': 'Di-no-saur',
  'Alligator': 'Al-li-ga-tor',
  'Octopus': 'Oc-to-pus',

  // Fruits - One syllable
  'Grape': 'Grape',
  'Peach': 'Peach',
  'Plum': 'Plum',
  'Lime': 'Lime',
  'Date': 'Date',
  'Fig': 'Fig',

  // Fruits - Two syllables
  'Apple': 'Ap-ple',
  'Orange': 'Or-ange',
  'Banana': 'Ba-na-na',
  'Mango': 'Man-go',
  'Lemon': 'Lem-on',
  'Cherry': 'Cher-ry',

  // Fruits - Three syllables
  'Strawberry': 'Straw-ber-ry',
  'Pineapple': 'Pine-ap-ple',
  'Watermelon': 'Wa-ter-mel-on',
  'Blueberry': 'Blue-ber-ry',
  'Raspberry': 'Rasp-ber-ry',
  'Avocado': 'Av-o-ca-do',

  // Objects - One syllable
  'Ball': 'Ball',
  'Book': 'Book',
  'Cup': 'Cup',
  'Hat': 'Hat',
  'Key': 'Key',
  'Pen': 'Pen',

  // Objects - Two syllables
  'Table': 'Ta-ble',
  'Chair': 'Chair',
  'Window': 'Win-dow',
  'Bottle': 'Bot-tle',
  'Pencil': 'Pen-cil',
  'Ruler': 'Ru-ler',

  // Objects - Three syllables
  'Computer': 'Com-pu-ter',
  'Telephone': 'Tel-e-phone',
  'Umbrella': 'Um-brel-la',
  'Bicycle': 'Bi-cy-cle',
  'Camera': 'Cam-e-ra',
  'Calendar': 'Cal-en-dar',

  // Colors - One syllable
  'Red': 'Red',
  'Blue': 'Blue',
  'Green': 'Green',
  'Pink': 'Pink',
  'Black': 'Black',
  'White': 'White',

  // Colors - Two syllables
  'Yellow': 'Yel-low',
  'Purple': 'Pur-ple',
  'Silver': 'Sil-ver',
  'Golden': 'Gold-en',
  'Brown': 'Brown',

  // Colors - Three syllables
  'Magenta': 'Ma-gen-ta',
  'Turquoise': 'Tur-quoise',
  'Burgundy': 'Bur-gun-dy',
  'Lavender': 'Lav-en-der',
  'Maroon': 'Ma-roon',
  'Crimson': 'Crim-son',
};

String getSyllablePronunciation(String word) {
  return syllableMap[word] ?? word;
}