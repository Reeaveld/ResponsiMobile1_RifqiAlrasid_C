class Anggaran {
  int? id;
  String? budgetItem;
  int? allocated;
  int? spent;

  Anggaran({this.id, this.budgetItem, this.allocated, this.spent});

  factory Anggaran.fromJson(Map<String, dynamic> obj) {
    return Anggaran(
      id: obj['id'],
      budgetItem: obj['budget_item'],
      allocated: obj['allocated'],
      spent: obj['spent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'budget_item': budgetItem,
      'allocated': allocated,
      'spent': spent,
    };
  }
}
