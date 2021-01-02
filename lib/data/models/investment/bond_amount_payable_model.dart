class AmountPayableResponse{
  int fundingAmount;
  String principalRepayment;
  int numberOfInterestPaymentLeft;
  String periodicInterest;
  String interest;
  String totalCashOut;
  int unit;
  String pricePerUnit;
  String cost;
  String fee;
  String totalCost;
  String totalInterest;
  int faceValue;
  int instrumentType;
  int productId;
  num investmentAmount;
  num rateValue;
  bool upFront;
  String transactionFee;
  String annualCustodyFee;
  int firstCouponDay;
  int secondCouponDay;
  String firstCouponMonth;
  String secondCouponMonth;

  AmountPayableResponse(
      {this.fundingAmount,
      this.principalRepayment,
      this.numberOfInterestPaymentLeft,
      this.periodicInterest,
      this.interest,
      this.totalCashOut,
      this.unit,
      this.pricePerUnit,
      this.cost,
      this.fee,
      this.totalCost,
      this.totalInterest,
      this.faceValue,
      this.instrumentType,
      this.productId,
      this.investmentAmount,
      this.rateValue,
      this.upFront,
      this.transactionFee,
      this.annualCustodyFee,
      this.firstCouponDay,
      this.secondCouponDay,
      this.firstCouponMonth,
      this.secondCouponMonth});

  AmountPayableResponse.fromJson(Map<String, dynamic> json) {
    fundingAmount = json['fundingAmount'];
    principalRepayment = json['principalRepayment'];
    numberOfInterestPaymentLeft = json['numberOfInterestPaymentLeft'];
    periodicInterest = json['periodicInterest'];
    interest = json['interest'];
    totalCashOut = json['totalCashOut'];
    unit = json['unit'];
    pricePerUnit = json['pricePerUnit'];
    cost = json['cost'];
    fee = json['fee'];
    totalCost = json['totalCost'];
    totalInterest = json['totalInterest'];
    faceValue = json['faceValue'];
    instrumentType = json['instrumentType'];
    productId = json['productId'];
    investmentAmount = json['investmentAmount'];
    rateValue = json['rateValue'];
    upFront = json['upFront'];
    transactionFee = json['transactionFee'];
    annualCustodyFee = json['annualCustodyFee'];
    firstCouponDay = json['firstCouponDay'];
    secondCouponDay = json['secondCouponDay'];
    firstCouponMonth = json['firstCouponMonth'];
    secondCouponMonth = json['secondCouponMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fundingAmount'] = this.fundingAmount;
    data['principalRepayment'] = this.principalRepayment;
    data['numberOfInterestPaymentLeft'] = this.numberOfInterestPaymentLeft;
    data['periodicInterest'] = this.periodicInterest;
    data['interest'] = this.interest;
    data['totalCashOut'] = this.totalCashOut;
    data['unit'] = this.unit;
    data['pricePerUnit'] = this.pricePerUnit;
    data['cost'] = this.cost;
    data['fee'] = this.fee;
    data['totalCost'] = this.totalCost;
    data['totalInterest'] = this.totalInterest;
    data['faceValue'] = this.faceValue;
    data['instrumentType'] = this.instrumentType;
    data['productId'] = this.productId;
    data['investmentAmount'] = this.investmentAmount;
    data['rateValue'] = this.rateValue;
    data['upFront'] = this.upFront;
    data['transactionFee'] = this.transactionFee;
    data['annualCustodyFee'] = this.annualCustodyFee;
    data['firstCouponDay'] = this.firstCouponDay;
    data['secondCouponDay'] = this.secondCouponDay;
    data['firstCouponMonth'] = this.firstCouponMonth;
    data['secondCouponMonth'] = this.secondCouponMonth;
    return data;
  }
}



class AmountPayableError{
  bool status;
  String message;
  List<String> errors;
  String traceId;

  AmountPayableError({this.status, this.message, this.errors, this.traceId});

  AmountPayableError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errors = json['errors'].cast<String>();
    traceId = json['traceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errors'] = this.errors;
    data['traceId'] = this.traceId;
    return data;
  }
}