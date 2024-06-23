import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomWeekCalendar extends StatefulWidget {
  const CustomWeekCalendar({
    super.key,
    this.initialDate,
    required this.onSelectedDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onSelectedDate;
  @override
  State<CustomWeekCalendar> createState() => _CustomWeekCalendarState();
}

class _CustomWeekCalendarState extends State<CustomWeekCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime firstDateCalendar = DateTime.now();
  final pageController = PageController();
  List<Widget> ws = [];
  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    final weekDay = selectedDate.weekday;

    currentDate = selectedDate.subtract(Duration(days: weekDay));
    firstDateCalendar = currentDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        children: [
          // Controllers
          Row(
            children: [
              const Text('PLACEHOLDER'),
              Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_left_outlined)),
                  IconButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_right_outlined))
                ],
              )
            ],
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (i) {
                  final weekdaystr = DateFormat('EEE', 'es')
                      .format(firstDateCalendar.add(Duration(days: i + 1)));
                  return Expanded(
                      child: Text(
                    weekdaystr,
                    textAlign: TextAlign.center,
                  ));
                })),
          ),
          Container(
              color: Colors.yellow,
              height: 70,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: 400,
                  onPageChanged: (value) {
                    final daysToAdd = 7 * value;
                    setState(() {
                      currentDate =
                          firstDateCalendar.add(Duration(days: daysToAdd));
                    });
                  },
                  itemBuilder: (ctx, i) {
                    return _DayPicker(
                        currentDate: currentDate,
                        firstDate: widget.firstDate,
                        lastDate: widget.lastDate,
                        selectedDate: selectedDate,
                        onChanged: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                          widget.onSelectedDate(date);
                        });
                  }))
        ],
      ),
    );
  }
}

class _FocusedDate extends InheritedWidget {
  const _FocusedDate({
    required super.child,
    this.date,
  });

  final DateTime? date;

  @override
  bool updateShouldNotify(_FocusedDate oldWidget) {
    return !DateUtils.isSameDay(date, oldWidget.date);
  }

  static DateTime? maybeOf(BuildContext context) {
    final _FocusedDate? focusedDate =
        context.dependOnInheritedWidgetOfExactType<_FocusedDate>();
    return focusedDate?.date;
  }
}

class _DayPicker extends StatefulWidget {
  /// Creates a day picker.
  _DayPicker({
    super.key,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onChanged,
    this.selectableDayPredicate,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate == null || !selectedDate.isBefore(firstDate)),
        assert(selectedDate == null || !selectedDate.isAfter(lastDate));

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime? selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [firstDate].
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate? selectableDayPredicate;

  @override
  _DayPickerState createState() => _DayPickerState();
}

class _DayPickerState extends State<_DayPicker> {
  /// List of [FocusNode]s, one for each day of the month.
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();

    _dayFocusNodes = List<FocusNode>.generate(
      7,
      (int index) =>
          FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check to see if the focused date is in this month, if so focus it.
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final DatePickerThemeData datePickerTheme = DatePickerTheme.of(context);
    final DatePickerThemeData defaults = DatePickerTheme.defaults(context);
    final TextStyle? weekdayStyle =
        datePickerTheme.weekdayStyle ?? defaults.weekdayStyle;

    // final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    //final int dayOffset = DateUtils.firstDayOffset(year, month, localizations);

    // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
    // a leap year.
    //int day = -dayOffset;
    final currentWeekDay = widget.currentDate.weekday;
    final firstDay =
        widget.currentDate.subtract(Duration(days: currentWeekDay - 1));
    final lastDay = widget.currentDate.add(Duration(days: 8 - currentWeekDay));

    print('Firstday: $firstDay');
    print('lastday: $lastDay');

    DateTime dayToBuild = firstDay;
    int counter = 0;
    List<Widget> dayItems = [];
    while (!DateUtils.isSameDay(dayToBuild, lastDay)) {
      counter++;
      final bool isDisabled = dayToBuild.isAfter(widget.lastDate) ||
          dayToBuild.isBefore(widget.firstDate) ||
          (widget.selectableDayPredicate != null &&
              !widget.selectableDayPredicate!(dayToBuild));
      final bool isSelectedDay =
          DateUtils.isSameDay(widget.selectedDate, dayToBuild);
      final bool isToday = DateUtils.isSameDay(widget.currentDate, dayToBuild);

      dayItems.add(
        Expanded(
          child: _Day(
            dayToBuild,
            key: ValueKey<DateTime>(dayToBuild),
            isDisabled: isDisabled,
            isSelectedDay: isSelectedDay,
            isToday: isToday,
            onChanged: widget.onChanged,
            focusNode: _dayFocusNodes[counter - 1],
          ),
        ),
      );
      dayToBuild = dayToBuild.add(const Duration(days: 1));
    }

    return Row(
      children: dayItems,
    );
  }
}

class _Day extends StatefulWidget {
  const _Day(
    this.day, {
    super.key,
    required this.isDisabled,
    required this.isSelectedDay,
    required this.isToday,
    required this.onChanged,
    required this.focusNode,
  });

