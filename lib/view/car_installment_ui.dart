import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // ✅ เพิ่ม

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController interestCtrl = TextEditingController();

  int downPercent = -1; // ยังไม่เลือก
  String month = "24";
  double result = 0.00;

  // ✅ format เงิน
  final formatter = NumberFormat("#,##0.00");

  void calculate() {
    // ===== Validate =====
    if (priceCtrl.text.isEmpty ||
        interestCtrl.text.isEmpty ||
        downPercent == -1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("แจ้งเตือน"),
          content:
              const Text("กรุณาป้อนราคารถ เลือกเงินดาวน์ และดอกเบี้ยให้ครบ"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ตกลง"),
            )
          ],
        ),
      );
      return;
    }

    double price = double.parse(priceCtrl.text);
    double interest = double.parse(interestCtrl.text);
    int months = int.parse(month);

    // ===== สูตรคำนวณ =====
    double downPayment = price * downPercent / 100;
    double loan = price - downPayment;

    double totalInterest = (loan * interest / 100) * (months / 12);
    double total = loan + totalInterest;

    result = total / months;

    setState(() {});
  }

  void reset() {
    priceCtrl.clear();
    interestCtrl.clear();
    downPercent = -1;
    month = "24";
    result = 0.00;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 192, 220),
        title: const Text("CI Calculator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "คำนวณค่างวดรถ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // รูป
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 98, 192, 220),
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/Car.png',
                    height: 150,
                  ),
                ),

                const SizedBox(height: 20),

                // ราคา
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ราคารถ (บาท)")),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "0.00",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ดาวน์
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("จำนวนเงินดาวน์ (%)")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [10, 20, 30, 40, 50].map((e) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: e,
                          groupValue: downPercent,
                          onChanged: (v) => setState(() => downPercent = v!),
                        ),
                        Text("$e"),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // งวด
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ระยะเวลาผ่อน (เดือน)")),
                SizedBox(
                  width: 400,
                  child: DropdownButtonFormField(
                    value: month,
                    items: ["24", "36", "48", "60", "72"]
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text("$e เดือน")))
                        .toList(),
                    onChanged: (v) => setState(() => month = v!),
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),

                const SizedBox(height: 20),

                // ดอกเบี้ย
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("อัตราดอกเบี้ย (%/ปี)")),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: interestCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "0.00",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ปุ่ม
                SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 98, 192, 220)),
                          onPressed: calculate,
                          child: const Text("คำนวณ"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange),
                          onPressed: reset,
                          child: const Text("ยกเลิก"),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ===== ผลลัพธ์ =====
                SizedBox(
                  width: 400,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Text("ค่างวดรถต่อเดือนเป็นเงิน"),
                        Text(
                          formatter.format(result),
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("บาทต่อเดือน"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
