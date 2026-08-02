//
//  DiscountView.swift
//  erp
//
//  Created by Mohamed BACHIR-CHERIF on 02/08/2026.
//

import SwiftUI

struct DiscountView<T>: View where T : Discount {

    var discount: T

    var body: some View {
        VStack(spacing: 24.0) {
            Text(discount.name)
                .font(.system(size: 26.0, weight: .bold, design: .rounded))

            Group {
                switch discount.type {
                case .fixed:
                    Text(discount.value, format: .currency(code: "USD"))
                case .percentage:
                    Text(discount.value, format: .percent)
                }
            }
            .font(.system(size: 16.0, weight: .medium, design: .rounded))
            .foregroundStyle(.indigo)
        }
    }
}

fileprivate struct DiscountPreview: View {

    @Observable
    final class PreviewDiscount: Discount {

        var name:  String = "Winter 25"

        var type:  ValueType = .percentage

        var value: Decimal = 0
    }

    @State
    private var discount = PreviewDiscount()

    var body: some View {
        DiscountView(discount: discount)
    }
}

#Preview {
    DiscountPreview()
}
