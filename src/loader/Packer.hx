package loader;

import haxe.zip.Entry;

class Packer {

    #if macro
    /**
     *  Check if file need to pack
     *  @return Bool
     */
    public static function isPackFile (file : String) : Bool {
        var ext = file.split(".").pop ();
        switch (ext) {
            case "hmd" , "png" , "jpg" : return true;            
        }
        return false;
    }

    /**
     *  Return all file entries from dir
     */
    static function getAllFiles (dir : String) : List<Entry> {
        var res = new List<Entry> ();
        var files = sys.FileSystem.readDirectory (dir);
        for (fl in files) {
            var fullPath = dir + "/" + fl;
            if (sys.FileSystem.isDirectory (fullPath)) {
                var ents = getAllFiles (fullPath);
                for (e in ents) res.add (e);
                continue;
            }

            if (!isPackFile (fullPath)) continue;

            var stat = sys.FileSystem.stat (fullPath);
            var data = sys.io.File.getBytes (fullPath);

            var entry : Entry = {
                fileName : fl,
                fileSize : stat.size,
                fileTime : stat.mtime,
                compressed : false,
                dataSize : stat.size,
                data : data,
                crc32 : null
            }
            res.add (entry);
        }

        return res;
    }

    #end

    /**
     *  Create pack
     *  @param basePath - 
     *  @param options - 
     */
    public macro static function init() : haxe.macro.Expr {        
        var f = new hxd.res.FileTree(null);
        var data = f.embed(null);
        var out = new haxe.io.BytesOutput ();
        var wr = new haxe.zip.Writer (out);

        var workPath = sys.FileSystem.absolutePath (".").split("\\").join("/").split("/");
        workPath.push ("res");
        var wp = workPath.join ("/");
        var entries = getAllFiles (wp);

        var sum = 0;
        for (e in entries) {
            sum += e.fileSize;
        }

        var infoPath = wp + "/" + "packer.info";        
        if (sys.FileSystem.exists (infoPath)) {
            var info = sys.io.File.getContent (infoPath);
            var size = Std.parseInt (info);
            if (sum == size) {
                return macro null;
            } else {
                sys.io.File.saveContent (infoPath, Std.string (sum));
            }
        } else {
            sys.io.File.saveContent (infoPath, Std.string (sum));
        }

        wr.write (entries);
        sys.io.File.saveBytes ("./out/pack.zip", out.getBytes ());

        return macro null;
    }    
}