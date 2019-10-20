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
        runPlayer = buildSprite(initialFrame: runPlayerFrames[0], width: 100, height: 100, x: size.width * 0.1, y: size.height * 0.5)
        addChild(runPlayer)
        animateSprite(sprite: runPlayer, frames: runPlayerFrames, key: "runPlayer")
        runPlayer.run(SKAction.hide())
    
        runPlayer.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1),
                SKAction.unhide(),
                SKAction.run({
                    self.idlePlayer.run(SKAction.hide())
                }),
                SKAction.move(
                    to: CGPoint(x: size.width * 1.1, y: size.height * 0.5),
                    duration: TimeInterval(2)
                ),
                SKAction.scaleX(to: -1, duration: 0.0),
                SKAction.move(
                    to: CGPoint(x: size.width * 0.1, y: size.height * 0.5),
                    duration: TimeInterval(2)
                ),
                SKAction.scaleX(to: 1, duration: 0.0),
                SKAction.hide(),
                SKAction.run {
                    self.idlePlayer.run(SKAction.unhide())
                }
            ])
        )
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
