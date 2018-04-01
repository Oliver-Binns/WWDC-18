import ARKit
import SceneKit
import PlaygroundSupport

public class ARFactoryScene: FactoryScene{
    private let view: ARFactoryView
    
    public init(){
        let frame = CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0)
        view = ARFactoryView(frame: frame)
        super.init(scene: SCNScene())

        view.scene = self.scene!
        view.factory = self
        
        view.setup()
        view.session.delegate = self
    }
    
    public func getView() -> ARSCNView{
        return view
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ARFactoryScene: ARSessionDelegate{
    public func session(_ session: ARSession,
                        didAdd anchors: [ARAnchor]){
        for anchor in anchors{
            guard let anchor = anchor as? ARPlaneAnchor else { continue }
            //session.setWorldOrigin(relativeTransform: matrix_float4x4)
        }
        
    }
}

private class ARFactoryView: ARSCNView, PlaygroundLiveViewMessageHandler{
    var factory: FactoryScene?
    
    public func receive(_ message: PlaygroundValue){
        factory?.receive(message)
    }
}
extension ARSCNView{
    func setup(){
        
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = false
        preferredFramesPerSecond = 60
        
        debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        session = ARSession()
        let tracking = ARWorldTrackingConfiguration()
        tracking.planeDetection = .horizontal
        session.run(
            tracking,
            options: [
                .resetTracking,
                .removeExistingAnchors
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

