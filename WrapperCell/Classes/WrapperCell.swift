//
//  WrapperCell.swift
//
//  Created by Kenan Alizadeh on 23.01.23.
//

import UIKit

public protocol Configurable {
    associatedtype Item

    func configure(_ item: Item)
    func handleSelection(_ selected: Bool)
    func reset()
}

public extension Configurable {

    func handleSelection(_ selected: Bool) {}
}

public protocol ConfigurableView: Configurable, UIView {}

public class WrapperTableViewCell<Item>: UITableViewCell, ConfigurableView {
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

public class WrapperCell<View: ConfigurableView>: WrapperTableViewCell<WrapperCellItem<View.Item>> {
    private var _child: View
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public var child: View { _child }

    public var insets: UIEdgeInsets = .zero {
        didSet {
            updateChildConstraints()
        }
    }

    public var childHeight: CGFloat? {
        didSet {
            updateChildConstraints()
        }
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        _child = View.init()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        _child.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(_child)

        updateChildConstraints()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        _child.reset()
    }

    public override func configure(_ item: WrapperCellItem<View.Item>) {
        super.configure(item)

        backgroundColor = item.backgroundColor

        insets = item.insets
        childHeight = item.height

        setSeparatorVisible(
            item.separatorSettings.isVisible,
            position: item.separatorSettings.position,
            with: item.separatorSettings.insets,
            color: item.separatorSettings.color,
            height: item.separatorSettings.height
        )

        _child.configure(item.item)
    }

    private lazy var childHeightConstraint: NSLayoutConstraint = _child.heightAnchor.constraint(equalToConstant: 0)

    private lazy var childConstraints: [NSLayoutConstraint] = [
        _child.topAnchor.constraint(equalTo: contentView.topAnchor),
        _child.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        _child.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        _child.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ]

    public override var intrinsicContentSize: CGSize {
        CGRect(origin: .zero, size: _child.intrinsicContentSize).padded(by: insets).size
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.child.handleSelection(selected)
    }
}

private extension WrapperCell {
    func updateChildConstraints() {
        zip(childConstraints, [insets.top, insets.left, -insets.right, -insets.bottom])
            .forEach { constraint, inset in
                constraint.constant = inset
            }

        NSLayoutConstraint.activate(childConstraints)

        if let childHeight {
            childHeightConstraint.constant = childHeight
        }

        childHeightConstraint.isActive = (childHeight != nil)

        setNeedsLayout()
    }

    func setSeparatorVisible(
        _ visible: Bool, position: WrapperCellSeparatorSettings.Position,
        with insets: UIEdgeInsets, color: UIColor,
        height: CGFloat
    ) {
        separatorView.removeFromSuperview()

        if visible {
            separatorView.backgroundColor = color

            contentView.addSubview(separatorView)

            NSLayoutConstraint.activate([
                separatorYAxisConstraint(for: position),
                separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets.left),
                separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets.right),
                separatorView.heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }

    func separatorYAxisConstraint(for position: WrapperCellSeparatorSettings.Position) -> NSLayoutConstraint {
        let from: NSLayoutYAxisAnchor
        let to: NSLayoutYAxisAnchor
        let constant: CGFloat

        switch position {
        case .top:
            from = separatorView.topAnchor
            to = topAnchor
            constant = insets.top

        case .bottom:
            from = separatorView.bottomAnchor
            to = bottomAnchor
            constant = -insets.bottom
        }

        return from.constraint(equalTo: to, constant: constant)
    }
}
