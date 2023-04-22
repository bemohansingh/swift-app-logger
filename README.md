# Logger

A logger package to log to console

# Usage

1. Since the logger is shared accross the app we just need to set the log level 
    ```swift
    Logger.current.set(with: .debug)
    ```

2. Currently there are two implemetation we have done. The logger can log URLSession response/request and simple prints.


## FUTURE ENHANCEMENT
1. We are trying to make this logger log to server as well with different app so that we can see the result of production logging for future debugging purpose

2. We probably have to make it global functions instead of shared instance, This will help us to simply call log on various types we will be using in future.
