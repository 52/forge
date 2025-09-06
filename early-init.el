;;; early-init.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Max Karou
;;
;; Author: Max Karou <maxkarou@protonmail.com>
;; URL: https://github.com/52/forge
;;
;; Licensed under MIT License, or Apache Version 2.0, at your discretion.
;;
;; MIT License: http://opensource.org/licenses/MIT
;; Apache Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
;;
;; Usage of this file is permitted solely under a sanctioned license.
;;
;;; Commentary:
;;
;;; Code:

(defvar forge--backup-gc-cons-threshold gc-cons-threshold
  "Backup of the original `gc-cons-threshold' value.")

(defvar forge--backup-gc-cons-percentage gc-cons-percentage
  "Backup of the original `gc-cons-percentage' value.")

(defvar forge--gc-cons-threshold (* 64 1024 1024)
  "Value to which `gc-cons-threshold' is set to post-startup.
This defines a moderate threshold (64 MB) for garbage collection.")

(defvar forge--gc-cons-percentage gc-cons-percentage
  "Value to which `gc-cons-percentage' is set to post-startup.
For now this maintains the default but can be adjusted if needed.")

(defun forge--gc-restore-values ()
  "Restore garbage collection thresholds after startup."
  (setq gc-cons-threshold forge--backup-gc-cons-threshold)
  (setq gc-cons-percentage forge--backup-gc-cons-percentage))

;; Temporarily increase thresholds to a maximum during startup.
;; This defers GC and speeds up initialization by avoiding frequent
;; halts at the cost of temporarily higher memory usage.
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; Schedule the restoration of the original GC values after startup.
;; This ensures the original values `forge--backup-gc-cons-threshold'
;; and `forge--backup-gc-cons-percentage' are restored after startup.
(add-hook 'emacs-startup-hook #'forge--gc-restore-values)

;; Increase the maximum amount of data read from processes in a single chunk.
;; This increases the performance for subprocess-heavy operations like LSPs
;; by reducing the overhead encountered in data transfer.
(setq read-process-output-max (* 4 1024 1024))

;; Add directories from the `EMACSTHEMEPATH' to `custom-theme-load-path'.
;; This makes themes provided by the enviroment visible to GNU Emacs.
(when-let ((theme-env (getenv "EMACSTHEMEPATH")))
  (dolist (dir (split-string theme-env path-separator t))
    (when (file-directory-p dir)
      (add-to-list 'custom-theme-load-path dir))))

;; Set the language environment to UTF-8 and disable the default input method.
;; This ensures consistent Unicode handling across GNU Emacs.
(set-language-environment "UTF-8")
(setq default-input-method nil)

;; Inhibit font compacting which can be very expensive, especially on Windows.
;; This disables it permanently, at the cost of higher memory usage.
(setq inhibit-compacting-font-caches t)

;; <todo>
;; <todo>
(push '(menu-bar-lines . 0) default-frame-alist)
(setq menu-bar-mode nil)

;; <todo>
;; <todo>
(push '(tool-bar-lines . 0) default-frame-alist)
(setq tool-bar-mode nil)

;; <todo>
;; <todo>
(push '(vertical-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

(when (and (not (daemonp)) (not noninteractive))
  ;; Prevent GNU Emacs from resizing the frame when changing the font.
  (setq frame-inhibit-implied-resize t)

  ;; Prevent GNU Emacs from resizing itself to a specific column size.
  (setq frame-inhibit-implied-resize t)

  ;; Inhibit an unnecessary pass over `auto-mode-alist'
  (setq auto-mode-case-fold nil)

  ;; Disable the vanilla splash screen to streamline startup.
  (setq inhibit-startup-screen t)

  ;; Forcefully surpress the vanilla startup screen completely.
  ;; Without this the screen would still initialize despite `inhibit-startup-screen'.
  (advice-add #'display-startup-screen :override #'ignore)

  ;; Surpress the "For information about GNU Emacs..." message.
  (setq inhibit-startup-echo-area-message user-login-name)

  ;; Remove the "For information about GNU Emacs..." line in *Messages*.
  (advice-add #'display-startup-echo-area-message :override #'ignore)

  ;; Initialize the scratch buffer in `fundamental-mode'.
  (setq initial-major-mode 'fundamental-mode)

  ;; Start with an empty `*scratch*' buffer.
  (setq initial-scratch-message nil))

;;; early-init.el ends here
