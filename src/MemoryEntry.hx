import hxd.fs.FileEntry;

/**
 *  Memory entry info
 */
class MemoryEntry {

    /**
     *  Parent folder
     */
    public var parent : MemoryFolder ;

    /**
     *  Entry Name
     */
    public var name : String;
    
    /**
     *  Constructor
     *  @param name - 
     *  @param parent - 
     */
    public function new (name : String, parent : MemoryFolder) {
        this.name = name;
        this.parent = parent;
    }

    /**
     *  Convert to file entry
     *  @return FileEntry
     */
    public function toFileEntry () : FileEntry { return null; }
}