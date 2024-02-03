//
//  WrapperCell.swift
//
//  Created by Kenan Alizadeh on 23.01.23.
//

import UIKit

public protocol CellWrapped {
    associatedtype Item

    func configure(_ item: Item)
    func handleSelection(_ selected: Bool)
    func reset()
}

public extension CellWrapped {
    func handleSelection(_ selected: Bool) {}
}

public protocol CellWrappedView: CellWrapped, UIView {}

public class WrapperTableViewCell<Item>: UITableViewCell, CellWrappedView {
    private(set) var item: Item!

    public static var uniqueIdentifier: String {
        [
            String(describing: Self.self),
            ".",
            String(describing: Item.self)
        ].joined()
    }

    public func configure(_ item: Item) {
        self.item = item
    }

    public func reset() {}
}

public struct WrapperCellItem<Item> {
    public let item: Item
    public let insets: UIEdgeInsets
    public let backgroundColor: UIColor
    public let height: CGFloat?
    public let separatorSettings: WrapperCellSeparatorSettings

    public init(
        item: Item,
        insets: UIEdgeInsets = .zero,
        backgroundColor: UIColor = .clear,
        height: CGFloat? = nil,
        separatorSettings: WrapperCellSeparatorSettings = .init()
    ) {
        self.item = item
        self.insets = insets
        self.backgroundColor = backgroundColor
        self.height = height
        self.separatorSettings = separatorSettings
    }
}

public struct WrapperCellSeparatorSettings {
    public let isVisible: Bool
    public let position: WrapperCellSeparatorSettings.Position
    public let insets: UIEdgeInsets
    public let color: UIColor
    public let height: CGFloat

    public init(
        isVisible: Bool = false,
        position: WrapperCellSeparatorSettings.Position = .bottom,
        insets: UIEdgeInsets = .zero,
        color: UIColor = .lightGray,
        height: CGFloat = 0.5
    ) {
        self.isVisible = isVisible
        self.position = position
        self.insets = insets
        self.color = color
        self.height = height
    }

    public enum Position {
        case top
        case bottom
    }
}

public class WrapperCell<View: CellWrappedView>: WrapperTableViewCell<WrapperCellItem<View.Item>> {
    private var _child: View
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public var child: View { _child }

    public var insets: UIEdgeInsets = .zero {
        didSet {
            self.updateChildConstraints()
        }
    }

    public var childHeight: CGFloat? {
        didSet {
            self.updateChildConstraints()
        }
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self._child = View.init()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        self._child.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(self._child)

        self.updateChildConstraints()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        self._child.reset()
    }

    public override func configure(_ item: WrapperCellItem<View.Item>) {
        super.configure(item)

        backgroundColor = item.backgroundColor

        self.insets = item.insets
        self.childHeight = item.height

        self.setSeparatorVisible(
            item.separatorSettings.isVisible,
            position: item.separatorSettings.position,
            with: item.separatorSettings.insets,
            color: item.separatorSettings.color,
            height: item.separatorSettings.height
        )

        self._child.configure(item.item)
    }

    private lazy var childHeightConstraint: NSLayoutConstraint = self._child.heightAnchor.constraint(equalToConstant: 0)

    private lazy var childConstraints: [NSLayoutConstraint] = [
        self._child.topAnchor.constraint(equalTo: contentView.topAnchor),
        self._child.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        self._child.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        self._child.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ]

    public override var intrinsicContentSize: CGSize {
        CGRect(origin: .zero, size: self._child.intrinsicContentSize).padded(by: self.insets).size
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.child.handleSelection(selected)
    }
}

private extension WrapperCell {
    func updateChildConstraints() {
        zip(self.childConstraints, [self.insets.top, self.insets.left, -self.insets.right, -self.insets.bottom])
            .forEach { constraint, inset in
                constraint.constant = inset
            }

        NSLayoutConstraint.activate(self.childConstraints)

        if let childHeight {
            self.childHeightConstraint.constant = childHeight
        }

        self.childHeightConstraint.isActive = (childHeight != nil)

        self.setNeedsLayout()
    }

    func setSeparatorVisible(
        _ visible: Bool, position: WrapperCellSeparatorSettings.Position,
        with insets: UIEdgeInsets, color: UIColor,
        height: CGFloat
    ) {
        self.separatorView.removeFromSuperview()

        if visible {
            self.separatorView.backgroundColor = color

            self.contentView.addSubview(self.separatorView)

            NSLayoutConstraint.activate([
                self.separatorYAxisConstraint(for: position),
                self.separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets.left),
                self.separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets.right),
                self.separatorView.heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }

    func separatorYAxisConstraint(for position: WrapperCellSeparatorSettings.Position) -> NSLayoutConstraint {
        let from: NSLayoutYAxisAnchor
        let to: NSLayoutYAxisAnchor
        let constant: CGFloat

        switch position {
        case .top:
            from = self.separatorView.topAnchor
            to = topAnchor
            constant = self.insets.top

        case .bottom:
            from = self.separatorView.bottomAnchor
            to = bottomAnchor
            constant = -self.insets.bottom
        }

        return from.constraint(equalTo: to, constant: constant)
    }
}
