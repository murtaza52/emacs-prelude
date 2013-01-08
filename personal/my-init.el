(require 'package)

(defvar my-packages
  '(starter-kit starter-kit-js starter-kit-lisp starter-kit-bindings clojure-mode clojure-test-mode nrepl ac-nrepl nrepl-ritz color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow python python-mode ipython anything anything-ipython anything-show-completion auto-complete yasnippet w3)
  "A list of packages to ensure are installed at launch.")

;list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(defun check-if-installed ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (check-if-installed)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;;Enabling paredit with clojure-mode
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

;; ;; Code for compiling and loading changes on change of source code.
;; (defun clojure-slime-maybe-compile-and-load-file ()
;;   "Call function `slime-compile-and-load-file' if current buffer is connected to a swank server. Meant to be used in `after-save-hook'."
;;   (when (and (eq major-mode 'clojure-mode) (slime-connected-p))
;;     (slime-compile-and-load-file)))

;;(add-hook 'after-save-hook 'clojure-slime-maybe-compile-and-load-file)

;;Enabling up and down keys
(add-hook 'prelude-prog-mode-hook
          (lambda ()
            (guru-mode -1)) t)

;;Enable line numbers in emacs
(global-linum-mode t)

;;auto-complete mode
(global-auto-complete-mode t)

;;auto-complete for nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)


;; ;;Set ipython as the shell for python.el
;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; (setq python-shell-virtualenv-path "venv/")

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/personal/blackboard.el")

;;(disable-theme 'zenburn)

(load-theme 'zenburn t)

;;Clojurescript
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
