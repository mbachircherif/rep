//
//  DashboardView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 30/07/2026.
//

import Charts
import SwiftData
import SwiftUI

struct DashboardView: View {

    @Query
    private var orders: [Order]

    private var warehouse: Warehouse

    init(warehouse: Warehouse) {
        self._orders = Query(Order.fetchMany(warehouse: warehouse))

        self.warehouse = warehouse
    }

    @State
    private var isDatePickerPresented: Bool = false

    @State
    private var date: Date = Date()

    @State
    private var values: [(day: Int, value: Int)] = []

    private let days = Array(Calendar.current.range(of: .day, in: .month, for: .now)!)

    private var currentMonthFilteredOrders: [Order] {
        orders.filter {
            $0.status == .paid && Calendar.current.isDate($0.createdAt, equalTo: date, toGranularity: .month)
        }
    }

    private var currentDayFilterdOrders: [Order] {
        orders.filter {
            $0.status == .paid && Calendar.current.isDate($0.createdAt, equalTo: date, toGranularity: .dayOfYear)
        }
    }

    private var currentMonthNetSales: Decimal {
        currentMonthFilteredOrders.reduce(Decimal(0)) { $0 + $1.total }
    }

    private var currentDayNetSales: Decimal {
        currentDayFilterdOrders.reduce(Decimal(0)) { $0 + $1.total }
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 24.0) {
                HStack {
                    Text(currentMonthNetSales, format: .currency(code: "EUR"))
                        .font(.system(size: 26.0, weight: .semibold, design: .rounded))

                    Spacer()

                    Text(0.2288, format: .percent.sign(strategy: .always()))
                        .font(.system(size: 23.0, weight: .medium, design: .rounded))
                        .foregroundStyle(.green)

                }

                Chart(values, id: \.day) { item in
                    LineMark(
                        x: .value("Date", item.day),
                        y: .value("Value", item.value)
                    )
                    .foregroundStyle(.black)
                    .lineStyle(StrokeStyle(lineWidth: 3.0, lineCap: .round))
                    .interpolationMethod(.monotone)
                }
                .chartXAxis {
                    AxisMarks(values: [1, 15, days.count]) {
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [2, 3]))
                        AxisValueLabel()
                    }
                }
                .chartYAxis(.hidden)
                .frame(height: 200.0)
                .onAppear {
                    values = days.map { day in
                        let base = 10 + pow(Double(day), 0.8)          // gentle acceleration
                        return (day, Int(base + Double.random(in: -3...3)))
                    }
                }

                Spacer()

                // Margin
                Section {
                    VStack(spacing: 24.0) {
                        HStack(spacing: 24.0) {
                            VStack(alignment: .leading, spacing: .zero) {
                                Text("Margin")
                                    .foregroundStyle(Color(hex: "#f59e0b")!)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 8.0, trailing: 16.0))

                                VStack(alignment: .leading, spacing: 8.0) {
                                    Text(0.0675, format: .percent.sign(strategy: .always()))
                                        .foregroundStyle(Color(hex: "#f59e0b")!)
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))

                                    Spacer()
                                    Spacer()

                                    Text("Today")
                                        .font(Font.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(white: 0.65))

                                    Text(2310, format: .currency(code: "EUR"))
                                        .lineLimit(1)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 26, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(.white)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(2.0)
                            .background(Color(hex: "#fef3c7")!, in: .rect(cornerRadius: 32.0))

                            VStack(alignment: .leading, spacing: .zero) {
                                Text("Grosse")
                                    .foregroundStyle(Color(hex: "#38bdf8")!)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 8.0, trailing: 16.0))

                                VStack(alignment: .leading, spacing: 8.0) {
                                    Text(0.25, format: .percent.sign(strategy: .always()))
                                        .foregroundStyle(Color(hex: "#38bdf8")!)
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))

                                    Spacer()
                                    Spacer()

                                    Text("Today")
                                        .font(Font.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(white: 0.65))

                                    Text(20.54, format: .currency(code: "EUR"))
                                        .lineLimit(1)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 26, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(.white)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(2.0)
                            .background(Color(hex: "#e0f2fe")!, in: .rect(cornerRadius: 32.0))
                        }

                        HStack(spacing: 24.0) {
                            VStack(alignment: .leading, spacing: .zero) {
                                Text("Sales")
                                    .foregroundStyle(Color(hex: "#22c55e")!)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 8.0, trailing: 16.0))

                                VStack(alignment: .leading, spacing: 8.0) {
                                    Text(1.143, format: .percent.sign(strategy: .always()))
                                        .foregroundStyle(Color(hex: "#22c55e")!)
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))

                                    Spacer()
                                    Spacer()

                                    Text("Today")
                                        .font(Font.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(white: 0.65))

                                    Text(768, format: .currency(code: "EUR"))
                                        .lineLimit(1)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 26, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(.white)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(2.0)
                            .background(Color(hex: "#dcfce7")!, in: .rect(cornerRadius: 32.0))

                            VStack(alignment: .leading, spacing: .zero) {
                                Text("Benefices")
                                    .foregroundStyle(Color(hex: "#6366f1")!)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(EdgeInsets(top: 12.0, leading: 16.0, bottom: 8.0, trailing: 16.0))

                                VStack(alignment: .leading, spacing: 8.0) {
                                    Text(0.76, format: .percent.sign(strategy: .always()))
                                        .foregroundStyle(Color(hex: "#818cf8")!)
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))

                                    Spacer()
                                    Spacer()

                                    Text("Today")
                                        .font(Font.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(Color(white: 0.65))

                                    Text(312, format: .currency(code: "EUR"))
                                        .lineLimit(1)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 26, weight: .bold, design: .rounded))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(2.0)
                            .background(Color(hex: "#e0e7ff")!, in: .rect(cornerRadius: 32.0))
                        }
                    }
                } header: {
                    HStack {
                        Text("Statistiques")
                            .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(white: 0.25))

                        Spacer()
                    }
                }

                Spacer()

                Section {
                    Grid(verticalSpacing: 6.0) {
                        GridRow {
                            HStack {
                                Label {
                                    Text("En cours")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(.gray)
                                } icon: {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundStyle(.yellow)
                                        .scaledToFit()
                                        .frame(width: 10.0, height: 10.0)
                                }

                                Spacer()

                                Text("12")
                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(6.0)

                        GridRow {
                            HStack {
                                Label {
                                    Text("Terminées")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(.gray)
                                } icon: {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundStyle(.green)
                                        .scaledToFit()
                                        .frame(width: 10.0, height: 10.0)
                                }

                                Spacer()

                                Text("3")
                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(6.0)
                        .background(Color(white: 0.975), in: .rect(cornerRadius: 8.0))

                        GridRow {
                            HStack {
                                Label {
                                    Text("Annulées")
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                        .foregroundStyle(.gray)
                                } icon: {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .scaledToFit()
                                        .frame(width: 10.0, height: 10.0)
                                }

                                Spacer()

                                Text("2")
                                    .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(6.0)
                    }
                } header: {
                    HStack {
                        Text("Commandes")
                            .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(white: 0.25))

                        Spacer()
                    }
                }
            }
            .padding(24.0)
        }
        .background(Color(white: 0.985))
        .sheet(isPresented: $isDatePickerPresented) {
            DatePicker("Start Date", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
        }
        .navigationTitle("Tableau de bord")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DashboardView(warehouse: Warehouse(user: User(fullname: "Test Test")))
    }
}
