class TestApp extends hxd.App {

    /**
     *  Assets manager
     */
    var assets : Assets;

    function onLoaded () {        
        var obj = assets.getModel ("R_Model_FBX.hmd");
        obj.scale (0.03);
        obj.playAnimation (assets.getAnimation ("R_Model_FBX.hmd"));
        s3d.addChild (obj);

        var dir = new h3d.scene.DirLight(new h3d.Vector(0.2, 0.3, -1), s3d);        
        dir.color.set(0.35, 0.35, 0.35);
        
        s3d.camera.zNear = 1;
        s3d.camera.zFar = 30;

        new h3d.scene.CameraController (5, s3d).loadFromCamera ();
    }

    /**
     *  On app init
     */
    override function init () : Void {
        assets = new Assets ();
        assets.onLoaded = onLoaded;
        assets.loadPack ("pack.zip");        
    }
}