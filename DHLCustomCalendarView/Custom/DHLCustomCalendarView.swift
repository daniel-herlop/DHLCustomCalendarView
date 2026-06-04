//
//  DHLCustomCalendarView.swift
//  DHLCustomCalendarView
//
//  Created by Daniel Hernandez on 3/5/26.
//

import Foundation
import UIKit

@available(iOS 16.0, *)
public class DHLCustomCalendarView: UIView {

    private var selectedDateAction: ((Date) -> Void)?
    private var selectedDatesAction: (([Date]) -> Void)?
    
    private var calendarView: UICalendarView = UICalendarView()
    private var decorations: [Date?: UICalendarView.Decoration] = [:]
    
    public var selection: UICalendarSelectionSingleDate?
    public var multiSelection: UICalendarSelectionMultiDate?
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {

        backgroundColor = .clear

        commonInit()
    }

    public override func awakeFromNib() {

        super.awakeFromNib()

        commonInit()
    }

    func commonInit() {

        let isoCalendar = Calendar(identifier: .iso8601)
        
        calendarView.calendar = isoCalendar
        calendarView.locale = Locale.current
        calendarView.timeZone = TimeZone.current
        calendarView.fontDesign = .rounded
        
        // calendarView.tintColor = R.color.blue_app()
        
        calendarView.availableDateRange = DateInterval(start: .distantPast, end: .now)
        
        selection = UICalendarSelectionSingleDate(delegate: self)
        multiSelection = UICalendarSelectionMultiDate(delegate: self)
        
        // para seleccionar solo una fecha
        // calendarView.selectionBehavior = selection
        // selection?.selectedDate = Calendar.current.dateComponents(in: .current, from: Date())
        
        // para seleccionar varias fechas
        //calendarView.selectionBehavior = multiSelection
        //multiSelection?.setSelectedDates([Calendar.current.dateComponents(in: .current, from: Date())], animated: false)
        
        self.addSubview(calendarView)
        
        calendarView.pinToSuperview()
        
        calendarView.delegate = self
    }

    // para seleccionar solo una fecha
    public func setUp(selectedDateAction: @escaping ((Date) -> Void)) {
        
        self.selectedDateAction = selectedDateAction
        calendarView.selectionBehavior = selection
        selection?.selectedDate = Calendar.current.dateComponents(in: .current, from: Date())
    }
    
    // para seleccionar varias fechas
    public func setUp(selectedDatesAction: @escaping (([Date]) -> Void)) {
        
        self.selectedDatesAction = selectedDatesAction
        calendarView.selectionBehavior = multiSelection
        multiSelection?.setSelectedDates([Calendar.current.dateComponents(in: .current, from: Date())], animated: false)
    }
    
    @available(iOS 18.0, *)
    public func setUpDecorations(_ decorations: [Date?: UICalendarView.Decoration]) {
        
        if decorations.isEmpty { return }
        
        for decoration in decorations {
            add(decoration: decoration.value, on: decoration.key ?? Date())
        }
    }
    
    func add(decoration: UICalendarView.Decoration, on date: Date) {
        // Get the calendar, year, month, and day date components for
        // the specified date.
        let dateComponents = Calendar.current.dateComponents(
            [.calendar, .year, .month, .day],
            from: date
        )
        
        guard let date = dateComponents.date else { return }
        // Add the decoration to the decorations dictionary.
        decorations[date] = decoration
        
        // Reload the calendar view's decorations.
        calendarView.reloadDecorations(
            forDateComponents: [dateComponents],
            animated: true
        )
    }
}

@available(iOS 16.0, *)
extension DHLCustomCalendarView: UICalendarViewDelegate {
    public func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        let day = DateComponents(
                    calendar: dateComponents.calendar,
                    year: dateComponents.year,
                    month: dateComponents.month,
                    day: dateComponents.day
                )
                
        // Return any decoration saved for that date.
        if decorations[day.date] != nil {
            let decoration = decorations[day.date]
            return decoration
            
        } else {
            return nil
        }
    }
    /*
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        
        let visibleComponents = calendarView.visibleDateComponents
        if let month = visibleComponents.month, let year = visibleComponents.year {
            print("Mes visible: \(month), Año visible: \(year)")
        }
    }
    */
}

@available(iOS 16.0, *)
extension DHLCustomCalendarView: UICalendarSelectionSingleDateDelegate {
    public func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
        if let dateComponents = dateComponents {
            if let date = Calendar.current.date(from: dateComponents) {
                selectedDateAction?(date)
            }
        }
    }
}

@available(iOS 16.0, *)
extension DHLCustomCalendarView: UICalendarSelectionMultiDateDelegate {
    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {

        var datesSelected = [Date]()
        for dateSelected in multiSelection?.selectedDates ?? [] {
            if let date = Calendar.current.date(from: dateSelected) {
                datesSelected.append(date)
            }
        }
        selectedDatesAction?(datesSelected)
    }

    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        
        var datesSelected = [Date]()
        for dateSelected in multiSelection?.selectedDates ?? [] {
            if let date = Calendar.current.date(from: dateSelected) {
                datesSelected.append(date)
            }
        }
        selectedDatesAction?(datesSelected)
    }
}

extension UIView {
    func pinToSuperview() {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
