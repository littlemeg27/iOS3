//
//  TimerViewController.swift
//  Lab4
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import UIKit

class TimerViewController: UIViewController
{
    @IBOutlet private weak var timeLabel: UILabel!

    private var timer: Timer?
    private var time: Double = 0.0
    {
        didSet
        {
            timeLabel.text = String(format: "Time: %.1f", time)
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        updateTimer()
    }

    private func setupUI()
    {
        view.backgroundColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        timeLabel.textAlignment = .center
        timeLabel.textColor = .black
    }

    private func updateTimer()
    {
        time = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
        { [weak self] timer in
            guard let self = self else { return }
            self.time += 0.1
            if self.time >= 10.0
            {
                timer.invalidate()
            }
        }
    }
}
