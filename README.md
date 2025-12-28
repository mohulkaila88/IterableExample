# Salesforce Apex Iterable & Iterator Pattern Example

A practical implementation of the **Iterable** and **Iterator** design patterns in Salesforce Apex, demonstrating how to process custom data sources in Batch Apex jobs.

## 🎯 Overview

This project showcases how to use custom iterators with `Database.Batchable` to process non-standard data sources (like log entries from an external API) instead of traditional SOQL queries.

## 📁 Project Structure

```
force-app/main/default/classes/
├── LogIterator.cls          # Custom Iterator implementation
├── LogIterable.cls          # Custom Iterable wrapper
└── LogProcessorBatch.cls    # Batch Apex job using custom iterable
```

## 🔧 Classes Explained

### 1. LogIterator.cls

The core iterator class that implements `Iterator<LogEntry>`. It parses raw log strings into structured `LogEntry` objects.

**Key Features:**
- Implements the `Iterator<LogEntry>` interface
- Contains an inner `LogEntry` class to represent parsed log data
- Handles malformed log entries gracefully
- Parses CSV-formatted log strings: `timestamp,severity,message`

### 2. LogIterable.cls

A wrapper class that implements `Iterable<LogIterator.LogEntry>`, allowing the iterator to be used with Batch Apex.


### 3. LogProcessorBatch.cls

The Batch Apex job that processes log entries using the custom iterable. It demonstrates:
- Using `Database.Batchable<LogIterator.LogEntry>` with a custom type
- Implementing `Database.Stateful` to maintain state across batches
- Returning an `Iterable` from the `start()` method instead of a `QueryLocator`


## 📊 Log Entry Format

**Example:**
```
2023-10-01 10:00:00,Error,Null Pointer
2023-10-01 10:01:00,Warning,Potential null pointer
2023-10-01 10:02:00,Info,Log message
```

## 💡 Why Use Custom Iterables?

| Traditional Batch | Custom Iterable Batch |
|-------------------|----------------------|
| Limited to SOQL queries | Process any data source |
| Max 50M records from QueryLocator | Limited by heap size |
| Can only iterate SObjects | Can iterate custom objects |
| Tied to Salesforce data | Can process external API data |

### Use Cases for Custom Iterables:
- Processing data from external REST/SOAP APIs
- Parsing CSV files or log data
- Iterating over complex data structures
- Processing data that doesn't exist in Salesforce

## ⚠️ Limitations

When using custom iterables with Batch Apex:
- **Heap Size Limit**: The entire iterable must fit in memory (6MB sync / 12MB async)
- **Batch Size**: Maximum 2,000 records per `execute()` call when using Iterable
- **No QueryLocator**: Cannot use `Database.QueryLocator` features like `getQuery()`

**Author:** Mohul Kaila  
**Repository:** [IterableExample](https://github.com/mohulkaila88/IterableExample)
