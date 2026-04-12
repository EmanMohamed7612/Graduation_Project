import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/data/service_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/feauture/session/view/my_consultation.dart';
import 'package:graduation2/feauture/session/view/widgets/service_card.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class BookingConsultationScreen extends StatefulWidget {
  final String expertId;

  const BookingConsultationScreen({super.key, required this.expertId});
  @override
  _BookingConsultationScreenState createState() =>
      _BookingConsultationScreenState();
}

class _BookingConsultationScreenState extends State<BookingConsultationScreen> {
  int currentStep = 1; // الحالة اللي بتتحكم في الـ AppBar والـ Body مع بعض
  String? selectedDate; // غيرنا القيمة من "14" لـ null
  String? selectedTime; // غيرنا القيمة من "9:00 AM" لـ null
  String? selectedPaymentMethod; // لحفظ وسيلة الدفع المختارة (null في البداية)
  // String? selectedService;
  ServiceModel? selectedService;
  TimeSlotModel? selectedSlot;

  @override
  void initState() {
    super.initState();
    // context.read<ExpertServiceCubit>().fetchExpertServices(widget.expertId);
    context.read<ExpertServiceCubit>().fetchInitialData(widget.expertId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print('expert id : ${widget.expertId}');
    return BlocListener<ExpertServiceCubit, ExpertServiceState>(
      listener: (context, state) {
        if (state is ExpertServiceSuccess) {
          // إظهار رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        // نقوم بإنشاء نسخة جديدة من الـ Cubit للشاشة الجديدة
        create: (context) => ExpertServiceCubit(), 
        child: MyConsultationScreen(), // تأكد من استخدام الاسم الصحيح للكلاس
      ),
    ),
    (route) => route.isFirst,
  );
          // يمكنك هنا العودة للصفحة الرئيسية أو صفحة الحجوزات
          // Navigator.pop(context);
        } else if (state is ExpertServiceError) {
          // إظهار رسالة خطأ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: CircleAvatar(
            backgroundColor: Color(0xffEFEBE9),
            child: IconButton(
              // استخدمنا IconButton ليكون شكل الضغط أفضل
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff6D4C41),
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  if (currentStep > 1) {
                    // لو هو في صفحة 2 أو 3 يرجع خطوة لورا
                    currentStep--;
                  } else {
                    // لو هو في أول صفحة يخرج من الشاشة خالص
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
          title: Text(
            LocaleKeys.bookConsultation.tr(),
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 20,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          // الـ Indicator هنا هيفضل ثابت في الـ AppBar
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Column(
              children: [_buildStepIndicator(), SizedBox(height: 15)],
            ),
          ),
        ),

        body: Column(
          children: [
            // الجزء المتغير بناءً على الخطوة
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildCurrentStepContent(),
              ),
            ),

            // زرار الـ Action ثابت دائماً في أسفل الشاشة
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  // --- Widgets الـ Step Indicator (في الـ AppBar) ---
  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stepCircle("1", active: currentStep >= 1, isDone: currentStep > 1),
        _line(active: currentStep >= 2),
        _stepCircle("2", active: currentStep >= 2, isDone: currentStep > 2),
        _line(active: currentStep >= 3),
        _stepCircle("3", active: currentStep >= 3, isDone: false),
      ],
    );
  }

  Widget _stepCircle(
    String text, {
    required bool active,
    required bool isDone,
  }) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: active ? Color(0xFF6D4C41) : Color(0xFFF5F5F5),
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? Color(0xFF6D4C41) : Colors.grey[300]!,
        ),
      ),
      child: Center(
        child: isDone
            ? Icon(Icons.check, color: Colors.white, size: 16)
            : Text(
                text,
                style: TextStyle(
                  color: active ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _line({required bool active}) {
    return Container(
      width: 40,
      height: 2,
      color: active ? Color(0xFF6D4C41) : Colors.grey[300],
    );
  }

  // --- التحكم في محتوى الـ Body ---
  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 1:
        return _buildServiceSelection();
      case 2:
        return _buildDateTimeSelection();
      case 3:
        return _buildPaymentSummary();
      default:
        return _buildServiceSelection();
    }
  }

  // --- محتويات الصفحات (عشان الكود يشتغل معاكي فوراً) ---

  // الصفحة 1
  Widget _buildServiceSelection() {
    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      buildWhen: (previous, current) =>
          current is ExpertServicesLoaded || current is ExpertServiceLoading,
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExpertServiceError) {
          return Center(child: Text(state.error));
        } else if (state is ExpertServicesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.selectServiceType.tr(),
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 15.75,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.services.length,
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  var service = state.services[index];
                  // bool isThisSelected = selectedService == service.title;
                  bool isThisSelected = selectedService?.id == service.id;
                  return GestureDetector(
                    onTap: () {
                      //   selectedService = isThisSelected ? null : service.title;
                      //   // نصيحة: يفضل تخزني الـ service.id مش الـ title بس عشان الحجز
                      // });
                      // داخل itemBuilder بتاع الخدمات:

                      setState(() {
                        selectedService = (selectedService?.id == service.id)
                            ? null
                            : service;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isThisSelected
                              ? const Color(0xFF6D4C41)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ServiceCard(
                        title: service.title,
                        time: "${service.durationInMinutes} min",
                        price: "${service.price} EGP",
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  // الصفحة 3
  Widget _buildPaymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.paymentSummary.tr(),
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 15.75,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20),

        // كارت تفاصيل الحجز
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xFFEFEBE9)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              // _summaryRow("Service", "Portfolio Review"),
              // Divider(height: 30),
              // _summaryRow("Date & Time", "Oct 13, 9:00 AM"),
              // Divider(height: 30),
              _summaryRow("Service", selectedService?.title ?? ""),
              _summaryRow(
                "Date & Time",
                "${selectedSlot?.date} , ${selectedSlot?.startTime}",
              ),
              // السعر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${selectedService?.price ?? 0} EGP",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 30),
        Text(
          LocaleKeys.paymentMethod.tr(),
          style: TextStyle(
            color: const Color(0xFF8D6E63),
            fontSize: 12.25,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 15),

        // اختيار وسيلة الدفع
        _paymentOption(LocaleKeys.creditCard.tr(), Icons.credit_card),
        SizedBox(height: 10),
        _paymentOption(LocaleKeys.applePay.tr(), Icons.apple),
      ],
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF8D6E63),
            fontSize: 12.25,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 12.25,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _paymentOption(String title, IconData icon) {
    // فحص هل هذه الوسيلة هي المختارة حالياً
    bool isSelected = selectedPaymentMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          // لو ضغط على المختار يلغيه، ولو ضغط على جديد يختاره
          selectedPaymentMethod = isSelected ? null : title;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // خلفية بيضاء دائمًا أو حسب التصميم
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            // تغيير اللون للبني لو مختار، ورمادي خفيف لو لا
            color: isSelected ? const Color(0xFF6D4C41) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xff6D4C41) : Colors.black,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Arimo',
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? const Color(0xFF3E2723) : Colors.black,
              ),
            ),
            const Spacer(),
            // علامة الاختيار الدائرية
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF6D4C41)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF6D4C41) : Colors.grey,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // الزر السفلي
  Widget _buildBottomButton() {
    // فحص هل الزرار مفعّل أم لا بناءً على الخطوة والاختيار
    bool isEnabled = true;

    if (currentStep == 1) {
      // الصفحة الأولى: لازم يختار خدمة
      isEnabled = selectedService != null;
    } else if (currentStep == 2) {
      // الصفحة الثانية: لازم يختار تاريخ وكمان وقت
      isEnabled = selectedDate != null && selectedTime != null;
      // context.read<ExpertServiceCubit>().fetchTimeSlots(widget.expertId);
    } else if (currentStep == 3) {
      // الزر لن يعمل في الصفحة الثالثة إلا إذا تم اختيار وسيلة دفع
      isEnabled = selectedPaymentMethod != null;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5, // يوضح للمستخدم إن الزرار معطل
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6D4C41),
                const Color(0xFF6F4E43),
                const Color(0xFF725146),
                const Color(0xFF745348),
                const Color(0xFF76564A),
                const Color(0xFF78584D),
                const Color(0xFF7B5A4F),
                const Color(0xFF7D5D52),
                const Color(0xFF7F5F54),
                const Color(0xFF816257),
                const Color(0xFF846459),
                const Color(0xFF86675C),
                const Color(0xFF88695E),
                const Color(0xFF8B6C61),
                const Color(0xFF8D6E63),
              ],
            ),
          ),
          child: InkWell(
            // استخدمت InkWell بدل GestureDetector عشان الـ Ripple effect
            // onTap: isEnabled
            //     ? () {
            //         setState(() {
            //           if (currentStep < 3) currentStep++;
            //         });
            //       }
            //     : null, // لو false مش هيضغط
            onTap: isEnabled
                ? () {
                    if (currentStep < 3) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      final expertCubit = context.read<ExpertServiceCubit>();

                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          // سميناه dialogContext عشان منلخبطش
                          // 2. استخدمي BlocProvider.value عشان تمرري الـ Cubit للـ Dialog
                          return BlocProvider.value(
                            value: expertCubit,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(LocaleKeys.confirmbooking.tr()),
                              content: Text(
                                LocaleKeys.areyousureyouwanttocompletethisbooking.tr(),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: () => Navigator.pop(dialogContext),
                                ),
                                TextButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: Color(0xFF6D4C41),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(dialogContext);

                                    // 3. نادي على الـ Cubit من المتغير اللي حفظناه
                                    if (selectedService != null &&
                                        selectedSlot != null) {
                                      expertCubit.bookConsultation(
                                        expertId: widget.expertId,
                                        serviceId: selectedService!.id,
                                        availabilityId: selectedSlot!.id!,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                : null,
            child: Center(
              child: Text(
                currentStep == 3
                    ? LocaleKeys.confirmPay.tr()
                    : LocaleKeys.continue_text.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.25,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return BlocBuilder<ExpertServiceCubit, ExpertServiceState>(
      // نحدد امتى الـ UI ده يعيد بناء نفسه
      buildWhen: (previous, current) =>
          current is ExpertTimeSlotsLoaded ||
          current is ExpertServiceLoading ||
          current is ExpertServiceError,
      builder: (context, state) {
        if (state is ExpertServiceLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExpertServiceError) {
          return Center(child: Text(state.error));
        }

        if (state is ExpertServicesLoaded) {
          // إذا لم توجد مواعيد فعلياً في الـ List
          if (state.slots.isEmpty) {
            return  Center(
              child: Text(LocaleKeys.notimeslotsavailableforthisexpert.tr()),
            );
          }

          final dates = state.slots.map((s) => s.date).toSet().toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.pickDateTime.tr(),
                style: TextStyle(
                  color: const Color(0xFF3E2723),
                  fontSize: 15.75,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                LocaleKeys.selectDate.tr(),
                style: TextStyle(
                  color: const Color(0xFF8D6E63),
                  fontSize: 12.25,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: dates.map((d) {
                  DateTime parsedDate = DateTime.parse(d);
                  String dayName = DateFormat('E').format(parsedDate);
                  String dayNumber = DateFormat('d').format(parsedDate);
                  return _dateCard(dayName, dayNumber, fullDate: d);
                }).toList(),
              ),
              const SizedBox(height: 25),
              if (selectedDate != null) ...[
                Text(
                  LocaleKeys.selectTime.tr(),
                  style: TextStyle(
                    color: const Color(0xFF8D6E63),
                    fontSize: 12.25,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: state.slots
                      .where((s) => s.date == selectedDate)
                      .map((s) => _timeChip(s))
                      .toList(),
                ),
              ],
            ],
          );
        }

        // في حالة كانت الـ State هي ExpertServicesLoaded (بتاعة الخطوة الأولى)
        // والبيانات لسه محملتش للخطوة دي:
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Widget كارت التاريخ المحدث
  Widget _dateCard(String day, String date, {required String fullDate}) {
    bool isSelected = selectedDate == fullDate; // فحص هل هذا التاريخ هو المختار

    return GestureDetector(
      onTap: () {
        setState(() {
          // selectedDate = isSelected ? null : fullDate;
          if (selectedDate != fullDate) {
            selectedDate = fullDate; // اختار التاريخ الجديد
            selectedTime = null; // صَفّر الوقت المختار عشان ميظهرش تظليل قديم
          } else {
            // 2. لو ضغطت على نفس التاريخ المختار حالياً (عشان تلغي الاختيار)
            selectedDate = null;
            selectedTime = null;
          }
        }); // تحديث الحالة
      },
      child: Container(
        width: 85,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.transparent
              : Colors.white, // شفاف لو اخترناه، ابيض لو لا
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.brown[400]! : Colors.grey[200]!,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3E2723)
                    : const Color(0xFFBDBDBD),
                fontSize: 12.50,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: const Color(0xFF3E2723),
                fontSize: 14.25,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeChip(TimeSlotModel slot) {
    // bool isSelected = selectedTime == time; // فحص هل هذا الوقت هو المختار
    bool isSelected = selectedSlot?.id == slot.id;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   selectedTime = isSelected ? null : time;
        // }); // تحديث الحالة
        setState(() {
          // لو ضغطنا على نفس الموعد نلغي الاختيار، غير كدة نختاره
          if (isSelected) {
            selectedSlot = null;
            selectedTime = null;
          } else {
            selectedSlot = slot;
            selectedTime =
                slot.startTime; // عشان الـ UI اللي بيعتمد على String يفضل شغال
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.brown[400]! : Colors.grey[200]!,
          ),
          color: isSelected
              ? Colors.transparent
              : Colors.white, // شفاف لو اخترناه، ابيض لو لا
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                  ),
                ],
        ),
        child: Text(
          slot.startTime,
          style: TextStyle(
            color: const Color(0xFF3E2723),
            fontSize: 12.25,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
          // style: TextStyle(
          //   color: isSelected ? Colors.brown[800] : Colors.brown[900],
          //   fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          // ),
        ),
      ),
    );
  }
}
