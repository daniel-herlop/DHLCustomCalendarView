//
//  MainView.swift
//  Example
//
//  Created by Daniel Hernandez on 26/06/2026.
//

import Foundation
import UIKit
import DHLCustomCalendarView

class MainView: UIViewController {
    
    @IBOutlet weak var calendarContainerView: UIView!
    
    private var router = MainRouter()
    private var viewModel = MainViewModel()
    
    //********************************************
    // MARK: Initialization
    //********************************************
    override func viewDidLoad() {
        viewModel.bind(view: self, router: router)
        
        calendarContainerView.layer.cornerRadius = 12
        
        setUpCalendar()
    }
    
    func setUpCalendar() {
        
        let calendarView = DHLCustomCalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarContainerView.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor)
        ])
        
        
        // para seleccionar solo una fecha
        calendarView.setUp(
            availableDateRange: DateInterval(start: .distantPast, end: .now),
            selectedDateAction: { date in
                
            }
        )
        
        // para seleccionar varias fechas
        /*calendarView.setUp(
            selectedDatesAction: { dates in
               
            }
        )*/
        
        if let calendarView = self.calendarContainerView.subviews.first(where: { $0 is DHLCustomCalendarView }) {

            if #available(iOS 18.0, *) {
                (calendarView as? DHLCustomCalendarView)?.setUpDecorations(getCalendarDecorations())
            }
        }
    }
    
    func getCalendarDecorations() -> [Date?: UICalendarView.Decoration] {
        
        var decorations: [Date?: UICalendarView.Decoration] = [:]
        
        for decorationDate in viewModel.decorationDates {
            
            // imagen
            // let decoration: UICalendarView.Decoration = .image(R.image.custom_decoration()!)
            
            // icono default redondo
            // let decoration: UICalendarView.Decoration = .default(color: UIColor.systemBlue, size: .medium)
            
            // vista custom
            let decoration: UICalendarView.Decoration = .customView( {
                let view = DHLCustomDecorationView(width: self.calendarContainerView.frame.width/10)
                view.backgroundColor = .clear
                
                view.addCustomSubview(color: UIColor.systemBlue, bottomSpacing: 14)
                
                return view
            })
            
            decorations[decorationDate] = decoration
        }
        
        return decorations
    }
    
    func printSelectedDate() {
        
        if let calendarView = self.calendarContainerView.subviews.first(where: { $0 is DHLCustomCalendarView }) {
            
            //si esta en singleMode se coge la fecha seleccionada
            if let dateSelected = (calendarView as? DHLCustomCalendarView)?.selection?.selectedDate?.date {
                print(dateSelected)
                
                //si esta en multiMode se cogen la fechas seleccionadas
            } else if let dates = (calendarView as? DHLCustomCalendarView)?.multiSelection?.selectedDates {
                var datesSelected = [Date]()
                
                for dateSelected in dates {
                    if let date = Calendar.current.date(from: dateSelected) {
                        datesSelected.append(date)
                    }
                }
                
                print(datesSelected)
                
                //si no hay fecha seleccionada se carga la actual (comprobar si esto es necesario o no)
            }
        }
    }
}
