//
//  GameScene.swift
//  Sunny Land
//
//  Created by Jacob Clark on 20/10/2019.
//  Copyright © 2019 Jacob Clark. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var idlePlayer = SKSpriteNode()
    private var idlePlayerFrames: [SKTexture] = []
    
    private var runPlayer = SKSpriteNode()
    private var runPlayerFrames: [SKTexture] = []

    override func didMove(to view: SKView) {
        idlePlayerFrames = buildTextureAtlasForImageCollection(name: "idle")
        idlePlayer = buildSprite(initialFrame: idlePlayerFrames[0], width: 100, height: 100, x: size.width * 0.1, y: size.height * 0.5)
        addChild(idlePlayer)
        animateSprite(sprite: idlePlayer, frames: idlePlayerFrames, key: "idlePlayer")
        
        runPlayerFrames = buildTextureAtlasForImageCollection(name: "run")
        runPlayer = buildSprite(initialFrame: runPlayerFrames[0], width: 100, height: 100, x: size.width * 0.4, y: size.height * 0.5)
        addChild(runPlayer)
        animateSprite(sprite: runPlayer, frames: runPlayerFrames, key: "runPlayer")
    }
    
    func buildTextureAtlasForImageCollection(name: String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: name)
        let numberOfFrames = textureAtlas.textureNames.count

        var frames: [SKTexture] = []
        
        for i in 1...numberOfFrames {
            frames.append(
                textureAtlas.textureNamed("player-\(name)-\(i)")
            )
        }

        return frames
    }
    
    func buildSprite(initialFrame: SKTexture, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) -> SKSpriteNode {
        let sprite = SKSpriteNode(texture: initialFrame)
        sprite.position = CGPoint(x: x, y: y)
        sprite.size = CGSize(width: width, height: height)
        return sprite
    }
    
    func animateSprite(sprite: SKSpriteNode, frames: [SKTexture], key: String) {
        sprite.run(
            SKAction.sequence([
                SKAction.repeatForever(
                    SKAction.animate(
                        with: frames,
                        timePerFrame: 0.1,
                        resize: false,
                        restore: true
                    )
                ),
            ]),
            withKey: key
        )
    }
}
