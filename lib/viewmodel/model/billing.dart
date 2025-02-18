class Billing {
  String? id;
  String? leaseId;
  String? tenantId;
  num? month;
  num? year;
  num? amountDue;
  num? monthDue;
  num? previousMonthDue;
  num? houseRent;
  num? garageRent;
  num? waterTax;
  num? otherTax;
  num? lateFine;
  num? arrearOutstanding;
  String? paymentStatus;
  String? paymentDate;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? razorpayReceiptId;
  String? razorpaySignature;
  String? razorpayDetails;
  bool? paid;
  String? dueDate;
  String? createdAt;
  String? updatedAt;

  Billing(
      {this.id,
      this.leaseId,
      this.tenantId,
      this.month,
      this.year,
      this.amountDue,
      this.monthDue,
      this.previousMonthDue,
      this.houseRent,
      this.garageRent,
      this.waterTax,
      this.otherTax,
      this.lateFine,
      this.arrearOutstanding,
      this.paymentStatus,
      this.paymentDate,
      this.razorpayOrderId,
      this.razorpayPaymentId,
      this.razorpayReceiptId,
      this.razorpaySignature,
      this.razorpayDetails,
      this.paid,
      this.dueDate,
      this.createdAt,
      this.updatedAt});

  Billing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaseId = json['lease_id'];
    tenantId = json['tenant_id'];
    month = json['month'];
    year = json['year'];
    amountDue = json['amount_due'];
    monthDue = json['month_due'];
    previousMonthDue = json['previous_month_due'];
    houseRent = json['house_rent'];
    garageRent = json['garage_rent'];
    waterTax = json['water_tax'];
    otherTax = json['other_tax'];
    lateFine = json['late_fine'];
    arrearOutstanding = json['arrear_outstanding'];
    paymentStatus = json['payment_status'];
    paymentDate = json['payment_date'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpayReceiptId = json['razorpay_receipt_id'];
    razorpaySignature = json['razorpay_signature'];
    razorpayDetails = json['razorpay_details'];
    paid = json['paid'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lease_id'] = leaseId;
    data['tenant_id'] = tenantId;
    data['month'] = month;
    data['year'] = year;
    data['amount_due'] = amountDue;
    data['month_due'] = monthDue;
    data['previous_month_due'] = previousMonthDue;
    data['house_rent'] = houseRent;
    data['garage_rent'] = garageRent;
    data['water_tax'] = waterTax;
    data['other_tax'] = otherTax;
    data['late_fine'] = lateFine;
    data['arrear_outstanding'] = arrearOutstanding;
    data['payment_status'] = paymentStatus;
    data['payment_date'] = paymentDate;
    data['razorpay_order_id'] = razorpayOrderId;
    data['razorpay_payment_id'] = razorpayPaymentId;
    data['razorpay_receipt_id'] = razorpayReceiptId;
    data['razorpay_signature'] = razorpaySignature;
    data['razorpay_details'] = razorpayDetails;
    data['paid'] = paid;
    data['due_date'] = dueDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
