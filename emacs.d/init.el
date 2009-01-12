;; Some of this is lifted directly from the emacs-starter-kit. I would 
;; have used it if I wasn't interested in learning something new.
(setq user-mail-address "james.herdman@gmail.com")
(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

;; Stuff that should be required always

;; Allows you to open a buffer of recently opened files
(require 'recentf)

;; Saves your place in a file, so when re-opening you start there
(require 'saveplace)

;; Translates ANSI escape sequences into faces
(require 'ansi-color)

;; Color themes for emacs are great!
(add-to-list 'load-path "~/.emacs.d/color-themer")
(require 'color-theme)
(color-theme-intialize)
(load-file "~/.emacs.d/color-themes/color-theme-sunburt.el")
(color-theme-sunburst-tm)

(add-hook 'c-mode-common-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))
