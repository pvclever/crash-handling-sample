//
//  ViewController.swift
//  CrashHandlingSample
//
//  Created by Pavel Yevtukhov on 30.08.2024.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let simulateCrashButton1 = UIButton(type: .system)
        simulateCrashButton1.setTitle("Simulate Crash 1 ", for: .normal)
        simulateCrashButton1.addTarget(self, action: #selector(onSimulateButtonTap1), for: .touchUpInside)


        let simulateCrashButton2 = UIButton(type: .system)
        simulateCrashButton2.setTitle("Simulate Crash 2", for: .normal)
        simulateCrashButton2.addTarget(self, action: #selector(onSimulateButtonTap2), for: .touchUpInside)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)

        stackView.addArrangedSubview(simulateCrashButton1)
        stackView.addArrangedSubview(simulateCrashButton2)
        stackView.addArrangedSubview(label)

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)
        ])

        let message = CrashHandler.getCrashLog() ?? "No exception message yet"
        label.text = message
        CrashHandler.cleanCrashLog()
    }

    @objc
    private func onSimulateButtonTap1() {
        CrashSimulator.simulateError1()
    }

    @objc
    private func onSimulateButtonTap2() {
        CrashSimulator.simulateException()
    }
}

