package loader;

import hxd.fs.FileSystem;
import haxe.zip.Entry;
import hxd.fs.FileEntry;

/**
 *  File system in memory
 */
class MemoryFileSystem implements FileSystem {

	/**
	 *  Root folder
	 */
	var root : MemoryFolder;

    /**
     *  Constructor
     *  @param fileTree - root folder
     */
    public function new (fileTree : MemoryFolder) {
		root = fileTree;
    }

    /**
     *  Get root dir
     *  @return FileEntry
     */
    public function getRoot () : FileEntry {
		trace ("getRoot");
		return null;
    }

	/**
	 *  Get file
	 *  @param path - 
	 *  @return FileEntry
	 */
	public function get (path : String) : FileEntry {
		var entry = root.findEntry (path);
		if (entry == null) return null;
		return entry.toFileEntry ();
    }

	/**
	 *  Check file exists
	 *  @param path - 
	 *  @return Bool
	 */
	public function exists (path : String) : Bool {
		trace (path);
		return false;
    }

	/**
	 *  Dispose all files
	 */
	public function dispose() : Void {   
		trace (dispose);
    }
}