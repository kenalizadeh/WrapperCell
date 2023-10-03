//
//  ViewController.swift
//  WrapperCell
//
//  Created by Kenan Alizadeh on 10/03/2023.
//

import UIKit
import Swild

enum TableItem {
    case button(ButtonCell.Item)
    case label(LabelCell.Item)
    case textField(TextFieldCell.Item)
    case datePicker(DatePickerCell.Item)
    case imageView(ImageCell.Item)
    case segmentedControl(SegmentCell.Item)
}

final class ViewController: UIViewController {

    private lazy var tableView: UITableView = .build(self.buildTableView)

    private let tableData: [TableItem] = makeTableItems()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.tableView
    }
}

private extension ViewController {

    func buildTableView(_ v: inout UITableView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(LabelCell.self)
        v.delegate = self
        v.dataSource = self
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 60
        v.separatorStyle = .none
        v.register(ButtonCell.self)
        v.register(TextFieldCell.self)
        v.register(DatePickerCell.self)
        v.register(ImageCell.self)
        v.register(SegmentCell.self)

        self.view.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard self.tableData.indices.contains(indexPath.row)
        else { fatalError("\(Self.self) \(#function) indexPath out of bounds") }

        let cellData = self.tableData[indexPath.row]
        let cell: UITableViewCell

        switch cellData {
        case let .button(item):
            cell = tableView.dequeueReusableCell(with: item, for: indexPath) as ButtonCell

        case let .label(item):
            cell = tableView.dequeueReusableCell(with: item, for: indexPath) as LabelCell

        case let .textField(item):
            let textFieldCell = tableView.dequeueReusableCell(with: item, for: indexPath) as TextFieldCell
            textFieldCell.child.delegate = self

            cell = textFieldCell

        case let .datePicker(item):
            cell = tableView.dequeueReusableCell(with: item, for: indexPath) as DatePickerCell

        case let .imageView(item):
            cell = tableView.dequeueReusableCell(with: item, for: indexPath) as ImageCell

        case let .segmentedControl(item):
            cell = tableView.dequeueReusableCell(with: item, for: indexPath) as SegmentCell
        }

        return cell
    }
}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text,
              let textRange = Range(range, in: text)
        else { return true }

        let finalText = (textField.text ?? "").replacingCharacters(in: textRange, with: string)
        print(#function, "text:", finalText)
        textField.text = finalText

        return false
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        guard tableView.indexPathForSelectedRow != indexPath
        else {
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }

        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(Self.self, #function, indexPath.row)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        print(Self.self, #function, indexPath.row)
    }
}

fileprivate func makeTableItems() -> [TableItem] {
    [
        .button(
            ButtonCell.Item(
                item: Button.Item(
                    text: .init(
                        string: "Click Me",
                        color: .white,
                        font: .systemFont(ofSize: 24)
                    ),
                    tintColor: .orange,
                    backgroundColor: .systemBlue,
                    disabledBackgroundColor: .lightGray,
                    cornerRadius: 8
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16),
                height: 48
            )
        ),
        .label(
            LabelCell.Item(
                item: UILabel.Item(
                    content: .init(
                        string: "We're no strangers to love\nYou know the rules and so do I (do I)\nA full commitment's what I'm thinking of\nYou wouldn't get this from any other guy\nI just wanna tell you how I'm feeling\nGotta make you understand",
                        color: .lightGray,
                        font: .systemFont(ofSize: 20, weight: .semibold)
                    ),
                    numberOfLines: 0,
                    lineBreakMode: .byWordWrapping,
                    baselineAdjustment: .alignCenters
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16)
            )
        ),
        .textField(
            TextFieldCell.Item(
                item: .init(
                    placeholder: .init(
                        string: "Enter your e-mail:",
                        color: .lightGray,
                        font: .systemFont(ofSize: 16)
                    ),
                    keyboardType: .emailAddress
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16),
                height: 50
            )
        ),
        .datePicker(
            DatePickerCell.Item(
                item: UIDatePicker.Item(
                    datePickerMode: .dateAndTime,
                    minimumDate: Date()
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16)
            )
        ),
        .imageView(
            ImageCell.Item(
                item: UIImageView.Item(
                    contentMode: .scaleAspectFit,
                    image: UIImage(named: "swift-logo"),
                    tintColor: nil
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16),
                height: 100
            )
        ),
        .segmentedControl(
            SegmentCell.Item(
                item: UISegmentedControl.Item(
                    items: ["First", "Second", "Third"],
                    font: .systemFont(ofSize: 20, weight: .semibold),
                    textColor: .systemOrange
                ),
                insets: .init(top: 5, left: 16, bottom: 5, right: 16)
            )
        )
    ]
}
