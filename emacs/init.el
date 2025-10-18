(require 'package)

;; Add NonGNU ELPA as an archive
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

;; Initialize package system (if not already done)
(package-initialize)

(require 'xah-fly-keys)
(xah-fly-keys-set-layout "qwerty")
(xah-fly-keys 1)
;; enable good old vim movement
(define-key xah-fly-key-map (kbd "j") 'next-line)       ; j to move down
(define-key xah-fly-key-map (kbd "k") 'previous-line)   ; k to move up
(define-key xah-fly-key-map (kbd "h") 'backward-char)   ; h to move left
(define-key xah-fly-key-map (kbd "l") 'forward-char)    ; l to move right

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; disable ui elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

(load-theme 'modus-vivendi t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(xah-fly-keys)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
