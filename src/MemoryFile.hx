import haxe.io.Bytes;
import hxd.fs.FileEntry;
import hxd.fs.BytesFileSystem;

/**
 *  File in memory
 */
class MemoryFile extends MemoryEntry {

    /**
     *  File data
     */
    public var data  : Bytes;

    /**
     *  Constructor
     *  @param name - 
     *  @param parent - 
     */
    public function new (name : String, data : Bytes, parent : MemoryFolder) {
        super (name, parent);
        this.data = data;
    }

    /**
     *  Convert to file entry
     *  @return FileEntry
     */
    override public function toFileEntry () : FileEntry {
        return new BytesFileEntry (name, data);
    }
}