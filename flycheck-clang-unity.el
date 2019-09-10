(require 'flycheck)

(defgroup flycheck-clang-unity nil
  "Flycheck checker for clang unity builds")

(defcustom flycheck-clang-unity-entry nil
  "Unity build entry file"
  :type 'string
  :group 'flycheck-clang-unity)

(defcustom flycheck-clang-unity-args '()
  "Command line args to pass to clang during build (such as -std=c99)."
  :type '(repeat string)
  :group 'flycheck-clang-unity)

(flycheck-define-checker clang-unity
  "Flycheck checker for clang unity builds"
  :command ("clang"
            "-fsyntax-only"
            "-fno-color-diagnostics"
            "-fno-caret-diagnostics"
            "-fno-diagnostics-show-option"
            (eval flycheck-clang-unity-args)
            (eval flycheck-clang-unity-entry))
  :error-patterns
  ((info line-start (file-name) ":" line ":" column
         ": note: " (optional (message)) line-end)
   (warning line-start (file-name) ":" line ":" column
            ": warning: " (optional (message)) line-end)
   (error line-start (file-name) ":" line ":" column
          ": " (or "fatal error" "error") ": " (optional (message)) line-end))
  :modes (c-mode c++-mode)
  :predicate flycheck-buffer-saved-p)

;;;###autoload
(defun flycheck-clang-unity-setup ()
  (interactive)
  ;; Add to end of list, don't want to be default
  (add-to-list 'flycheck-checkers 'clang-unity t))

(provide 'flycheck-clang-unity)
