package loader;

import haxe.macro.Context;
import haxe.macro.Expr;

class FileTree {

    /**
     *  Position
     */
    var pos : Position;

    /**
     *  Working dir
     */
    var dir : String;

    /**
     *  Process folder
     *  @param name - 
     *  @return Array<Field>
     */
    function processFolder (name : String) : Array<Field> {
        var fields = new Array<Field> ();

        var files = sys.FileSystem.readDirectory (name);

        for (f in files) {
            var fullPath = name + "/" + f;
            if (sys.FileSystem.isDirectory (fullPath)) {
                var fs = processFolder (fullPath);
                for (f in fs) fields.push (f);
            } else {
                if (!loader.Packer.isPackFile (f)) continue;                
                fields.push (processFile (f));
            }
        }

        return fields;
    }

    /**
     *  Process file
     *  @param name - 
     *  @return Field
     */
    function processFile (name : String) : Field {
        var nm = name.split (".").join ("_");

        var nfield : Field = {
            name : nm,
            pos : pos,
            access : [AStatic, APublic, AInline],
            kind: FieldType.FVar(macro:String, macro $v{name}),
        };

        return nfield;
    }

    /**
     *  Constructor
     *  @param dir - 
     */
    public function new (?dir : String) {
        pos = Context.currentPos();

        if (dir == null) {
            this.dir = sys.FileSystem.absolutePath (".").split ("\\").join ("/") + "/" + "res";
        } else {
            this.dir = dir;
        }
    }

    public function scan () : Array<Field> {
        var fields = Context.getBuildFields();

        var fs = processFolder (dir);        
        for (f in fs) fields.push (f);

        return fields;
    }

    /**
     *  Scan folder for resources
     *  @param dir - 
     */
    public static function build (?dir : String) : Array<Field> {
		return new FileTree(dir).scan();
	}
}