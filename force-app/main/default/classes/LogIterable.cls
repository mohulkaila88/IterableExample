public  class LogIterable implements Iterable<LogIterator.LogEntry> {
    private List<String> logEntries;

    public LogIterable(List<String> logEntries) {
        this.logEntries = logEntries;
    }

    public Iterator<LogIterator.LogEntry> iterator() {
        return new LogIterator(logEntries);
    }
}