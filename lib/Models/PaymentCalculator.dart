enum PaymentPlan { monthly, yearly }

class PaymentCalculator {
  static double calculatePayment(
      PaymentPlan plan, DateTime startDate, DateTime endDate) {
    int differenceInMonths = _differenceInMonths(startDate, endDate);

    if (plan == PaymentPlan.monthly) {
      return differenceInMonths * monthlyPrice;
    } else if (plan == PaymentPlan.yearly) {
      return differenceInMonths ~/ 12 * yearlyPrice;
    }

    return 0;
  }

  static int _differenceInMonths(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + end.month - start.month;
  }
}

// Örnek fiyatlar
const double monthlyPrice = 10.0;
const double yearlyPrice = 100.0;

// // Kullanım örneği
// DateTime startDate = DateTime(2024, 4, 1); // Başlangıç tarihi
// DateTime endDate = DateTime(2024, 8, 1); // Bitiş tarihi
// PaymentPlan selectedPlan = PaymentPlan.yearly; // Kullanıcının seçtiği ödeme planı

// double paymentAmount = PaymentCalculator.calculatePayment(selectedPlan, startDate, endDate);
// print('Ödeme tutarı: \$${paymentAmount.toStringAsFixed(2)}'); // Ödeme tutarını yazdır
