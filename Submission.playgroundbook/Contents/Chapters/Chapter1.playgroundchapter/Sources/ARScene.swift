import ARKit
import SceneKit

public class ARFactoryScene: NSObject{
    public let view: ARSCNView
    
    public init(scene: FactoryScene){
        let frame = CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0)
        view = ARSCNView(frame: frame)
        
        super.init()
        
        view.scene = scene.scene!
        view.setup()
        view.session.delegate = self
        view.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ARSCNView{
    func setup(){
        
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = false
        preferredFramesPerSecond = 60
        contentScaleFactor = 1.3
        
        debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        session = ARSession()
        let tracking = ARWorldTrackingConfiguration()
        tracking.planeDetection = .horizontal
        session.run(
            tracking,
            options: [
                .resetTracking,.removeExistingAnchors
            ]
        )
        
        if let camera = pointOfView?.camera{
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = -1
            camera.minimumExposure = -1
            camera.maximumExposure = 3
        }
    }
}
extension ARFactoryScene: ARSCNViewDelegate{
    
}
extension ARFactoryScene: ARSessionDelegate{
    public func session(_ session: ARSession,
                        didAdd anchors: [ARAnchor]){
        if let anchor = anchors.first{
            view.scene.rootNode.position = SCNVector3(
                anchor.transform.columns.3.x,
                anchor.transform.columns.3.y,
                anchor.transform.columns.3.z
            )
        }
        
    }
}