  final DateTime day;
  final bool isDisabled;
  final bool isSelectedDay;
  final bool isToday;
  final ValueChanged<DateTime> onChanged;
  final FocusNode? focusNode;

  @override
  State<_Day> createState() => _DayState();
}

class _DayState extends State<_Day> {
  final WidgetStatesController _statesController = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    final DatePickerThemeData defaults = DatePickerTheme.defaults(context);
    final DatePickerThemeData datePickerTheme = DatePickerTheme.of(context);
    final TextStyle? dayStyle = datePickerTheme.dayStyle ?? defaults.dayStyle;
    T? effectiveValue<T>(T? Function(DatePickerThemeData? theme) getProperty) {
      return getProperty(datePickerTheme) ?? getProperty(defaults);
    }

    T? resolve<T>(
        WidgetStateProperty<T>? Function(DatePickerThemeData? theme)
            getProperty,
        Set<WidgetState> states) {
      return effectiveValue(
        (DatePickerThemeData? theme) {
          return getProperty(theme)?.resolve(states);
        },
      );
    }

    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String semanticLabelSuffix =
        widget.isToday ? ', ${localizations.currentDateLabel}' : '';

    final Set<WidgetState> states = <WidgetState>{
      if (widget.isDisabled) WidgetState.disabled,
      if (widget.isSelectedDay) WidgetState.selected,
    };

    _statesController.value = states;

    final Color? dayForegroundColor = resolve<Color?>(
        (DatePickerThemeData? theme) => widget.isToday
            ? theme?.todayForegroundColor
            : theme?.dayForegroundColor,
        states);
    final Color? dayBackgroundColor = resolve<Color?>(
        (DatePickerThemeData? theme) => widget.isToday
            ? theme?.todayBackgroundColor
            : theme?.dayBackgroundColor,
        states);
    final WidgetStateProperty<Color?> dayOverlayColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) => effectiveValue(
          (DatePickerThemeData? theme) =>
              theme?.dayOverlayColor?.resolve(states)),
    );
    final OutlinedBorder dayShape = resolve<OutlinedBorder?>(
        (DatePickerThemeData? theme) => theme?.dayShape, states)!;
    final ShapeDecoration decoration = widget.isToday
        ? ShapeDecoration(
            color: dayBackgroundColor,
            shape: dayShape.copyWith(
              side: (datePickerTheme.todayBorder ?? defaults.todayBorder!)
                  .copyWith(color: dayForegroundColor),
            ),
          )
        : ShapeDecoration(
            color: dayBackgroundColor,
            shape: dayShape,
          );

    Widget dayWidget = DecoratedBox(
      decoration: decoration,
      child: Center(
        child: Text(localizations.formatDecimal(widget.day.day),
            style: dayStyle?.apply(color: dayForegroundColor)),
      ),
    );

    if (widget.isDisabled) {
      dayWidget = ExcludeSemantics(
        child: dayWidget,
      );
    } else {
      dayWidget = InkResponse(
        focusNode: widget.focusNode,
        onTap: () => widget.onChanged(widget.day),
        statesController: _statesController,
        overlayColor: dayOverlayColor,
        customBorder: dayShape,
        containedInkWell: true,
        child: Semantics(
          // We want the day of month to be spoken first irrespective of the
          // locale-specific preferences or TextDirection. This is because
          // an accessibility user is more likely to be interested in the
          // day of month before the rest of the date, as they are looking
          // for the day of month. To do that we prepend day of month to the
          // formatted full date.
          label:
              '${localizations.formatDecimal(widget.day.day)}, ${localizations.formatFullDate(widget.day)}$semanticLabelSuffix',
          // Set button to true to make the date selectable.
          button: true,
          selected: widget.isSelectedDay,
          excludeSemantics: true,
          child: dayWidget,
        ),
      );
    }

    return dayWidget;
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }
}
