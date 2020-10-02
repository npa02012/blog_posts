## Thread Safe Iterators

Accessing iterators is not thread safe. In the following code block, we show that using multiple threads to print elements of a range object results in the elements being printed multiple times. Note the following:  

*  The output may be different on each run.
*  If the variable **not\_thread\_safe\_it** was thread safe, then 0 and 1 to get printed only once.
*  We are setting the number of threads to 3.
*  The commented code will join the threads.

```python
import threading

not_thread_safe_it = range(2)

def task(it):
    for i in it:
        print(i)
        
n_threads = 3
threads = [None]*n_threads

for i in range(n_threads):
    threads[i] = threading.Thread(target=task, args=(not_thread_safe_it,))
    threads[i].start()
    
#for t in threads:
#    t.join()

Out:
-------------------------   
0
0
1
0
1
1
```

### The 'Easy' Way Out

If size of the iterator you are trying to access is less than the number of threads you are willing to create, then you can create a single thread for each element of the iterator.

```python
import threading

not_thread_safe_it = range(2)

def task(i):
    print(i)
        

threads = [threading.Thread(target=task, args=(i,)) for i in not_thread_safe_it]

for t in threads:
    t.start()
    
Out:
-------------------------   
0
1
```
 
This method solves the problem at hand; however, the threads are not actually accessing the iterator. If your iterator is large, many threads will be created - this is probably not ideal.  

In the following section, we will cover how to allow threads to safely access your iterator.

### Thread Safe Class

The following class will allow us to make an iterable object thread safe.  

The key for thread-safety is the *threading.Lock* object. When *\__next\__* is called, each thread will have to wait to *aquire* the lock before obtaining the next element of the iterator. Likewise, a release lock is not *released* by a thread until the iterator has passed it's next element.

The *try* statement is used in case the iterator has been exhausted.

```python
class thread_safe_iterator():
    def __init__(self, it):
        self.it = it.__iter__()
        self.lock = threading.Lock()

    def __iter__(self):
        return(self)

    def __next__(self):
        self.lock.acquire()
        try:
            return(self.it.__next__())
        finally:
            self.lock.release()
```

To make your iterator object thread safe, wrap it in the thread\_safe\_iterator class:

```python
sample_it = range(2)
safe_it = thread_safe_iterator(sample_it)
print(next(safe_it))
print(next(safe_it))

Out:
------------------------- 
0
1
```

### Simple Example

The following code block uses the *thread\_safe\_iterator* class to print the elements of a range object using threading.

```python
safe_it = thread_safe_iterator(range(10))

def task(it):
    for i in it:
        print(i)
        
n_threads = 5
threads = [None]*n_threads

for i in range(n_threads):
    threads[i] = threading.Thread(target=task, args=(safe_it,))
    threads[i].start()

Out:
-------------------------  
0
1
2
3
4
5
6
7
8
9
```

### Complex Example

In the following code block, we simulate a more complex function acting upon an iterator by using *time.sleep* to increase computation time.  

The point of this exercise is to show that although each element of the iterator is printed as in the previous example, threading is being leveraged to increase the speed at which all of the elements get printed. We also get to see which threads are printing which elements.

```python
import time
import random
random.seed(1)

def task(it, it_index):
    for i in it:
        time.sleep(round(random.random(), 2))
        print('Printing from Thread ' + str(it_index) + ': ' + str(i))
        
sample_it = thread_safe_iterator(range(10))
n_threads = 5

threads = [None]*n_threads
for i in range(n_threads):
    threads[i] = threading.Thread(target=task, args=(sample_it, i))
    threads[i].start()

Out:
-------------------------    
Printing from Thread 0: 0
Printing from Thread 3: 3
Printing from Thread 4: 4
Printing from Thread 0: 5
Printing from Thread 0: 8
Printing from Thread 0: 9
Printing from Thread 2: 2
Printing from Thread 1: 1
Printing from Thread 3: 6
Printing from Thread 4: 7
```

Notice here that the elements are not printed in order (0 &#8594; 10). This is expected, but may raise complexity in certain situations. We would need to account for this if we required a mapping from our *thread\_safe\_iterator* object to return values from the threading *target* function.  

Returning values from threads and its complexities are overviewed in [this blog post](https://github.com/npa02012/blog_posts/tree/master/returning_from_threads).

