import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/session/data/add_consultation_model.dart';
import 'package:graduation2/feauture/session/data/time_slot_model.dart';
import 'package:graduation2/feauture/session/manager/expert_service_cubit.dart';
import 'package:graduation2/feauture/session/manager/expert_service_state.dart';
import 'package:graduation2/generated/locale_keys.g.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  // تعريف Controllers لمراقبة النصوص
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceNameArabicController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // مفاتيح للـ Form للتحقق من البيانات
  final _serviceFormKey = GlobalKey<FormState>();
  final _timeSlotFormKey = GlobalKey<FormState>();

  bool _isServiceValid = false;
  bool _isTimeSlotValid = false;

  @override
  void initState() {
    super.initState();
    // إضافة مستمعين (Listeners) لتحديث لون الزر فورياً عند الكتابة
    _serviceNameController.addListener(_validateService);
    _priceController.addListener(_validateService);
    _durationController.addListener(_validateService);
    _serviceNameArabicController.addListener(_validateService);
    _dayController.addListener(_validateTimeSlot);
    _timeController.addListener(_validateTimeSlot);
  }

  void _validateService() {
    setState(() {
      _isServiceValid =
          _serviceNameController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _serviceNameArabicController.text.isNotEmpty &&
          _durationController.text.isNotEmpty;
    });
  }

  void _validateTimeSlot() {
    setState(() {
      _isTimeSlotValid =
          _dayController.text.isNotEmpty && _timeController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _dayController.dispose();
    _timeController.dispose();
    _serviceNameArabicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocListener<ExpertServiceCubit, ExpertServiceState>(
      listener: (context, state) {
        // TODO: implement listener'
        if (state is ExpertServiceLoading) {
          // ممكن تظهري Loading Indicator هنا
        } else if (state is ExpertServiceSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          // مسح الحقول بعد النجاح
          _serviceNameController.clear();
          _priceController.clear();
          _durationController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          // مسح الحقول
          _dayController.clear();
          _timeController.clear();
          _serviceNameArabicController.clear();
          _descriptionController.clear();
        } else if (state is ExpertServiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },

      child: Scaffold(
        //   backgroundColor: const Color(0xFFF9F6F1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), // تحديد ارتفاع الـ AppBar
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false, // سنضع زر الرجوع بأنفسنا
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff6D4C41), // البني الغامق
                    Color(0xff725146),
                    Color(0xff76564A),
                    // اللون الرملي/الفاتح
                    Color(0xff7B5A4F),
                    Color(0xff7F5F54),
                    Color(0xff846459),
                    Color(0xff88695E),
                    Color(0xff8D6E63),
                    Color(0xff957666),

                    Color(0xff9E7E69),
                    Color(0xffA6866B),
                    Color(0xffAF8F6E),
                    Color(0xffB79770),
                    Color(0xffC09F73),
                    Color(0xffC9A875),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // صف زر الرجوع
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      // const Spacer(),
                      // نصوص العنوان
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Text(
                              LocaleKeys.consultationSetup.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.75,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "0 ${LocaleKeys.services.tr()} • 0 ${LocaleKeys.timeslots.tr()}",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.80),
                                fontSize: 12.50,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(
                      Icons.assignment_outlined,
                      LocaleKeys.servicesPricing.tr(),
                    ),
                    _buildServiceCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle(
                      Icons.calendar_month_outlined,
                      LocaleKeys.availableTimeSlots.tr(),
                    ),
                    _buildTimeSlotCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF6D4C41)),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF3E2723),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard() {
    return Form(
      key: _serviceFormKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF8F1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.brown.withOpacity(0.1)),
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.00),
            end: Alignment(1.00, 1.00),
            colors: [
              const Color(0xFFFFF8E1),
              const Color(0xFFFEF7E2),
              const Color(0xFFFCF6E3),
              const Color(0xFFFBF5E4),
              const Color(0xFFFAF4E5),
              const Color(0xFFF9F3E5),
              const Color(0xFFF7F2E6),
              const Color(0xFFF6F1E7),
              const Color(0xFFF5F0E8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.addNewService.tr(),
              style: TextStyle(
                color: const Color(0xFF6D4C41),
                fontSize: 10.50,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              LocaleKeys.serviceName.tr(),
              LocaleKeys.egPotteryBasicsCourse.tr(),
              controller: _serviceNameController,
            ),
            _buildTextField(
              LocaleKeys.serviceName.tr(),
              "مراجعه بورتفيليو",
              controller: _serviceNameArabicController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    LocaleKeys.price_egp.tr(),
                    "150",
                    controller: _priceController,
                    isNumeric: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    LocaleKeys.durationmin.tr(),
                    "60",
                    controller: _durationController,
                    isNumeric: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              LocaleKeys.descriptionOptional.tr(),
              LocaleKeys.briefdescription.tr(),
              controller: _descriptionController,
              maxLines: 3,
              isRequired: false,
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              LocaleKeys.addService.tr(),
              _isServiceValid
                  ? const Color(0xff86675C)
                  : const Color(0xff86675C).withOpacity(0.6),
              Icons.add,
              () {
                if (_serviceFormKey.currentState!.validate()) {
                  // تجهيز البيانات (بما إن عندك localization ممكن تبعتي نفس النص للـ Ar و En مؤقتاً أو تعدلي الـ UI لتأخذ الاثنين)
                  final serviceData = ExpertServiceModel(
                    titleAr: _serviceNameArabicController.text,
                    titleEn: _serviceNameController.text,
                    descriptionAr: _descriptionController.text,
                    descriptionEn: _descriptionController.text,
                    price: double.tryParse(_priceController.text) ?? 0.0,
                    durationInMinutes:
                        int.tryParse(_durationController.text) ?? 0,
                  );

                  // استدعاء الـ Cubit
                  context.read<ExpertServiceCubit>().addService(serviceData);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotCard() {
    return Form(
      key: _timeSlotFormKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF8F1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.brown.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Time Slot",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildTextField(
            //         "Day",
            //         "Select Day",
            //         controller: _dayController,
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildTextField(
            //         "Time",
            //         "00:00 AM",
            //         controller: _timeController,
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context), // يفتح النتيجة عند الضغط
                    child: AbsorbPointer(
                      // يمنع الكيبورد من الظهور
                      child: _buildTextField(
                        "Day",
                        "YYYY-MM-DD",
                        controller: _dayController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: _buildTextField(
                        "Time",
                        "HH:mm:ss",
                        controller: _timeController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              "Add Time Slot",
              _isTimeSlotValid
                  ? const Color(0xffD1AE4A)
                  : const Color(0xffD1AE4A).withOpacity(0.6),
              Icons.add,
              () {
                if (_timeSlotFormKey.currentState!.validate()) {
                  // 1. تجهيز الـ Model
                  final slotData = TimeSlotModel(
                    date: _dayController.text, // تأكدي أن التنسيق YYYY-MM-DD
                    startTime:
                        _timeController.text, // تأكدي أن التنسيق HH:mm:ss
                  );

                  // 2. استدعاء الـ Cubit
                  context.read<ExpertServiceCubit>().addTimeSlot(slotData);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint, {
    int maxLines = 1,
    required TextEditingController controller,
    bool isRequired = true,
    bool isNumeric = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF3E2723),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly:
              (label == "Day" ||
              label == "Time"), // منع الكتابة في حقول الوقت والتاريخ
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return "Required field";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0x7F3E2723),
              fontSize: 10.5,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Color(0xffEFEBE9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.brown.withOpacity(0.1)),
            ),
            errorStyle: const TextStyle(fontSize: 9),
          ),
        ),
      ],
    );
  }

  // دالة اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // يختار تواريخ مستقبلية فقط
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        // تحويل التاريخ لصيغة 2026-04-01
        _dayController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // دالة اختيار الوقت
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        // تحويل الوقت لصيغة 14:00:00 (بنظام 24 ساعة)
        final now = DateTime.now();
        final dt = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );
        _timeController.text = DateFormat('HH:mm:ss').format(dt);
      });
    }
  }

  Widget _buildActionButton(
    String title,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: Colors.white),
        label: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.50,
            fontFamily: 'Ario',
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
