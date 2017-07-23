package loader;

/**
 *  Folder in memory
 */
class MemoryFolder extends MemoryEntry {

    /**
     *  Child entries
     */
    public var childs (default, null) : Array<MemoryEntry>;

    /**
     *  Constructor
     *  @param name - 
     *  @param parent - 
     */
    public function new (name : String, parent : MemoryFolder) {
        super (name, parent);
        childs = new Array<MemoryEntry> ();
    }

    /**
     *  Find entry recursive
     *  @return MemoryEntry
     */
    public function findEntry (path : String) : MemoryEntry {
        // TODO recursive find
        trace (path);
        if (childs == null || childs.length < 1) return null;
        for (c in childs) {
            if (c.name == path) return c;
        }

        return null;
    }
}