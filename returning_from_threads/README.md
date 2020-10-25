## Returning From Threads

In this post, we demonstrate how to use the **concurrent.futures** module to return values from worker threads back to the main thread. This post pulls ideas from [this stackoverflow question](https://stackoverflow.com/questions/6893968/how-to-get-the-return-value-from-a-thread-in-python/40344234), which includes further discussion and alternate solutions.  

### Example Execution

The following code block provides a simple example of returning from worker threads and also demonstrates when a task is actually ran.

```python
import concurrent.futures
import time

def task(p):
    time.sleep(1)
    return(p)

T = concurrent.futures.ThreadPoolExecutor()
future = T.submit(task, p='Test')
print(future.running())
print(future.result())
print(future.running())
T.shutdown()

Out:
-------------------------
True
Test
False
```

Note that *True* prints immediately while *Test* and *False* are printed a second later. This means that the the task is run immediately upon calling **T.submit()**, meanwhile the main thread continues to run. When we call **future.result()**, the main thread then waits for the task to finish.  

Also note that it is good practice to call **T.shutdown()**.

### Multiple Tasks

Below, we demonstrate how to quickly run multiple tasks for a variety of paramters.

```python
import concurrent.futures
import time
import random
random.seed(4)

def task(p):
    time.sleep(random.random())
    print(p)
    return(p)

T = concurrent.futures.ThreadPoolExecutor()
futures = [T.submit(task, p) for p in [0, 1, 2]]
print([f.result() for f in futures])
T.shutdown()

Out:
-------------------------
1
0
2
[0, 1, 2]
```

Take note of the printing order. Although the tasks did not finish in the order they were submitted, we are still able to obtain the results in the correct order.

### Limiting the Number of Threads

Below, we demonstrate using the **max_workers** arguement when creating the *Executor* in order to limit the number of threads that are ran at once. This would be desirable in the case that many tasks have to be completed.

```python
import concurrent.futures
import threading
import time
import random
random.seed(4)

print('Starting # of threads - ' + str(threading.active_count()))

def task(p):
    time.sleep(random.random())
    print('Current # of threads - ' + str(threading.active_count()))
    return(p)

T = concurrent.futures.ThreadPoolExecutor(max_workers=2)
futures = [T.submit(task, p) for p in range(5)]
T.shutdown()
print('Final # of threads - ' + str(threading.active_count()))

Out:
-------------------------
Starting # of threads - 1
Current # of threads - 3
Current # of threads - 3
Current # of threads - 3
Current # of threads - 3
Current # of threads - 2
Final # of threads - 1
```

### Threads not Shutting Down

While writing this post, I noticed a potentially troublesome characteristic when using the *ThreadPoolExecutor*. Threads are not killed until the **shutdown** method on the *Executor* is called. Consider the following example:

```python
import concurrent.futures
import threading
import time

print('Starting # of threads - ' + str(threading.active_count()))

def task(p):
    return(p)

T = concurrent.futures.ThreadPoolExecutor()
futures = [T.submit(task, p) for p in range(5)]
print([f.result() for f in futures])
time.sleep(1)
print('Current # of threads - ' + str(threading.active_count()))
T.shutdown()
print('Final # of threads - ' + str(threading.active_count()))

Out:
-------------------------
Starting # of threads - 1
[0, 1, 2, 3, 4]
Current # of threads - 6
Final # of threads - 1
```
Even though all of our tasks have finished (we use **time.sleep** to ensure they are really complete), we still have 6 active threads before calling **T.shutdown()**.  

However, if we call **T.shutdown()** immediately, we can still gather our results and treads seem to be shutdown.

```python
import concurrent.futures
import threading

print('Starting # of threads - ' + str(threading.active_count()))

def task(p):
    return(p)

T = concurrent.futures.ThreadPoolExecutor()
futures = [T.submit(task, p) for p in range(5)]
T.shutdown()
print('Current # of threads - ' + str(threading.active_count()))
print([f.result() for f in futures])
print('Final # of threads - ' + str(threading.active_count()))

Out:
-------------------------
Starting # of threads - 1
Current # of threads - 1
[0, 1, 2, 3, 4]
Final # of threads - 1
```

I am no expert with threading, but immediately calling **T.shutdown()** feels undesirable. Even if it is okay, I suspect threads are not killed until all worker threads are complete. On the other hand, the example under [Limiting the Number of Threads](#Limiting-the-Number-of-Threads) provides evidence otherwise.  

I won't go under the hood of the Executor to explore this behavior, but it may make for an interesting post in the future.




