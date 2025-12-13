class Category {
  final String id;
  final String name;
  final String icon; // emoji or text icon

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

final List<Category> categories = [
  Category(id: 'retail_chains', name: 'Retail Chains', icon: '🛒'),
  Category(id: 'automobile', name: 'Automobile', icon: '🚗'),
  Category(id: 'hotels_restaurant', name: 'Hotels & Restaurants', icon: '🍽️'),
  Category(id: 'fine_dine_cafe', name: 'Fine Dine & Cafe', icon: '🍵'),
  Category(id: 'qsr_caterers', name: 'Qsr & Caterers', icon: '👨‍🍳'),
  Category(id: 'real_estate', name: 'Real Estate', icon: '🏘️'),
  Category(id: 'corporates', name: 'Corporates', icon: '🏢'),
  Category(id: 'healthcare', name: 'Healthcare', icon: '🏥'),
  Category(id: 'education', name: 'Education', icon: '📚'),
  Category(id: 'finance_banking', name: 'Finance & Banking', icon: '💰'),
  Category(id: 'beauty_salon', name: 'Beauty/Salon', icon: '💅'),
  Category(id: 'fitness_gym', name: 'Fitness/Gym', icon: '💪'),
  Category(id: 'other', name: 'Other', icon: '💡'),
];

