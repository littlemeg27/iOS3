//
//  MultipeerConnectionManager.swift
//  Lab5
//
//  Created by Brenna Pavlinchak on 12/14/24.
//

import MultipeerConnectivity

protocol MultipeerConnectionManagerDelegate: AnyObject
{
    func didReceiveChoice(_ choice: Choice)
    func didReceiveStartRound()
    func didReceiveResult(_ result: GameResult)
}

class MultipeerConnectionManager: NSObject, MCSessionDelegate, MCBrowserViewControllerDelegate, MCAdvertiserAssistantDelegate
{
    
    weak var delegate: MultipeerConnectionManagerDelegate?
    private let serviceType = "rps-game"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let session: MCSession
    private let advertiser: MCAdvertiserAssistant
    private let browser: MCBrowserViewController
    
    init(delegate: MultipeerConnectionManagerDelegate)
    {
        self.delegate = delegate
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        advertiser = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)
        browser = MCBrowserViewController(serviceType: serviceType, session: session)
        super.init()
        session.delegate = self
        browser.delegate = self
    }
    
    func startAdvertising()
    {
        advertiser.start()
    }
    
    func showBrowser() -> MCBrowserViewController
    {
        return browser
    }
    
    func sendChoice(_ choice: Choice)
    {
        do
        {
            let data = Data([UInt8(choice.rawValue)])
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
        catch
        {
            print("Error sending choice: \(error)")
        }
    }
    
    func sendStartRound()
    {
        let data = "startRound".data(using: .utf8)!
        do
        {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
        catch
        {
            print("Error sending start round: \(error)")
        }
    }
    
    func sendResult(_ result: GameResult) {
        let data = Data([UInt8(result.hashValue)])
        do
        {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
        catch
        {
            print("Error sending result: \(error)")
        }
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState)
    {
        switch state
        {
        case .connected:
            print("Connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
        @unknown default:
            print("Unknown state received: \(state)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)
    {
        if let string = String(data: data, encoding: .utf8), string == "startRound"
        {
            delegate?.didReceiveStartRound()
        }
        else if let choice = Choice(rawValue: Int(data[0]))
        {
            delegate?.didReceiveChoice(choice)
        }
        else if let result = GameResult.allCases.first(where: { $0.hashValue == Int(data[0]) })
        {
            delegate?.didReceiveResult(result)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID)
    {
        // Not used in this context
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress)
    {
        // Not used in this context
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?)
    {
        // Not used in this context
    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController)
    {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController)
    {
        browserViewController.dismiss(animated: true, completion: nil)
    }
}
