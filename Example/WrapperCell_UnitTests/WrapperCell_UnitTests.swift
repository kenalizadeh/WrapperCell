//
//  WrapperCell_UnitTests.swift
//  WrapperCell_UnitTests
//
//  Created by Kenan Alizadeh on 03.10.23.
//

import Quick
import Nimble
@testable import WrapperCell_Example

final class WrapperCell_UnitTests: QuickSpec {

    override func spec() {

        describe("main demo page") {
            it("has proper cell identifiers") {
                expect(ButtonCell.uniqueIdentifier).to(contain("WrapperCell")).to(contain("Button"))
                expect(SegmentCell.uniqueIdentifier).to(contain("WrapperCell")).to(contain("Segment"))
            }
        }

        describe("button cell") {
            it("behaves properly when selected") {
                let cell = ButtonCell()
                expect(cell.child.isEnabled).to(equal(true))
                cell.setSelected(false, animated: false)
                expect(cell.child.isEnabled).to(equal(false))
            }
        }
    }
}
