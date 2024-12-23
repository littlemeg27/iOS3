//
//  ViewController.swift
//  Lab1
//
//  Created by Brenna Pavlinchak on 11/1/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var atomicNumberLabel: UILabel!
    @IBOutlet weak var atomicWeightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var yearDiscoveredLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else
        {
            fatalError("Could not dequeue ElementCell")
        }
        // Configure the cell
        cell.atomicLetterLabel.text = "Example"
        cell.atomicNameLabel.text = "Example"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedElement = elements[indexPath.row]
        nameLabel.text = selectedElement.name
        symbolLabel.text = selectedElement.symbol
        atomicNumberLabel.text = selectedElement.atomicNumber ?? "N/A"
        atomicWeightLabel.text = selectedElement.atomicWeight ?? "N/A"
        meltingPointLabel.text = selectedElement.meltingPoint ?? "N/A"
        boilingPointLabel.text = selectedElement.boilingPoint ?? "N/A"
        yearDiscoveredLabel.text = selectedElement.yearDiscovered ?? "N/A"
    }

}

let elements: [Element] =
[
    Element(name: "Polonium", symbol: "Po", atomicNumber: "84", atomicWeight: "209.004", meltingPoint: "489.2°F", boilingPoint: "1763.6°F",
        yearDiscovered: "1898"),
    Element(name: "Astatine", symbol: "At", atomicNumber: "85", atomicWeight: "210.008", meltingPoint: "575.6°F", boilingPoint: "638.6°F",
        yearDiscovered: "1940"),
    Element(name: "Francium", symbol: "Fr", atomicNumber: "87", atomicWeight: "223", meltingPoint: "80.6°F", boilingPoint: "1250.6°F",
        yearDiscovered: "1939"),
    Element(name: "Plutonium", symbol: "Pu", atomicNumber: "94", atomicWeight: "244.064", meltingPoint: "1182.9°F", boilingPoint: "5842°F",
        yearDiscovered: "1940"),
    Element(name: "Uranium", symbol: "U", atomicNumber: "92", atomicWeight: "238.02891", meltingPoint: "2070.0°F", boilingPoint: "−297.332°F", yearDiscovered: "1789"),
    Element(name: "Promethium", symbol: "Pm", atomicNumber: "61", atomicWeight: "145.038", meltingPoint: "1908°F", boilingPoint: "5432°F",
        yearDiscovered: "1945"),
    Element(name: "Radon", symbol: "Rn", atomicNumber: "86", atomicWeight: "222.01407", meltingPoint: "-96°F", boilingPoint: "-79.1°F",
        yearDiscovered: "1899"),
    Element(name: "Thorium", symbol: "Th", atomicNumber: "90", atomicWeight: "232.03806", meltingPoint: "3182°F", boilingPoint: "8650.4°F",
        yearDiscovered: "1945"),
    Element(name: "Silicon", symbol: "Si", atomicNumber: "14", atomicWeight: "28.0855", meltingPoint: "2577.2°F", boilingPoint: "5909°F",
        yearDiscovered: "1899"),
    Element(name: "Berkelium", symbol: "Bk", atomicNumber: "Bk", atomicWeight: "247", meltingPoint: "1806.8°F", boilingPoint: "N/A",
        yearDiscovered: "1949"),
    Element(name: "Curium", symbol: "Cm", atomicNumber: "96", atomicWeight: "247", meltingPoint: "2444°F", boilingPoint: "8650.4°F",
        yearDiscovered: "1944"),
    Element(name: "Americium", symbol: "Am", atomicNumber: "95", atomicWeight: "243", meltingPoint: "2148.8°F", boilingPoint: "4724.6°F",
        yearDiscovered: "1944"),
    Element(name: "Californium", symbol: "Cf", atomicNumber: "98", atomicWeight: "251", meltingPoint: "1652°F", boilingPoint: "N/A",
        yearDiscovered: "1950"),
    Element(name: "Mendelevium", symbol: "Md", atomicNumber: "101", atomicWeight: "258", meltingPoint: "1520.6°F", boilingPoint: "N/A",
        yearDiscovered: "1955"),
    Element(name: "Einsteinium", symbol: "Es", atomicNumber: "99", atomicWeight: "252", meltingPoint: "1580°F", boilingPoint: "N/A",
        yearDiscovered: "1952")
]
