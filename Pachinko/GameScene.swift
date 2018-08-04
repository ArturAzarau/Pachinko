//
//  GameScene.swift
//  Pachinko
//
//  Created by Артур Азаров on 03.08.2018.
//  Copyright © 2018 Артур Азаров. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private enum SlotBase {
        case good
        case bad
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Adding bouncers
        
        for i in stride(from: 0, through: 1024, by: 256) {
            let position = CGPoint(x: i, y: 0)
            makeBouncer(at: position)
        }
        
        for i in stride(from: 128, through: 640, by: 512) {
            let position = CGPoint(x: i, y: 0)
            makeSlot(at: position, slot: .good)
        }
        
        for i in stride(from: 384, through: 896, by: 512) {
            let position = CGPoint(x: i, y: 0)
            makeSlot(at: position, slot: .bad)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
            ball.position = location
            ball.physicsBody?.restitution = 0.4
            addChild(ball)
        }
    }
    
    private func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    private func makeSlot(at position: CGPoint, slot: SlotBase) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        switch slot {
        case .bad:
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
        case .good:
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: CGFloat.pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
}
