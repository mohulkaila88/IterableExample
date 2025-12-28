public class LogIterator implements Iterator<LogEntry> {
    private List<String> logEntries;
    private Integer currentIndex;

    public LogIterator(List<String> logEntries) {
        this.logEntries = logEntries;
        this.currentIndex = 0;
    }

    public boolean hasNext() {
        return currentIndex < logEntries.size();
    }

    public LogEntry next() {
        if (!hasNext()) { 
            throw new NoSuchElementException();
        }
        try {
            List<String> logEntryParts = logEntries.get(currentIndex++).split(',');
            if(logEntryParts.size() != 3) {
                return null;
            }
            LogEntry logEntry = new LogEntry(logEntryParts);
            return logEntry;
        } catch (Exception e) {
            currentIndex++;
            return next();
        }
        
    }

    public class LogEntry {
        public Datetime logTime {get; set;}
        public String severity {get; set;}
        public String message {get; set;}

        public LogEntry(List<String> logEntryParts) {
            this.logTime = Datetime.parse(logEntryParts[0]);
            this.severity = logEntryParts[1];
            this.message = logEntryParts[2];
        }
    }
}
