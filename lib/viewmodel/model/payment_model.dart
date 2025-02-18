class Payment {
  String? id;
  String? tenantId;
  String? description;
  String? paymentStatus;
  bool? paid;
  num? amountDue;
  num? lateFine;
  String? dueDate;
  num? paidAmount;
  num? totalAmount;
  String? paymentMethod;
  String? paymentDate;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? razorpayReceiptId;
  String? razorpaySignature;
  String? type;
  String? createdAt;
  String? updatedAt;

  Payment(
      {this.id,
      this.tenantId,
      this.description,
      this.paymentStatus,
      this.paid,
      this.amountDue,
      this.lateFine,
      this.dueDate,
      this.paidAmount,
      this.totalAmount,
      this.paymentMethod,
      this.paymentDate,
      this.razorpayOrderId,
      this.razorpayPaymentId,
      this.razorpayReceiptId,
      this.razorpaySignature,
      this.type,
      this.createdAt,
      this.updatedAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    description = json['description'];
    paymentStatus = json['payment_status'];
    paid = json['paid'];
    amountDue = json['amount_due'];
    lateFine = json['late_fine'];
    dueDate = json['due_date'];
    paidAmount = json['paid_amount'];
    totalAmount = json['total_amount'];
    paymentMethod = json['payment_method'];
    paymentDate = json['payment_date'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpayReceiptId = json['razorpay_receipt_id'];
    razorpaySignature = json['razorpay_signature'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenant_id'] = tenantId;
    data['description'] = description;
    data['payment_status'] = paymentStatus;
    data['paid'] = paid;
    data['amount_due'] = amountDue;
    data['late_fine'] = lateFine;
    data['due_date'] = dueDate;
    data['paid_amount'] = paidAmount;
    data['total_amount'] = totalAmount;
    data['payment_method'] = paymentMethod;
    data['payment_date'] = paymentDate;
    data['razorpay_order_id'] = razorpayOrderId;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['razorpay_receipt_id'] = razorpayReceiptId;
    data['razorpay_signature'] = razorpaySignature;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
