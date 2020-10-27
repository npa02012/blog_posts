## Git Pull in Python

The *GitPython* package can be used to interact with a git repositories. Installation:

```shell
pip install GitPython
```

Example Usage:  

```python
import git
PATH_repo = '/home/nick/blog_posts/' # Path to your local git repo
g = git.cmd.Git(PATH_repo)
git_status = g.pull()
print(git_status)

Out:
-------------------------
Already up to date.
```

The above snippet would perform a git pull on my *blog_posts* repo.  

### Thoughts

In my opinion, there are not many use cases where you would want to be executing git commands within your Python code. When I have done so, there has always been a better solution - git is not a good tool to rely on in production. On the other hand, git can provide quick functionality to use in development.  

Suppose you want your customer to have the option to update to your latest software release. Using *GitPython* you can devise a function to *pull* the latest software. It would be easy to setup - you are able to rely on git to handle retrieving the latest changes, authentication, and other background processes.  

To be clear, I would not recommend to rely on this in production. The process is quite fragile and very inflexible. A more optimal solution is download and pip install python tarball packages from an S3 bucket.

## Pip Install in Python

The code snippet below will pip install the tarball at *PATH_tarball*.

```python
import subprocess
PATH_tarball = '/home/nick/blog_posts-1.0.0.tar.gz'
subprocess.check_call([sys.executable, '-m', 'pip', 'install', PATH_tarball])
```

Some notes:  

* If the main process is already running in a virtual environment, then the subprocess will install the package into the virtual environment.
* Powering off (i.e. unplugging) your computer while the subprocess is running can cause big problems with your pip installation software.
* To my knowledge, this is a satisfactory method to use in production.



