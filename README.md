**Note:** [Rtags](https://github.com/Andersbakken/rtags) appears to handle unity builds correctly.
I'd suggest using it instead.


Very basic flycheck integration for handling clang projects that use a unity build.
~~Every other flycheck integration I could find does not work for unity builds~~
*[Rtags](https://github.com/Andersbakken/rtags) seems to work.*

This will not activate by default, so you shouldn't have issues using it alongside
other c/c++ checkers.

This won't work with gcc by default but wouldn't take long to adjust to doing so.
If you somehow come across the repo and want to use it with gcc submit an issue.

#### Usage
The easiest way to use this is with a [.dir-locals.el](https://www.gnu.org/software/emacs/manual/html_node/emacs/Directory-Variables.html)
file in your project root that looks something like this:
```
((c-mode
  (flycheck-checker . clang-unity)
  (flycheck-clang-unity-entry . "~/code/project/src/main.c")
  (flycheck-clang-unity-args . ("-Wall"
                                "-Wextra"
                                "-pedantic"
                                "-std=c99"))))
```

#### Setup
```elisp
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-clang-unity-setup))
```

#### Configuration
It exposes the following variables for configuration:

*flycheck-clang-unity-entry* **required**  
Entry point file for the build. Can use a relative path with only one level
of file structure, but better off just using an exact path.

*flycheck-clang-unity-args*  
List of flags to be passed to clang such as `-Wall`

